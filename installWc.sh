#!/bin/bash
set -e

echo "🔍 检测系统信息..."
. /etc/os-release
echo "系统: $PRETTY_NAME"

# 检测 t64 支持
echo "检测是否需要 t64 后缀..."
if apt-cache search libatk1.0-0t64 | grep -q libatk1.0-0t64; then
    T64_SUFFIX="t64"
    echo "✅ 系统使用 t64 包命名"
else
    T64_SUFFIX=""
    echo "✅ 系统使用旧包命名"
fi

# 检测 libtiff 版本
if apt-cache search libtiff6 | grep -q libtiff6; then
    LIBTIFF="libtiff6"
elif apt-cache search libtiff5 | grep -q libtiff5; then
    LIBTIFF="libtiff5"
else
    echo "❌ 未找到 libtiff 对应包，请检查源配置"
    exit 1
fi

# 检测 libjpeg 版本
if apt-cache search libjpeg-turbo8 | grep -q libjpeg-turbo8; then
    LIBJPEG="libjpeg-turbo8"
elif apt-cache search libjpeg62-turbo | grep -q libjpeg62-turbo; then
    LIBJPEG="libjpeg62-turbo"
else
    echo "❌ 未找到 libjpeg 对应包，请检查源配置"
    exit 1
fi

# 安装依赖
echo "📦 安装 WeChat 所需依赖..."
sudo apt update
sudo apt install -y \
    libxkbcommon-x11-0 \
    libxcb-icccm4 \
    libxcb-image0 \
    libxcb-keysyms1 \
    libxcb-randr0 \
    libxcb-render-util0 \
    libxcb-shape0 \
    libxcb-xfixes0 \
    libxcb-xinerama0 \
    libxcb-util1 \
    libnss3 \
    libatk1.0-0${T64_SUFFIX} \
    libatk-bridge2.0-0${T64_SUFFIX} \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libasound2${T64_SUFFIX} \
    libpangocairo-1.0-0 \
    libpango-1.0-0 \
    libcairo2 \
    libgtk-3-0${T64_SUFFIX} \
    libpng16-16${T64_SUFFIX} \
    libcups2${T64_SUFFIX} \
    $LIBTIFF \
    $LIBJPEG

# 修复 libtiff.so.5 缺失问题
echo "🔍 检查 libtiff.so.5..."
if ! ldconfig -p | grep -q libtiff.so.5; then
    echo "⚠️  系统缺少 libtiff.so.5，尝试创建兼容软链接..."
    TIFF_PATH=$(ldconfig -p | grep libtiff.so.6 | awk '{print $NF}' | head -n1)
    if [ -n "$TIFF_PATH" ]; then
        sudo ln -sf "$TIFF_PATH" "$(dirname "$TIFF_PATH")/libtiff.so.5"
        echo "✅ 已创建 $(dirname "$TIFF_PATH")/libtiff.so.5 软链接"
    else
        echo "❌ 未找到 libtiff.so.6，无法创建兼容链接"
    fi
else
    echo "✅ libtiff.so.5 已存在"
fi

echo "✅ WeChat 依赖安装完成，可以尝试运行 wechat"

