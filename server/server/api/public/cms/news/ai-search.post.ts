import { NewsServices } from '~~/server/services/cms/news.services';
import { AITranslateService } from '~~/server/services/ai/ai.service';
import { CategoryServices } from '~~/server/services/cms/category.services';

const newsServices = new NewsServices();
const categoryServices = new CategoryServices();

/**
 * AI 智能搜索接口
 * 1. 使用 AI 解析自然语言查询，生成数据库查询条件
 * 2. 执行数据库搜索
 * 3. 使用 AI 润色和总结搜索结果
 */
export default defineEventHandler(async event => {
  try {
    const body = await readBody(event);
    const { query, locale = 'zh' } = body;

    if (!query || typeof query !== 'string' || query.trim() === '') {
      throw createError({
        statusCode: 400,
        message: '请输入搜索内容'
      });
    }

    const trimmedQuery = query.trim();

    // 步骤1: 使用 AI 解析查询，提取搜索条件
    const searchConditions = await parseQueryWithAI(trimmedQuery, locale);

    // 步骤2: 执行数据库搜索
    let searchResults = await performSearch(searchConditions, body);

    // 步骤2.5: 如果第一次搜索结果为空，尝试更宽松的搜索
    if (searchResults.total === 0 && searchConditions.keywords.length > 0) {
      console.log('首次搜索无结果，尝试使用更宽松的关键词重试...');
      // 使用用户原始查询的关键词进行模糊搜索
      const fallbackConditions = {
        ...searchConditions,
        keywords: [trimmedQuery],
        mainKeyword: trimmedQuery
      };
      searchResults = await performSearch(fallbackConditions, body);
    }

    // 步骤3: 为每条新闻添加分类路径信息
    for (const item of searchResults.rows) {
      if (item.category && item.category.mpath) {
        const categoryIds = item.category.mpath.split('.').filter(id => Boolean(id));
        if (categoryIds && categoryIds.length > 0) {
          (item as any).categoryMpath = await Promise.all(categoryIds.map(id => categoryServices.findById(Number(id))));
        }
      }
    }

    // 步骤3: 为每条新闻添加分类路径信息
    for (const item of searchResults.rows) {
      if (item.category && item.category.mpath) {
        const categoryIds = item.category.mpath.split('.').filter(id => Boolean(id));
        if (categoryIds && categoryIds.length > 0) {
          (item as any).categoryMpath = await Promise.all(categoryIds.map(id => categoryServices.findById(Number(id))));
        }
      }
    }

    // 步骤4: 使用 AI 润色和总结搜索结果
    const aiResponse = await refineResultsWithAI(trimmedQuery, searchResults, locale);

    return createApiResponse({
      originalQuery: trimmedQuery,
      parsedConditions: searchConditions,
      results: searchResults.rows,
      total: searchResults.total,
      aiSummary: aiResponse.summary,
      aiSuggestions: aiResponse.suggestions,
      relatedQueries: aiResponse.relatedQueries
    });
  } catch (error: any) {
    console.error('AI 搜索错误:', error);
    throw createError({
      statusCode: error.statusCode || 500,
      message: error.message || '智能搜索失败，请稍后重试'
    });
  }
});

/**
 * 使用 AI 解析自然语言查询，提取搜索条件
 * 优化：提取多个相关关键词，提高搜索匹配度
 */
async function parseQueryWithAI(query: string, locale: string) {
  try {
    const aiService = new AITranslateService();

    // 优化后的 AI 提示词，要求提取多个关键词
    const prompt = `你是一个搜索助手。请分析用户的搜索查询，提取搜索条件。

用户查询：${query}

请返回 JSON 格式的搜索条件（只返回 JSON，不要有其他内容）：
{
  "mainKeyword": "主要关键词",
  "keywords": ["关键词1", "关键词2", "关键词3"],
  "categoryId": 分类ID（数字，不确定则为null）,
  "timeRange": "时间范围（recent/week/month/all）",
  "sortBy": "排序方式（latest/hot/recommend）",
  "explanation": "分析说明"
}

重要规则：
1. mainKeyword: 最核心的搜索词（1-2个字）
2. keywords: 返回3-5个相关关键词数组，包括：
   - 主要关键词的不同表述
   - 相关的同义词或近义词
   - 可能的搜索词变体
   示例：用户搜索"人工智能"，返回["AI", "人工智能", "智能", "机器学习", "自动化"]
3. 如果用户没有明确关键词（如"最近的新闻"），keywords返回空数组
4. categoryId: 只有明确提到分类名才填ID，否则null
5. timeRange: recent=最近7天, week=一周内, month=一月内, all=全部
6. sortBy: latest=最新, hot=热门, recommend=推荐

示例：
查询："最近的科技新闻"
{
  "mainKeyword": "科技",
  "keywords": ["科技", "技术", "创新", "数码", "智能"],
  "categoryId": null,
  "timeRange": "recent",
  "sortBy": "latest",
  "explanation": "搜索最近一周内包含科技相关关键词的新闻"
}

查询："人工智能产品"
{
  "mainKeyword": "AI",
  "keywords": ["AI", "人工智能", "智能", "自动化", "机器学习"],
  "categoryId": null,
  "timeRange": "all",
  "sortBy": "latest",
  "explanation": "搜索包含AI或人工智能相关内容的产品"
}

查询："热门文章"
{
  "mainKeyword": "",
  "keywords": [],
  "categoryId": null,
  "timeRange": "all",
  "sortBy": "hot",
  "explanation": "按浏览量排序显示所有热门内容"
}`;

    const result = await aiService.translate(prompt, 'json' as any);

    // 尝试解析 AI 返回的 JSON
    let jsonStr = result;
    const jsonMatch = result.match(/\{[\s\S]*\}/);
    if (jsonMatch) {
      jsonStr = jsonMatch[0];
    }

    const conditions = JSON.parse(jsonStr);

    // 兼容处理：确保 keywords 是数组
    if (typeof conditions.keywords === 'string') {
      conditions.keywords = conditions.keywords ? [conditions.keywords] : [];
    }

    return conditions;
  } catch (error) {
    console.error('AI 解析查询失败，使用默认解析:', error);
    // 降级方案：将用户输入作为主要关键词，并生成一些变体
    const fallbackKeywords = generateFallbackKeywords(query, locale);
    return {
      mainKeyword: query.slice(0, 10),
      keywords: fallbackKeywords,
      categoryId: null,
      timeRange: 'all',
      sortBy: 'latest',
      explanation: '默认搜索'
    };
  }
}

/**
 * 生成降级关键词
 * 当 AI 解析失败时使用
 */
function generateFallbackKeywords(query: string, _locale: string): string[] {
  const keywords = [query];

  // 如果查询包含"新闻"、"产品"等，提取前面的部分
  const patterns = [
    /(.+?)新闻$/,
    /(.+?)产品$/,
    /(.+?)资讯$/,
    /(.+?)文章$/
  ];

  for (const pattern of patterns) {
    const match = query.match(pattern);
    if (match && match[1]) {
      keywords.push(match[1].trim());
      keywords.push(match[1].trim() + '技术');
      break;
    }
  }

  // 常见关键词映射
  const keywordMap: Record<string, string[]> = {
    人工智能: ['AI', '智能', '自动化'],
    科技: ['技术', '创新', '数码'],
    金融: ['财经', '投资', '理财'],
    医疗: ['健康', '医院', '医药'],
    教育: ['培训', '学习', '学校']
  };

  for (const [key, values] of Object.entries(keywordMap)) {
    if (query.includes(key)) {
      keywords.push(...values);
    }
  }

  return [...new Set(keywords)].slice(0, 5);
}

/**
 * 根据 AI 解析的条件执行数据库搜索
 * 优化：支持多关键词 OR 搜索，使用模糊匹配提高命中率
 */
async function performSearch(conditions: any, body: any = {}) {
  const queryParams: any = {
    pageNum: body.page || 1,
    limit: body.limit || 12
  };

  // 优化：应用 AI 解析出的多个关键词
  const keywords = conditions.keywords || [];
  const mainKeyword = conditions.mainKeyword || '';

  if (keywords.length > 0) {
    // 传递关键词数组用于 OR 搜索
    queryParams.keywords = keywords;
  } else if (mainKeyword) {
    // 兼容旧格式，单个关键词
    queryParams.keywords = [mainKeyword];
  }

  // 根据时间范围筛选
  if (conditions.timeRange === 'recent' || conditions.timeRange === 'week') {
    const sevenDaysAgo = new Date();
    sevenDaysAgo.setDate(sevenDaysAgo.getDate() - 7);
    queryParams.startTime = sevenDaysAgo.toISOString();
  } else if (conditions.timeRange === 'month') {
    const oneMonthAgo = new Date();
    oneMonthAgo.setMonth(oneMonthAgo.getMonth() - 1);
    queryParams.startTime = oneMonthAgo.toISOString();
  }

  // 根据排序方式排序
  if (conditions.sortBy === 'hot') {
    queryParams.sortBy = 'viewCount';
  } else if (conditions.sortBy === 'recommend') {
    queryParams.isRecommend = '1';
  }

  return await newsServices.publicList(queryParams);
}

/**
 * 使用 AI 润色和总结搜索结果
 */
async function refineResultsWithAI(query: string, searchResults: any, locale: string) {
  if (!searchResults.rows || searchResults.rows.length === 0) {
    return {
      summary: `抱歉，没有找到与"${query}"相关的内容。您可以尝试：\n1. 使用更通用的关键词\n2. 检查关键词拼写\n3. 尝试使用相关的同义词`,
      suggestions: [],
      relatedQueries: []
    };
  }

  try {
    const aiService = new AITranslateService();

    // 构建搜索结果摘要
    const resultsSummary = searchResults.rows
      .slice(0, 5)
      .map((item: any, index: number) => {
        const title = item.title?.[locale] || item.title?.zh || '';
        const summary = item.summary?.[locale] || item.summary?.zh || '';
        const category = item.category?.categoryName?.[locale] || item.category?.categoryName?.zh || '';
        return `${index + 1}. ${category} - ${title}: ${summary.substring(0, 50)}...`;
      })
      .join('\n');

    const prompt = `你是一个智能搜索助手。用户搜索"${query}"，找到了 ${searchResults.total} 条相关结果。

前几条结果：
${resultsSummary}

请用${locale === 'zh' ? '中文' : '英文'}返回以下 JSON 格式的内容（只返回 JSON，不要有其他内容）：
{
  "summary": "用2-3句话概括搜索结果，告诉用户找到了什么，突出重点内容",
  "suggestions": [
    "建议1：基于搜索结果给用户的建议",
    "建议2":基于搜索结果给用户的建议"
  ],
  "relatedQueries": [
    "相关搜索词1",
    "相关搜索词2",
    "相关搜索词3"
  ]
}`;

    const result = await aiService.translate(prompt, 'json' as any);

    // 提取 JSON
    const jsonMatch = result.match(/\{[\s\S]*\}/);
    let jsonStr = jsonMatch ? jsonMatch[0] : result;

    return JSON.parse(jsonStr);
  } catch (error) {
    console.error('AI 润色结果失败:', error);
    // 降级方案：返回简单的总结
    return {
      summary: `为您找到 ${searchResults.total} 条与"${query}"相关的内容。${searchResults.rows
        .slice(0, 3)
        .map((item: any) => {
          const title = item.title?.[locale] || item.title?.zh || '';
          return `《${title}》`;
        })
        .join('、')}等。`,
      suggestions: ['点击搜索结果查看详细信息', '尝试使用不同的关键词获取更多结果'],
      relatedQueries: []
    };
  }
}
