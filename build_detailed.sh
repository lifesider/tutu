#!/bin/bash

# Tutu iOS应用 - 详细构建脚本

echo "构建Tutu iOS应用..."
echo "===================="

# 检查构建目录
if [ ! -d "build_xcode" ]; then
    echo "❌ 未找到build_xcode目录，请先运行generate_xcode_project.sh"
    exit 1
fi

cd build_xcode

# 清理之前的构建
echo "1. 清理之前的构建..."
xcodebuild -project Tutu.xcodeproj -scheme Tutu clean

# 尝试构建并捕获详细输出
echo ""
echo "2. 开始构建项目..."
echo "构建命令: xcodebuild -project Tutu.xcodeproj -scheme Tutu -destination 'platform=iOS Simulator,name=iPhone 16' build"
echo ""

# 构建并显示详细输出
xcodebuild -project Tutu.xcodeproj -scheme Tutu -destination 'platform=iOS Simulator,name=iPhone 16' build -verbose

# 检查构建结果
if [ $? -eq 0 ]; then
    echo ""
    echo "✅ 构建成功！"
    echo ""
    echo "应用位置:"
    find . -name "*.app" -type d
    echo ""
    echo "安装和运行："
    echo "1. 在Xcode中打开项目: open Tutu.xcodeproj"
    echo "2. 选择目标设备并运行"
else
    echo ""
    echo "❌ 构建失败"
    echo ""
    echo "建议："
    echo "1. 检查源代码中的语法错误"
    echo "2. 确保所有依赖框架都已正确链接"
    echo "3. 在Xcode中打开项目查看详细错误信息"
    echo ""
    echo "查看构建日志："
    echo "open ~/Library/Logs/DiagnosticReports/"
fi