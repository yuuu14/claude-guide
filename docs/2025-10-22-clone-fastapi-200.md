
```sh
> 我刚 clone 了 FastAPI 项目，请用不超过 200 字说明其核心模块划分，并指出从哪个文件开始阅读最有助于理解请求处理流程。要求：语言使用简体中文。 

⏺ Explore(探索FastAPI项目结构)
  ⎿  Done (19 tool uses · 27.9k tokens · 2m 11s)                                                                                                                                                                                                                                                                  

⏺ FastAPI 项目核心模块划分：

  主要模块结构

  🏗️ 应用核心 (fastapi/applications.py) - FastAPI主类，基于Starlette

  🛣️ 路由系统 (fastapi/routing.py) - 请求分发、端点注册、参数解析

  📋 参数系统 (fastapi/param_functions.py) - Path/Query/Body/Header等参数定义

  🔄 依赖注入 (fastapi/dependencies/) - 自动依赖解析和生命周期管理

  🔐 安全认证 (fastapi/security/) - OAuth2/JWT/API Key等认证机制

  ⚙️ 中间件 (fastapi/middleware/) - CORS/Gzip/HTTPS重定向

  📚 OpenAPI (fastapi/openapi/) - 自动文档生成

  ❌ 异常处理 (fastapi/exceptions.py) - HTTP和WebSocket异常

  请求处理流程

  请求接收 → 路由匹配 → 参数解析 → 依赖注入 → 业务逻辑 → 响应生成

  推荐阅读起始

  入门： fastapi/__init__.py → tests/main.py核心： fastapi/applications.py (应用初始化) → fastapi/routing.py (请求处理)
```


