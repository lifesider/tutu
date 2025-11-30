#!/bin/bash

# Tutu项目 - 源代码语法检查

echo "检查Tutu项目源代码语法..."
echo "============================"

# 检查Objective-C文件
echo "1. 检查Objective-C文件..."

if [ -f "main.m" ]; then
    echo "检查 main.m..."
    clang -fsyntax-only -x objective-c -isysroot $(xcrun --show-sdk-path --sdk iphonesimulator) main.m
    if [ $? -eq 0 ]; then
        echo "✅ main.m 语法正确"
    else
        echo "❌ main.m 有语法错误"
    fi
fi

if [ -f "AppDelegate.m" ]; then
    echo "检查 AppDelegate.m..."
    clang -fsyntax-only -x objective-c -isysroot $(xcrun --show-sdk-path --sdk iphonesimulator) AppDelegate.m
    if [ $? -eq 0 ]; then
        echo "✅ AppDelegate.m 语法正确"
    else
        echo "❌ AppDelegate.m 有语法错误"
    fi
fi

if [ -f "ViewController.m" ]; then
    echo "检查 ViewController.m..."
    clang -fsyntax-only -x objective-c -isysroot $(xcrun --show-sdk-path --sdk iphonesimulator) ViewController.m
    if [ $? -eq 0 ]; then
        echo "✅ ViewController.m 语法正确"
    else
        echo "❌ ViewController.m 有语法错误"
    fi
fi

# 检查C++文件
echo ""
echo "2. 检查C++文件..."

if [ -f "ImageProcessor.cpp" ]; then
    echo "检查 ImageProcessor.cpp..."
    clang++ -fsyntax-only -x c++ ImageProcessor.cpp
    if [ $? -eq 0 ]; then
        echo "✅ ImageProcessor.cpp 语法正确"
    else
        echo "❌ ImageProcessor.cpp 有语法错误"
    fi
fi

# 检查Objective-C++文件
echo ""
echo "3. 检查Objective-C++文件..."

if [ -f "ImageProcessorBridge.mm" ]; then
    echo "检查 ImageProcessorBridge.mm..."
    clang++ -fsyntax-only -x objective-c++ -isysroot $(xcrun --show-sdk-path --sdk iphonesimulator) ImageProcessorBridge.mm
    if [ $? -eq 0 ]; then
        echo "✅ ImageProcessorBridge.mm 语法正确"
    else
        echo "❌ ImageProcessorBridge.mm 有语法错误"
    fi
fi

echo ""
echo "语法检查完成！"
echo ""
echo "建议："
echo "1. 修复语法错误后重新运行CMake生成项目"
echo "2. 在Xcode中打开项目查看详细错误信息"
echo "3. 确保所有必要的iOS框架都已导入"