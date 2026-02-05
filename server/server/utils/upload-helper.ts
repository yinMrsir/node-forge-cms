import { join } from 'path';
import { writeFile } from 'fs/promises';
import dayjs from 'dayjs';
import { UPLOAD_LOCK_KEY } from '~~/server/contants/redis.contant';

const { uploadPath, imgHost } = useRuntimeConfig();
const redis = useStorage('redis');

// Redis锁的键名和过期时间（10分钟）
const LOCK_EXPIRE_TIME = 600; // 10分钟

// 获取分布式锁
export async function acquireLock(): Promise<boolean> {
  try {
    // 先检查锁是否已存在
    const existingLock = await redis.getItem(UPLOAD_LOCK_KEY);
    if (existingLock) {
      console.log('锁已存在，有任务正在进行');
      return false;
    }

    // 使用 SETNX 原子操作设置锁
    const now = Date.now();
    await redis.setItem(
      UPLOAD_LOCK_KEY,
      {
        locked: true,
        timestamp: now
      },
      {
        ttl: LOCK_EXPIRE_TIME
      }
    );

    // 再次检查，确保是我们设置的锁
    const lock = (await redis.getItem(UPLOAD_LOCK_KEY)) as any;
    if (lock && lock.timestamp === now) {
      console.log('成功获取分布式锁');
      return true;
    }

    return false;
  } catch (error) {
    console.error('Failed to acquire lock:', error);
    return false;
  }
}

// 释放锁
export async function releaseLock(): Promise<void> {
  try {
    await redis.removeItem(UPLOAD_LOCK_KEY);
    console.log('成功释放分布式锁');
  } catch (error) {
    console.error('Failed to release lock:', error);
  }
}

// 下载并保存图片的函数
export async function downloadAndSaveImage(imageUrl: string, shareServices: any): Promise<string | null> {
  try {
    if (!imageUrl || imageUrl.trim() === '') {
      return null;
    }

    // 如果是相对路径或已经是本站地址，直接返回
    if (imageUrl.startsWith('/') || imageUrl.includes(imgHost)) {
      return imageUrl;
    }

    // 下载图片
    const response = await fetch(imageUrl);
    if (!response.ok) {
      console.error(`Failed to download image: ${imageUrl}`);
      return null;
    }

    const arrayBuffer = await response.arrayBuffer();
    const buffer = Buffer.from(arrayBuffer);

    // 获取文件扩展名
    const contentType = response.headers.get('content-type');
    let fileExtension = 'jpg'; // 默认扩展名

    if (contentType) {
      const mimeToExt: Record<string, string> = {
        'image/jpeg': 'jpg',
        'image/jpg': 'jpg',
        'image/png': 'png',
        'image/gif': 'gif',
        'image/webp': 'webp',
        'image/svg+xml': 'svg'
      };
      fileExtension = mimeToExt[contentType] || 'jpg';
    } else {
      // 尝试从URL中提取扩展名
      const urlMatch = imageUrl.match(/\.([a-zA-Z0-9]+)(\?|$)/);
      if (urlMatch) {
        fileExtension = urlMatch[1];
      }
    }

    // 创建目录和文件路径
    const currentDate = dayjs().format('YYYY-MM-DD');
    const dir = `files${uploadPath}/${currentDate}`;
    shareServices.createDirectorySync(dir);
    const fileName = `/${shareServices.generateRandomValue(9)}.${fileExtension}`;
    const filePath = join(process.cwd(), dir, fileName);

    // 保存图片
    await writeFile(filePath, buffer as any);

    // 返回新的图片URL
    return `${imgHost}${uploadPath}/${currentDate}${fileName}`;
  } catch (error) {
    console.error(`Error downloading image from ${imageUrl}:`, error);
    return null;
  }
}
