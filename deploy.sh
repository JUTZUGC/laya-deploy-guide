#!/usr/bin/env bash
set -euo pipefail
# Laya PyPI 安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/NandhaKishorM/laya#installation
# 更新日期：2026-10-28
# 类型：script
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v git >/dev/null 2>&1 || { echo "需要先安装 Git"; exit 1; }
command -v python3 >/dev/null 2>&1 || command -v python >/dev/null 2>&1 || { echo "需要先安装 Python 3"; exit 1; }

mkdir -p .download
cd .download

python3 -m pip install -U laya || python -m pip install -U laya
python3 -c "import laya; print('laya', laya.__version__)" || python -c "import laya; print('laya ok')"
echo '安装完成：需要 HTTP 服务装 laya[serve]，需要 MCP 装 laya[mcp]'

echo ""

echo "部署完成：运行 python -c "import laya; print(laya.__version__)" 验证；需要 HTTP 或 MCP 时再装 laya[serve] / laya[mcp]"
echo "若结果异常或需要改配置，请参考官方文档：https://github.com/NandhaKishorM/laya#installation"
