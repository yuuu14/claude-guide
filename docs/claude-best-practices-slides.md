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

<!--
大家好，今天我来做一个比较简短的关于使用 Claude Code 来做Python项目开发的分享。
-->

---

## 几种典型使用场景

- **开发新项目**
  `CLAUDE.md`是？如何编写？
- **修复已完成项目的 bug**
  快速定位问题，Claude 协助修复 bug，并生成规范的 Git Commit。
- **接手开源/团队其他成员的项目**
  快速理解项目结构与核心逻辑。

<!--
分享主要从三个开发的场景入手

开发一个新项目，比较关键的是 `CLAUDE.md` 的编写。

然后我会用一个我昨天的历史对话来展示一下 Claude 修复 bug 这个场景。

最后是简单介绍一下拿到一个不熟悉的项目，如何用 Claude 来快速获得对于项目的一个全局理解和快速上手的入口。

-->  


---

## 什么是 [`CLAUDE.md`](https://www.anthropic.com/engineering/claude-code-best-practices)？
Claude Code 在启动会话时会**自动读取并加载其内容到上下文**，作为项目专属的"记忆"和"指令集"。
- 项目的开发手册
- Claude 的 Memory
  可以通过 `# New Rule` 在某个session里动态加入新的Rule到项目 `CLAUDE.md`
- 自定义一些常用的指令
  [`ai-daily-stats`](./ai-daily-stats-rule.md)

<!--
`CLAUDE.md` 是 Claude Code 的用户配置的比较核心的一个文档。每次启动 Claude 时，它会自动读取这个文件，把内容加载到 context 中。

可以在运行Claude 前先编写好，包括：项目开发涉及的技术栈、架构设计、编码规范。

或者，也可以在一个已经启动的Session里，通过 # + 突然想加的一个Rule，然后 claude 会把这个新规则自动写到项目 CLAUDE.md

同时，可以自己设置一些指令，比如统计一下每天 Claude 生成的代码量：
-->

---

## 什么是 `CLAUDE.md`？
Claude Code 在启动会话时会**自动读取并加载其内容到上下文**，作为项目专属的"记忆"和"指令集"。
- 项目的开发手册
- Claude 的 Memory
  可以通过 `# New Rule` 在某个session里动态加入新的Rule到项目 `CLAUDE.md`
- 自定义一些常用的指令
  `ai-daily-stats`
- 个性化
  - 代码风格（如 PEP 604/585）
  - 工具链偏好（如 `uv` + `ruff`）
  - $\cdots$

> Claude Code 会严格遵循其中的指示，显著提升输出一致性 。

<!--
个性化的部分就是因人而异了，因为基本是使用 Python3.10 以及之后的版本开发，我这里定义了 要遵循PEP 604 和 585

然后具体执行脚本和添加包，用uv，之类的
-->

---

## 使用 `@文件名` 引用项目内容

在 prompt 中使用 `@文件名`（如 `@src/main.py`），Claude Code 会**自动将该文件的完整内容注入上下文**。

- **精准引用**：直接定位具体的模块
- **上下文完整**：Claude 会去读取必要的 `import`

<!--
然后 `@文件名` 引用这个也是我用的比较多的，基本每条prompt都会用到。Claude 会自动把整个文件内容加载到上下文中，就是直接告诉指定路径，而不是让 Claude 去找文件

而且 Claude 读@的这个文件的同时，会根据需要去读取 import 的模块。
-->

---

## 开发新项目

**提前写好 `CLAUDE.md`**，假设现在要开发一个"智能文档分析"项目：

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

<!--
下面我用一个demo"智能文档分析"项目，来看一下 CLAUDE.md 大致的组成：

先几句话写一下项目背景和需求，然后会用到的技术栈，让 Claude 先完善一下 项目的 pyproject 配置
-->

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

<!--
然后是代码规范，和具体的工具使用
-->

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

<!--
项目结构模板 这部分供参考，我会把核心feature都放在项目功能的路径下，然后这个路径里尽量不要加入测试代码，所有的测试代码放到tests里，主要是单元测试。

然后docs里放复杂模块 和 api接口的说明
-->

---

## Claude Code 的权限机制

Claude Code **默认无权直接修改你的文件系统**。所有可能修改系统的操作（如写文件、执行 shell 命令）都[**需要你显式批准**](./ask-permission.md)。

建议在项目根目录运行 `claude`，这样它能正确读取 `CLAUDE.md` 并将权限范围限定在当前目录内。

* 你也可以通过 `/permissions` 查看和管理权限规则
* 或者在 `./claude/settings.json` 里[配置](https://docs.claude.com/en/docs/claude-code/settings)
* *YOLO mode*: `claude --dangerously-skip-permissions` bypass 所有权限检查

<!--
接下来是介绍一下 Claude 的权限机制。 Claude 默认不能写权限，然后也没有修改os的权限。

建议是在项目根目录启动 Claude，自动限制 Claude 的权限范围在项目内。
-->

---
**常用 Claude 内置指令：**

* `claude --resume <session-id>`：恢复从当前项目退出的会话（session-id 可选）
* `claude` 进入某个 Session 以后：
  - `/config`：个性化设置
  - `/context`：查看当前 Session [上下文使用情况](./context.md)
  - `/clear` (`/new`, `/reset`)：清除历史对话和上下文
  - `/rewind`：恢复 对话 / 代码 到当前Session的某个节点（Bash操作不可被reverse）
  - `/export`：导出当前会话记录，到 clipboard / 文件

<!--
然后讲一下我常用的几个 Claude 内置指令：

- `claude --resume`：恢复之前的会话，不加 session-id 就进入一个可交互的历史 session-list
- `/export`：导出会话记录
-->

---

## 启动 Claude 开发会话

配置环境变量 或者 修改[`.claude/settings.json`](https://docs.bigmodel.cn/cn/coding-plan/tool/claude)：

```bash
export ANTHROPIC_BASE_URL=https://open.bigmodel.cn/api/anthropic
export ANTHROPIC_AUTH_TOKEN=sk-...
```

**示例Prompt**:
> 根据 @CLAUDE.md，给出实现这个项目的 Plans。

<!--
我用的是智谱的模型，就是要配置这两个环境变量，这个是之前他们的文档里写的，新版的他们直接加到了 .claude/settings.json

配置完环境变量，把 CLAUDE.md 写好，然后就可以启动 claude了
比如使用这个prompt："根据 @CLAUDE.md，给出这个项目的 Plans。"
-->

---

## 场景二：修复已有项目的 Bug

**案例**：问数的query扩写模块，定位到 [`org_query_expand`](http://10.32.0.123/ai_bigdata/algorithm/hgt-graph/-/blob/xy-dev/hgt_graph/org_graph/expand_query_with_org_details.py#L197) 函数中遗漏了 LLM 调用失败的异常处理。

**具体希望Claude完成**：
- 读 @hgt_graph/org_graph/expand_query_with_org_details.py 代码
- 说明希望 Claude 增加异常处理和超时机制
- 最后 add 修改并 commit 符合 [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) 的提交信息

**示例Prompt**：

> `org_query_expand` 函数中遗漏了 LLM 调用失败的异常处理，TODO: 1. 加上try-except异常处理；2. _config.py中LLM config加入timeout；3. git add and commit changes。
- [历史Session](./2025-10-21-hgtgraphorggraphexpandquerywithorgdetails.md)

<!--
第二个场景是 使用 Claude 帮助修复 bug，这个是我昨天问数query扩写接口遇到的一个 bug。在问数的 query 扩写模块中，遇到了模型连接问题，当时接口返回的报错信息不是项目里面直接处理的，而是一个 Connection Error，就很明显是 没有加 LLM 调用失败的异常处理。

然后我希望 Claude 帮我修复这个 bug 并且用 git 提交修改
- 先是告诉 Claude 出问题的模块在哪里
- 然后加入说明需求：增加异常处理和超时机制
- 最后让 Claude 修改代码并生成规范的 commit 内容

可以看一下具体的log
-->
---

## 场景三：快速上手不熟悉的项目

举例：[FastAPI](https://fastapi.tiangolo.com/)

**示例Prompt**：

> 我刚 clone 了 FastAPI 项目，请用不超过 200 字说明其核心模块划分，并指出从哪个文件开始阅读最有助于理解请求处理流程。要求：语言使用简体中文。

Claude 的[回答](./2025-10-22-clone-fastapi-200.md)

<!--
第三个场景是快速上手一个不熟悉的项目代码。然后因为 FastAPI 经常用，但是也没仔细看过代码，这个就用这个举一下例子。

首先把 FastAPI clone 下来，然后进入项目，启动Claude，用这个prompt："我刚 clone 了 FastAPI 项目，请用不超过 200 字说明其核心模块划分，并指出从哪个文件开始阅读最有助于理解请求处理流程。要求：语言使用简体中文。"

可以看一下 Claude 的返回

它告诉我 FastAPI 的核心模块包括这几个，而且提到了入门先看哪些文件比较合适。

入门： fastapi/__init__.py → tests/main.py核心： fastapi/applications.py (应用初始化) → fastapi/routing.py (请求处理)

它告诉我 FastAPI 的核心模块包括这几个，并建议从 `fastapi/applications.py` 开始阅读。

这个大概持续了5-6分钟，肯定比直接开始看源码会快很多。

-->

---

## 参考链接

[1] [Claude Code: Best practices for agentic coding](https://www.anthropic.com/engineering/claude-code-best-practices)

[2] [智谱AI开放文档](https://docs.bigmodel.cn/cn/coding-plan/tool/claude)

[3] [What is the --resume Flag in Claude Code](https://claudelog.com/faqs/what-is-resume-flag-in-claude-code/)

[4] [Claude Code settings](https://docs.claude.com/en/docs/claude-code/settings)

[5] [Claude Code dangerously-skip-permissions: When to Use It (And When You Absolutely Shouldn't)](https://www.ksred.com/claude-code-dangerously-skip-permissions-when-to-use-it-and-when-you-absolutely-shouldnt/)

<!--
以上就是我这次分享的全部内容，应该是我使用 Claude Code 一个月的一个心得。
-->