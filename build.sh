#!/bin/bash

# Tutu iOS App 构建脚本

echo "开始构建Tutu图像编辑应用..."

# 检查Xcode是否安装
if ! command -v xcodebuild &> /dev/null; then
    echo "错误：未找到Xcode，请先安装Xcode"
    exit 1
fi

# 清理构建
xcodebuild clean -project Tutu.xcodeproj -scheme Tutu

# 构建项目
echo "正在构建项目..."
xcodebuild build -project Tutu.xcodeproj -scheme Tutu -destination 'platform=iOS Simulator,name=iPhone 14' -configuration Debug

if [ $? -eq 0 ]; then
    echo "构建成功！"
    echo "可以使用Xcode打开Tutu.xcodeproj进行开发和调试"
else
    echo "构建失败，请检查错误信息"
    exit 1
fi