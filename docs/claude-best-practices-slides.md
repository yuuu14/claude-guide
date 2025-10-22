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
大家好，今天我想和大家分享我使用 Claude Code 的一些心得体会。作为每天都在和 AI 助手协作的开发者，我发现 Claude Code 不仅仅是一个编程工具，更像是一个懂你代码风格、了解项目背景的开发伙伴。
-->

---

## 几种典型使用场景

- **开发新项目**
  `CLAUDE.md`是？如何编写？
- **修复已完成项目的 bug**
  快速定位问题，Claude 协助修复 bug，并生成规范的 Git Commit。
- **接手不熟悉的开源项目**
  快速理解项目结构与核心逻辑。

<!--
在实际工作中，我发现 Claude Code 在这几个场景下特别有用：

开发新项目时，它就像一个经验丰富的架构师，能帮你搭建整个项目框架。但关键是要先写好 `CLAUDE.md`，这相当于给 Claude 一个"项目说明书"。

修复 bug 时，它变成了细心的高级工程师，能快速定位问题，还能帮你写出符合规范的 Git Commit 信息。

接手开源项目时，它又变成了你的向导，能帮你快速理解陌生的代码结构和核心逻辑。
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
`CLAUDE.md` 是 Claude Code 的核心特性。每次启动会话时，它会自动读取这个文件，把内容加载到上下文中，作为项目的专属"记忆"和"指令集"。

它首先是项目的开发手册，记录了项目的技术栈、架构设计、编码规范。但它远不止于此：

它也是 Claude 的记忆库。在会话中，你可以用 `# New Rule` 动态添加新的规则到 `CLAUDE.md` 中。

它还是你的工作流定制器。比如我定义了 `ai-daily-stats` 指令，可以一键统计 Claude 在当天的代码贡献。
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
最强大的是 `CLAUDE.md` 可以完全个性化。比如我喜欢用现代 Python 语法，就告诉 Claude：

- 代码风格：使用 PEP 604 联合类型 `str | None`，而不是 `typing.Optional`
- 使用 PEP 585 内置类型 `list[str]`，而不是 `typing.List`
- 工具链偏好：`uv` + `ruff` 的组合

Claude Code 会严格遵循这些指示，输出的代码就像我自己写的一样，这种一致性在团队协作中特别重要。
-->

---

## 使用 `@文件名` 引用项目内容

在 prompt 中使用 `@文件名`（如 `@src/main.py`），Claude Code 会**自动将该文件的完整内容注入上下文**。

- **精准引用**：直接定位具体的模块
- **上下文完整**：Claude 会去读取必要的 `import`

<!--
另一个我特别喜欢的功能是 `@文件名` 引用。在 prompt 中用 `@src/main.py`，Claude 会自动把整个文件内容加载到上下文中。

这比传统的"请帮我看看 main.py"要精准得多。Claude 不仅会读取目标文件，还会智能分析其中的 import 依赖，把相关的上下文也一并加载。
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
让我用一个具体例子。假设我们要开发一个"智能文档分析"项目：

有了这些配置，Claude 生成的代码完全符合我的习惯，几乎不需要后期调整。关键是要先定义清楚项目的技术栈、架构设计、编码规范。
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
接着定义代码规范：

有了这些配置，Claude 生成的代码完全符合我的习惯，几乎不需要后期调整。
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
`CLAUDE.md` 还可以定义项目结构模板。这样在开发新功能时，Claude 会自动按照约定的结构创建文件和目录。

比如我定义了 `src/` 放核心功能，`tests/` 分 `unit/` 和 `integration/` 子目录，还有专门的 `docs/` 目录。Claude 在添加新功能时会自动遵循这个结构。
-->

---

## Claude Code 的权限机制

Claude Code **默认无权直接修改你的文件系统**。所有可能修改系统的操作（如写文件、执行 shell 命令）都**需要你显式批准**。

建议在项目根目录运行 `claude`，这样它能正确读取 `CLAUDE.md` 并将权限范围限定在当前目录内。

* 你也可以通过 `/permissions` 查看和管理权限规则
* 或者在 `./claude/settings.json` 里[配置](https://docs.claude.com/en/docs/claude-code/settings)
* *YOLO mode*: `claude --dangerously-skip-permissions` bypass 所有权限检查

<!--
提到 Claude Code，不得不提它的权限机制。它默认不能直接修改你的文件系统，所有写文件、执行命令的操作都需要你明确批准。

这个设计让我很安心，特别是在处理重要项目时。你也可以通过 `/permissions` 命令查看和管理权限规则。

我的建议是在项目根目录启动 Claude，这样它既能读取 `CLAUDE.md`，权限范围也被限制在项目内。
-->

---
**常用命令：**

* `claude --resume <session-id>`：恢复从当前项目退出的会话（session-id 可选）
* `claude` 进入某个 Session 以后：
  - `/config`：个性化设置
  - `/context`：查看当前 Session [上下文使用情况](./context.md)
  - `/clear` (`/new`, `/reset`)：清除历史对话和上下文
  - `/rewind`：恢复 对话 / 代码 到当前Session的某个节点（Bash操作不可被reverse）
  - `/export`：导出当前会话记录，到 clipboard / 文件

<!--
使用前需要配置环境变量：

```bash
export ANTHROPIC_BASE_URL=...
export ANTHROPIC_AUTH_TOKEN=sk-...
```

我的标准启动流程是：进入项目目录，运行 `claude`，然后说："根据 @CLAUDE.md，给出实现这个项目的计划。"
-->
---

## 启动 Claude 开发会话

配置环境变量 或者 修改[`.claude/settings.json`](https://docs.bigmodel.cn/cn/coding-plan/tool/claude)：

```bash
export ANTHROPIC_BASE_URL=https://open.bigmodel.cn/api/anthropic··
export ANTHROPIC_AUTH_TOKEN=sk-...
```

**示例Prompt**:
> 根据 @CLAUDE.md，给出你关于实现该项目的 Plans。

<!--
几个常用的命令：

- `claude --resume`：恢复之前的会话
- `/export`：导出会话记录，方便回顾和分享

我的标准启动流程是：进入项目目录，运行 `claude`，然后说："根据 @CLAUDE.md，给出实现这个项目的计划。"
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
前段时间遇到一个真实的 bug。在问数的 query 扩写模块中，`expand_query` 函数遗漏了 LLM 调用失败的异常处理。

我的处理流程是：

1. 用 `@hgt_graph/org_graph/expand_query_with_org_details.py` 让 Claude 读取代码
2. 说明需求：增加异常处理和超时机制
3. 让 Claude 修改代码并生成符合 Conventional Commits 规范的提交信息

整个过程几分钟就完成了，而且代码质量很高。
-->
---

## 场景三：快速上手不熟悉的项目

举例：[FastAPI](https://fastapi.tiangolo.com/)

**示例Prompt**：

> 我刚 clone 了 FastAPI 项目，请用不超过 200 字说明其核心模块划分，并指出从哪个文件开始阅读最有助于理解请求处理流程。要求：语言使用简体中文。

Claude 的[回答](./2025-10-22-clone-fastapi-200.md)

<!--
第三个场景是快速理解开源项目。最近我想研究 FastAPI，就克隆了源码。

我对 Claude 说："我刚 clone 了 FastAPI 项目，请用不超过 200 字说明其核心模块划分，并指出从哪个文件开始阅读最有助于理解请求处理流程。要求：语言使用简体中文。"

Claude 的回答非常精准，它告诉我 FastAPI 的核心模块包括应用核心、路由系统、参数系统、依赖注入等，并建议从 `fastapi/applications.py` 开始阅读。

这比我手动摸索要快得多。
-->

---

## 参考链接

[1] [Claude Code: Best practices for agentic coding](https://www.anthropic.com/engineering/claude-code-best-practices)

[2] [智谱AI开放文档](https://docs.bigmodel.cn/cn/coding-plan/tool/claude)

[3] [What is the --resume Flag in Claude Code](https://claudelog.com/faqs/what-is-resume-flag-in-claude-code/)

[4] [Claude Code settings](https://docs.claude.com/en/docs/claude-code/settings)

[5] [Claude Code dangerously-skip-permissions: When to Use It (And When You Absolutely Shouldn't)](https://www.ksred.com/claude-code-dangerously-skip-permissions-when-to-use-it-and-when-you-absolutely-shouldnt/)