---
marp: true
theme: gaia
_class: lead
paginate: true
backgroundColor: #fff
backgroundImage: url('https://marp.app/assets/hero-background.svg')
math: mathjax
---
<style>
section {
  font-size: 26px; /* Adjust the font size */
  line-height: 1.6; /* Adjust the line height for better readability */
}
</style>
# Claude Code 个人使用心得

---

## 几种典型使用场景

- **开发新项目**  
  `CLAUDE.md`是？如何编写？
- **修复已完成项目的 bug**  
  快速定位问题，Claude 协助修复 bug，并生成规范的 Git Commit。  
- **接手不熟悉的开源项目**  
  快速理解项目结构与核心逻辑。  


---

## 什么是 `CLAUDE.md`？
Claude Code 在启动会话时会**自动读取并加载其内容到上下文**，作为项目专属的“记忆”和“指令集”。
- 项目的开发手册
- Claude 的 Memory
  可以通过 `# New Rule` 在某个session里动态加入新的Rule到项目 `CLAUDE.md`
- User 定义的一些常用的指令
  `ai-daily-stats`

---
```markdown
# AI Daily Stats Rule
**Rule name:** `ai-daily-stats [<date>]`

**Description:** Run git statistics to analyze AI assistant (Claude Code) contributions to the codebase for a specific date. If no date is provided, uses today's date.

**Parameters:**
- `<date>` (optional): Date in YYYY-MM-DD format. If not provided, uses today's date.

**Date validation:**
The date parameter must match the pattern YYYY-MM-DD. If invalid format is provided, the command will output an error message.

**Commands to run:**
<code>
# AI Daily Stats script with date validation
#!/bin/bash

# Function to validate date format YYYY-MM-DD
validate_date() {
    if [[ ! $1 =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
        echo -e "\033[0;31mError: wrong date format, use format YYYY-MM-DD\033[0m" >&2
        exit 1
    fi
}

# Get date from parameter or use today
if [ $# -eq 0 ]; then
    TARGET_DATE=$(date +%Y-%m-%d)
else
    validate_date "$1"
    TARGET_DATE="$1"
fi

# Count commits with Claude Code signature from target date
git log --since="$TARGET_DATE 00:00:00" --until="$TARGET_DATE 23:59:59" --grep="Co-Authored-By: Claude <noreply@anthropic.com>" --oneline | wc -l

# Show commits with Claude Code signature from target date
git log --since="$TARGET_DATE 00:00:00" --until="$TARGET_DATE 23:59:59" --grep="Co-Authored-By: Claude <noreply@anthropic.com>" --oneline

# Calculate total lines added/deleted for Claude Code commits from target date
git log --since="$TARGET_DATE 00:00:00" --until="$TARGET_DATE 23:59:59" --grep="Co-Authored-By: Claude <noreply@anthropic.com>" --numstat | awk 'NF==3 {plus += $1; minus += $2} END {print "Target date added: " plus, "Target date deleted: " minus, "Target date net: " plus-minus}'

# Show detailed stat summary for each Claude Code commit from target date
git log --since="$TARGET_DATE 00:00:00" --until="$TARGET_DATE 23:59:59" --grep="Co-Authored-By: Claude <noreply@anthropic.com>" --stat --oneline
</code>
**Summary format:**
- Number of commits today
- Total lines added/deleted today
- Net change today
- Brief description of today's commits (features, refactoring, etc.)

```

---

## 什么是 `CLAUDE.md`？
Claude Code 在启动会话时会**自动读取并加载其内容到上下文**，作为项目专属的“记忆”和“指令集”。
- 项目的开发手册
- Claude 的 Memory
  可以通过 `# New Rule` 在某个session里动态加入新的Rule到项目 `CLAUDE.md`
- User 定义的一些常用的指令
  `ai-daily-stats`
- 个性化
  - 代码风格（如 PEP 604/585）
  - 工具链偏好（如 `uv` + `ruff`）
  - $\cdots$

> Claude Code 会严格遵循其中的指示，显著提升输出一致性 。

---

## 使用 `@文件名` 引用项目内容

在 prompt 中使用 `@文件名`（如 `@src/main.py`），Claude Code 会**自动将该文件的完整内容注入上下文**。

- **精准引用**：基于真实代码做修改或解释  
- **保持上下文完整**：包括 import、类定义、注释等

> ⚠️ 文件名含空格时需用引号包裹（如 `@"my file.py"`）。

---

## 开发新项目

**提前写好 `CLAUDE.md`**，假设现在要开发一个“智能文档分析项目”：

```markdown
# SmartDoc Analyzer - 开发规范

## 项目背景
基于 LLM 的智能文档分析系统，支持 PDF、Word、TXT 格式文档的智能解析和问答。

## 核心依赖
- **LLM**: OpenAI, local LLM support  
- **文档解析**: PyPDF2, python-docx  
- **向量数据库**: Milvus  
- **Web框架**: FastAPI  
- **异步处理**: asyncio, aiofiles
````

---
`CLAUDE.md` Cont. 
```markdown
## Python 代码规范
- 使用 PEP 604 联合类型: `str | None` 代替 `typing.Optional` `typing.Union`
- 使用 PEP 585 内置类型: `list[str]`, `dict[str, Any]` 代替 `typing.List` `typing.Union`
- 字符串统一优先使用双引号  
- docstring 遵循 Google 风格

## 工具链
- 包管理: `uv`  
- 代码格式化: `ruff`  
- 测试: `pytest` + `pytest-asyncio`
```

---
`CLAUDE.md` Cont. 
```markdown
## 项目结构（以下为参考项目结构，生成适合本项目的项目结构）
project-name/
│
├── src/                          # 核心功能（推荐使用具体名称，name_your_application）
│   ├── __init__.py
│   ├── __main__.py
│   ├── _config.py                # 项目配置文件
│   ├── feature_a.py              # 功能 A
│   ├── services/                 # 服务层 / API 接口实现
│   │   └── api_b.py              # API B
│   └── utils/                    # 通用工具模块
│       └── logger.py             # 日志配置
│
├── tests/                        # 测试套件
│   ├── __init__.py
│   ├── unit/                     # 单元测试
│   │   ├── test_feature_a.py
│   │   └── test_utils.py
│   ├── integration/              # 集成测试
│   │   └── test_services.py
│   ├── template.py               # 测试模板
│   │                             # import context
│   │                             # """Do not insert any code above!!!"""
│   └── context.py                # 测试上下文配置
│                                 # import sys
│                                 # from pathlib import Path
│                                 # sys.path.insert(0, Path(__file__).parents[1].absolute().__str__())
│
└── docs/                         # 项目文档
    ├── feature_a.md              # Feature A 详细说明
    ├── api_b.md                  # API B 的接口文档
    └── deployment.md             # 部署指南
```

---

## Claude Code 的权限机制

Claude Code **默认无权直接修改你的文件系统**。所有可能修改系统的操作（如写文件、执行 shell 命令）都**需要你显式批准**。

* 你也可以通过 `/permissions` 查看和管理权限规则

建议在项目根目录运行 `claude`，这样它能正确读取 `CLAUDE.md` 并将权限范围限定在当前目录内。

---

## 启动 Claude 开发会话

配置环境变量[big-model]()：

```bash
export ANTHROPIC_BASE_URL=...
export ANTHROPIC_AUTH_TOKEN=sk-...
```

常用命令：

* `claude --resume`：恢复从当前项目退出的会话 <补充链接>
* `/export`：导出当前会话记录，<下一个部分有我导出的修复bug的session>

**Prompt**: 
> 根据 @CLAUDE.md，给出你关于实现该项目的 Plans。


---

## 场景二：修复已有项目的 Bug

**案例**：问数的query扩写模块，定位到 [`org_query_expand`](http://10.32.0.123/ai_bigdata/algorithm/hgt-graph/-/blob/xy-dev/hgt_graph/org_graph/expand_query_with_org_details.py#L197) 函数中遗漏了 LLM 调用失败的异常处理。

**具体希望Claude完成**：
- 读 `@hgt_graph/org_graph/expand_query_with_org_details.py` 代码
- 说明希望 Claude 增加异常处理和超时机制
- 最后 `add` 修改并 `commit` 符合 [Conventional Commits ]() 的提交信息

**Prompt**：

> `expand_query` 函数中遗漏了 LLM 调用失败的异常处理，请帮忙补充并生成提交信息。

---

## 场景三：快速上手陌生开源项目

**推荐项目**：[FastAPI](https://fastapi.tiangolo.com/)

* 现代、高性能的 Python Web 框架
* 代码结构清晰，文档完善，社区活跃
* 非常适合作为学习“如何组织中大型 Python 项目”的范例

**高效提问 Prompt**：

> “我刚 clone 了 FastAPI 项目，请用不超过 200 字说明其核心模块划分，并指出从哪个文件开始阅读最有助于理解请求处理流程。”

Claude 通常会指出：

* 入口：`fastapi/applications.py`
* 核心：`fastapi/routing.py` 和 `fastapi/dependencies.py`
* 建议先看 `examples/` 目录中的最小可运行示例
