# 动态路由使用指南

## 概述

NodeForgeCMS 现在支持**多级栏目**和**详情页**的动态路由功能。您可以：
1. 在数据库中为每个栏目设置 `urlKey`（如 `works`、`infos`、`web-design`）
2. 为每个栏目指定 `templateType`（列表页模板，如 `news`、`products`）
3. 为每个栏目指定 `detailTemplateType`（详情页模板，如 `news-detail`、`products-detail`）
4. 支持多级栏目路径（如 `/works/web-design`）
5. 系统自动识别列表页和详情页（路径最后一段是数字则为详情页）

## 数据库字段说明

### category 表新增字段：

| 字段 | 类型 | 说明 | 示例 |
|------|------|------|------|
| `url_key` | varchar(100) | URL路径标识（唯一） | works, infos, web-design |
| `template_type` | varchar(50) | 列表页模板类型 | news, products, about |
| `detail_template_type` | varchar(50) | 详情页模板类型 | news-detail, products-detail |

## 路由规则

### 列表页路由
- `/works` → 一级栏目列表页
- `/works/web-design` → 二级栏目列表页
- `/works/web-design/brand` → 三级栏目列表页

### 详情页路由
- `/works/123` → 一级栏目下的详情页（ID: 123）
- `/works/web-design/456` → 二级栏目下的详情页（ID: 456）

**识别规则**：路径最后一段是纯数字时，系统会将其识别为详情页。

## 使用步骤

### 1. 应用数据库迁移

```bash
cd server
pnpm sql-push  # 将更改推送到数据库
```

### 2. 在数据库中添加栏目数据

#### 示例 1：单级栏目

```sql
-- 添加一个作品展示栏目
INSERT INTO category (
  category_name,
  category_type,
  parent_category_id,
  url_key,
  template_type,
  detail_template_type,
  status,
  del_flag,
  create_by,
  create_time,
  update_by,
  update_time
) VALUES (
  '{"zh": "作品展示", "en": "Works"}',
  '1',
  0,
  'works',
  'news',
  'news-detail',
  '1',
  '0',
  'admin',
  NOW(),
  'admin',
  NOW()
);
```

访问路径：
- `/works` → 使用 `news/index.vue` 渲染列表
- `/works/123` → 使用 `news/[id].vue` 渲染详情

#### 示例 2：多级栏目

```sql
-- 1. 添加一级栏目"作品展示"
INSERT INTO category (
  category_name,
  category_type,
  parent_category_id,
  url_key,
  template_type,
  detail_template_type,
  status,
  del_flag,
  order_num,
  create_by,
  create_time,
  update_by,
  update_time
) VALUES (
  '{"zh": "作品展示", "en": "Works"}',
  '1',
  0,
  'works',
  'news',
  'news-detail',
  '1',
  '0',
  1,
  'admin',
  NOW(),
  'admin',
  NOW()
);

-- 获取刚插入的 ID（假设为 1）
SET @parent_id = LAST_INSERT_ID();

-- 2. 添加二级栏目"网页设计"
INSERT INTO category (
  category_name,
  category_type,
  parent_category_id,
  url_key,
  template_type,
  detail_template_type,
  status,
  del_flag,
  order_num,
  create_by,
  create_time,
  update_by,
  update_time
) VALUES (
  '{"zh": "网页设计", "en": "Web Design"}',
  '1',
  @parent_id,
  'web-design',
  'news',
  'news-detail',
  '1',
  '0',
  1,
  'admin',
  NOW(),
  'admin',
  NOW()
);

-- 3. 添加二级栏目"品牌设计"
INSERT INTO category (
  category_name,
  category_type,
  parent_category_id,
  url_key,
  template_type,
  detail_template_type,
  status,
  del_flag,
  order_num,
  create_by,
  create_time,
  update_by,
  update_time
) VALUES (
  '{"zh": "品牌设计", "en": "Brand Design"}',
  '1',
  @parent_id,
  'brand-design',
  'news',
  'news-detail',
  '1',
  '0',
  2,
  'admin',
  NOW(),
  'admin',
  NOW()
);
```

访问路径：
- `/works` → 作品展示列表页
- `/works/web-design` → 网页设计列表页
- `/works/web-design/123` → 网页设计详情页（ID: 123）
- `/works/brand-design` → 品牌设计列表页
- `/works/brand-design/456` → 品牌设计详情页（ID: 456）

#### 示例 3：产品栏目

```sql
-- 添加解决方案栏目
INSERT INTO category (
  category_name,
  category_type,
  parent_category_id,
  url_key,
  template_type,
  detail_template_type,
  status,
  del_flag,
  create_by,
  create_time,
  update_by,
  update_time
) VALUES (
  '{"zh": "解决方案", "en": "Solutions"}',
  '2',
  0,
  'solutions',
  'products',
  'products-detail',
  '1',
  '0',
  'admin',
  NOW(),
  'admin',
  NOW()
);
```

访问路径：
- `/solutions` → 使用 `products/index.vue` 渲染列表
- `/solutions/789` → 使用 `products/[id].vue` 渲染详情

## 可用模板类型

### 列表页模板

| template_type | 模板文件 | 说明 |
|---------------|----------|------|
| `news` | pages/news/index.vue | 新闻列表模板 |
| `products` | pages/products/index.vue | 产品列表模板 |
| `about` | pages/about/index.vue | 关于页面模板 |

### 详情页模板

| detail_template_type | 模板文件 | 说明 |
|----------------------|----------|------|
| `news-detail` | pages/news/[id].vue | 新闻详情模板 |
| `products-detail` | pages/products/[id].vue | 产品详情模板 |

## 自定义模板

### 添加新的列表页模板

1. 在 `app/pages/` 下创建新的模板目录和文件
2. 在 `app/pages/[...slug].vue` 的 `templateMap` 中添加映射

```typescript
// app/pages/[...slug].vue
const templateMap: Record<string, () => Promise<any>> = {
  news: () => import('./news/index.vue'),
  products: () => import('./products/index.vue'),
  about: () => import('./about/index.vue'),
  // 添加自定义列表模板
  custom: () => import('./custom/index.vue')
};
```

3. 在数据库中设置 `template_type = 'custom'`

### 添加新的详情页模板

1. 创建详情页模板文件（如 `app/pages/custom/[id].vue`）
2. 在 `app/pages/[...slug].vue` 的 `detailTemplateMap` 中添加映射

```typescript
const detailTemplateMap: Record<string, () => Promise<any>> = {
  'news-detail': () => import('./news/[id].vue'),
  'products-detail': () => import('./products/[id].vue'),
  // 添加自定义详情模板
  'custom-detail': () => import('./custom/[id].vue')
};
```

3. 在数据库中设置 `detail_template_type = 'custom-detail'`

## 模板 Props

### 列表页模板接收的 Props

```typescript
const props = defineProps<{
  category?: any;      // 栏目信息
  urlKey?: string;     // URL 标识
}>();
```

### 详情页模板接收的 Props

```typescript
const props = defineProps<{
  category?: any;         // 栏目信息
  contentId?: number;     // 内容 ID（来自路径的数字）
}>();
```

## 注意事项

1. **路由优先级**：静态路由（如 `/news`、`/products`）优先级高于动态路由
2. **唯一性**：`url_key` 字段有唯一约束，不能重复（包括不同级别的栏目）
3. **状态控制**：只有 `status = '1'`（已发布）的栏目才会被访问
4. **详情页识别**：路径最后一段是纯数字时才会被识别为详情页
5. **多级路径**：确保各级栏目的 `url_key` 不冲突

## 技术实现

- **API 端点**：
  - `/api/public/cms/category/by-urlkey/[urlKey]` - 根据 urlKey 查询栏目
  - `/api/public/cms/category/by-path` - 根据路径段查询栏目（支持多级）
- **动态页面**：`app/pages/[...slug].vue`
- **服务层**：`server/services/public/cms/category.services.ts`
- **Schema**：`server/db/schema/cms/category.ts`

## 故障排查

### 访问 URL 时显示 404

1. 检查数据库中是否存在对应的 `url_key`
2. 确认栏目的 `status` 字段为 `'1'`（已发布）
3. 确认栏目的 `del_flag` 字段为 `'0'`（未删除）
4. 检查 `template_type` 或 `detail_template_type` 是否在对应的 Map 中定义

### 详情页显示 404

1. 确认路径最后一段是纯数字
2. 检查数据库中对应栏目的 `detail_template_type` 是否配置
3. 确认详情模板文件存在且正确导出

### 模板未正确加载数据

检查模板组件是否正确接收 props：

**列表页模板：**
```vue
<script setup lang="ts">
const props = defineProps<{
  category?: any;
  urlKey?: string;
}>();

// 使用 props.category?.categoryName?.zh 动态显示栏目名称
</script>
```

**详情页模板：**
```vue
<script setup lang="ts">
const props = defineProps<{
  category?: any;
  contentId?: number;
}>();

// 使用 props.contentId 获取内容详情
</script>
```

## 最佳实践

1. **URL 规划**：使用有意义的 `url_key`，如 `web-design` 而不是 `category1`
2. **模板复用**：多个栏目可以共享同一个模板类型
3. **层级结构**：建议不超过 3 级，避免 URL 过长
4. **命名规范**：
   - `url_key` 使用小写字母和连字符（kebab-case）
   - 模板类型使用清晰的命名，如 `news-detail`、`products-list`
