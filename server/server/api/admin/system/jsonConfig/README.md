### 1. 服务层 (/server/services/admin/system/jsonConfig/json.config.services.ts)

- 提供了完整的 CRUD 操作
- 支持按 ID 和按 configKey 查询/更新/删除
- 包含分页查询功能
- 提供 getOrCreate 方法用于获取或创建配置

### 2. API 接口

基础 CRUD 操作：

- GET /api/admin/system/jsonConfig/list - 获取配置列表（支持分页）
- GET /api/admin/system/jsonConfig/[jsonConfigId] - 根据 ID 获取配置
- POST /api/admin/system/jsonConfig/index - 创建新配置
- PUT /api/admin/system/jsonConfig/index - 根据 ID 更新配置
- DELETE /api/admin/system/jsonConfig/[jsonConfigId] - 根据 ID 删除配置

按 configKey 操作：

- GET /api/admin/system/jsonConfig/key/[configKey] - 根据配置键获取配置
- PUT /api/admin/system/jsonConfig/key/[configKey] - 根据配置键更新配置
- DELETE /api/admin/system/jsonConfig/key/[configKey] - 根据配置键删除配置

使用示例：

// 创建配置
POST /api/admin/system/jsonConfig/index

```json
{
  "configKey": "site_settings",
  "configValue": {
    "title": "AI产品榜",
    "theme": "dark"
  }
}
```

// 按键名更新配置
PUT /api/admin/system/jsonConfig/key/site_settings

```json
{
  "configValue": {
    "title": "AI产品榜 - 新版",
    "theme": "light"
  }
}
```

// 按键名获取配置
GET /api/admin/system/jsonConfig/key/site_settings
