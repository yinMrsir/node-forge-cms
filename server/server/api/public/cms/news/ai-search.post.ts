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
    const searchResults = await performSearch(searchConditions, body);

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
 */
async function parseQueryWithAI(query: string, locale: string) {
  try {
    const aiService = new AITranslateService();

    // 构建 AI 提示词，让 AI 解析查询并返回 JSON 格式的搜索条件
    const prompt = `你是一个搜索助手。请分析用户的搜索查询，提取出数据库查询条件。

用户查询：${query}

请返回 JSON 格式的搜索条件（只返回 JSON，不要有其他内容）：
{
  "keywords": "关键词",
  "categoryId": 分类ID（数字）,
  "timeRange": "时间范围（recent/week/month/year/all）",
  "sortBy": "排序方式（latest/hot/recommend）",
  "explanation": "解释"
}

规则：
1. keywords: 从查询中提取的核心搜索关键词
2. categoryId: 如果查询中提到特定分类（如"新闻"、"产品"），填写对应分类ID，否则为 null
3. timeRange: 解析时间范围
4. sortBy: 根据查询意图确定排序方式
5. explanation: 用一句话解释你的分析

示例：
查询："最近的科技新闻"
{"keywords":"科技","categoryId":null,"timeRange":"recent","sortBy":"latest","explanation":"搜索包含'科技'关键词的最近新闻"}

查询："热门产品"
{"keywords":"","categoryId":产品分类ID,"timeRange":"all","sortBy":"hot","explanation":"按浏览量排序显示所有热门产品"}`;

    const result = await aiService.translate(prompt, 'json' as any);

    // 尝试解析 AI 返回的 JSON
    let jsonStr = result;
    // 提取 JSON 部分（如果 AI 返回了多余文字）
    const jsonMatch = result.match(/\{[\s\S]*\}/);
    if (jsonMatch) {
      jsonStr = jsonMatch[0];
    }

    const conditions = JSON.parse(jsonStr);
    return conditions;
  } catch (error) {
    console.error('AI 解析查询失败，使用默认解析:', error);
    // 降级方案：使用简单的关键词提取
    return {
      keywords: query,
      categoryId: null,
      timeRange: 'all',
      sortBy: 'latest',
      explanation: '默认搜索'
    };
  }
}

/**
 * 根据 AI 解析的条件执行数据库搜索
 */
async function performSearch(conditions: any, body: any = {}) {
  const queryParams: any = {
    pageNum: body.page || 1,
    limit: body.limit || 12
  };

  // 应用 AI 解析出的条件
  if (conditions.keywords) {
    queryParams.keywords = conditions.keywords;
  }

  // 根据时间范围筛选
  if (conditions.timeRange === 'recent') {
    // 最近7天
    const sevenDaysAgo = new Date();
    sevenDaysAgo.setDate(sevenDaysAgo.getDate() - 7);
    queryParams.startTime = sevenDaysAgo.toISOString();
  } else if (conditions.timeRange === 'week') {
    const oneWeekAgo = new Date();
    oneWeekAgo.setDate(oneWeekAgo.getDate() - 7);
    queryParams.startTime = oneWeekAgo.toISOString();
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
