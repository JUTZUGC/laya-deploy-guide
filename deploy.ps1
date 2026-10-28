# Laya PyPI 安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/NandhaKishorM/laya#installation
# 更新日期：2026-10-28
# 类型：script
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw '需要先安装 Git' }
if (-not (Get-Command python -ErrorAction SilentlyContinue)) { throw '需要先安装 Python 3' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

python -m pip install -U laya
python -c "import laya; print('laya installed')"
Write-Host '安装完成：需要 HTTP 服务装 laya[serve]，需要 MCP 装 laya[mcp]'

Write-Host ''

Write-Host '部署完成：运行 python -c "import laya; print(laya.__version__)" 验证；需要 HTTP 或 MCP 时再装 laya[serve] / laya[mcp]'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://github.com/NandhaKishorM/laya#installation'
