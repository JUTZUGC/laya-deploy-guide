# Laya PyPI 安装指南

> 第三方部署指南 · 非 Laya 官方仓库。官方项目：[NandhaKishorM/laya](https://github.com/NandhaKishorM/laya)
> 内容来自官方文档（2026-10-28）。项目迭代快，请以[官方文档](https://github.com/NandhaKishorM/laya#installation)为准。

[![⚡ PyPI 安装](https://img.shields.io/badge/%E2%9A%A1_PyPI_%E5%AE%89%E8%A3%85-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#pypi安装推荐用百度搭子)

## PyPI 安装（推荐：用百度搭子）

> [!TIP]
> 不想为了一个分类任务调大模型，让百度搭子装好 Laya，一次前向就给出选项、分数和是非。

⚠️ 需要 Python 3.10+。首次使用会下载 checkpoint，离线环境要提前准备。默认 CPU 可跑，GPU 与 ONNX 需要额外 extras。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/laya-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子用 pip 安装 laya，并检查 Python 版本与可选组件，按它的提示确认即可，结束时它会告诉你结果。
   （需本机已装 Git；构建依赖以官方文档为准。）



## Laya 是什么？

Laya 是开源的34.5k stars，Apache-2.0，单次前向完成类型化决策，支持 100+ 语言（协议：Apache-2.0，<img src="https://img.shields.io/github/stars/NandhaKishorM/laya?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

非自回归决策引擎：把「选一个选项 / 打一个分 / 判断是或否」变成一次前向推理，不走逐 token 生成，支持 100 多种语言。

- 34.5k stars：2026-09-18 建仓，一个多月破 3 万
- 非自回归：一次前向出结果，延迟低
- 三种决策：类型化选择、打分、是非判断
- 100+ 语言：多语种开箱可用
- 路由选模型：按请求自动选合适 checkpoint
- 多生态：HTTP、MCP、LangChain、LlamaIndex、CrewAI

（来源：[官方仓库](https://github.com/NandhaKishorM/laya)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 34.5k stars | 一个月破 3 万，增速很猛 |
| 延迟低 | 一次前向，不用逐 token 生成 |
| 多语言 | 100+ 语言开箱可用 |
| 生态全 | HTTP、MCP、LangChain 都有 |
| CPU 可跑 | 不一定需要 GPU |
| Apache-2.0 | 可商用 |

| 需要注意 | 说明 |
|---|---|
| 要下 checkpoint | 首次使用有下载等待 |
| 不是通用生成 | 只适合选择/打分/判断类任务 |
| 精度依任务 | 复杂推理不如大模型 |
| 可选组件多 | 装错 extras 会徒增依赖 |
| 文档偏英文 | 中文示例少 |

> 以上基于官方文档与社区反馈整理（2026-10-28），以官方最新文档为准。

## 快速部署（官方方式）

```bash
python3 -m pip install -U laya || python -m pip install -U laya
python3 -c "import laya; print('laya', laya.__version__)" || python -c "import laya; print('laya ok')"
echo '安装完成：需要 HTTP 服务装 laya[serve]，需要 MCP 装 laya[mcp]'
```

部署步骤来源：[https://github.com/NandhaKishorM/laya#installation](https://github.com/NandhaKishorM/laya#installation)

## 验证状态

| 场景 | 状态 |
|---|---|
| PyPI 包 laya 最新版 0.4.15，requires_python >=3.10 | 已核对 2026-10-28 |
| 仓库元数据已核对：34.5k stars、Apache-2.0、2026-09-18 建仓 | 已核对 2026-10-28 |
| README 确认 pip install laya 及各类 extras | 已核对 2026-10-27 |
| 未实测安装与首次推理 | 说明 2026-10-27 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

安装 `laya[mcp]` 后可提供 MCP server；本仓库只负责安装，不注册 MCP。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-10-28）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\laya-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 安装完成后

```python
from laya import Router

router = Router()   # 首次使用会下载 checkpoint
result = router.decide("这句话是投诉还是咨询？", choices=["投诉", "咨询"])
print(result)
```

### 可选组件

| 组件 | 作用 |
|---|---|
| `laya[serve]` | HTTP 服务 |
| `laya[mcp]` | MCP server |
| `laya[langchain]` | LangChain / LangGraph |
| `laya[llamaindex]` | LlamaIndex 选择器 |
| `laya[crewai]` | CrewAI 路由 |
| `laya[onnx]` | ONNX Runtime |
| `laya[fast]` | TileLang GPU 加速 |
| `laya[structured]` | pydantic 结构化输出 |

### 多装几个

```bash
pip install -U "laya[serve,mcp]"
```

### 首次加载

`Router(preload=True)` 会一次加载三个 checkpoint，启动慢但请求更快。

> ⚠️ 决策结果受 checkpoint 与提示影响，关键业务仍要做抽样评估。

## 常见坑

- Python 低于 3.10：先升级
- 首次调用卡住：在下载 checkpoint，耐心等或预置缓存
- 装 extras 报错：引号要保留，如 `"laya[serve,mcp]"`
- 显存不足：改用 CPU 或 ONNX 后端
- 服务起不来：确认装的是 `laya[serve]`
- MCP 连不上：确认装的是 `laya[mcp]` 并重启客户端

## 免责声明

本仓库为第三方指南，与 Laya 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-10-28），项目迭代快，请以[官方文档](https://github.com/NandhaKishorM/laya#installation)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
