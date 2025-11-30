#!/bin/bash

# Tutu iOS应用 - CMake生成Xcode项目脚本

echo "使用CMake生成Xcode项目..."
echo "=========================="

# 检查依赖
echo "1. 检查构建依赖..."

if ! command -v cmake &> /dev/null; then
    echo "❌ 未找到CMake，请先安装CMake"
    echo "   安装方法: brew install cmake"
    exit 1
fi
echo "✅ CMake已安装"

# 创建构建目录
echo ""
echo "2. 创建构建目录..."
mkdir -p build_xcode
cd build_xcode

# 生成Xcode项目
echo ""
echo "3. 生成Xcode项目..."
cmake .. -G Xcode

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Xcode项目生成成功！"
    echo ""
    echo "项目文件位置:"
    echo "   Xcode项目: build_xcode/Tutu.xcodeproj"
    echo ""
    echo "下一步操作："
    echo "1. 打开Xcode"
    echo "2. 选择 'Open a project or file'"
    echo "3. 导航到: $(pwd)/Tutu.xcodeproj"
    echo "4. 在Xcode中构建和运行项目"
    echo ""
    echo "或者使用命令行构建:"
    echo "   xcodebuild -project Tutu.xcodeproj -scheme Tutu -destination 'platform=iOS Simulator,name=iPhone 14' build"
    echo ""
    echo "项目特点："
    echo "✅ 完整的iOS应用项目结构"
    echo "✅ Objective-C++混合编程"
    echo "✅ C++高性能图像处理引擎"
    echo "✅ 支持手势操作"
    echo "✅ 相册导入导出功能"
else
    echo ""
    echo "❌ Xcode项目生成失败"
    echo ""
    echo "可能的解决方案："
    echo "1. 检查CMake版本（需要3.10以上）"
    echo "2. 确保Xcode命令行工具已安装"
    echo "3. 手动创建Xcode项目并导入源代码"
fi

# 返回原始目录
cd ..