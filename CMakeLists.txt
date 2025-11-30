# Tutu iOS应用 - CMake生成Xcode项目配置

cmake_minimum_required(VERSION 3.10)
project(Tutu LANGUAGES C CXX OBJC OBJCXX)

# iOS平台配置
set(CMAKE_SYSTEM_NAME iOS)
set(CMAKE_OSX_DEPLOYMENT_TARGET 13.0)
set(CMAKE_OSX_ARCHITECTURES "arm64;x86_64")
set(CMAKE_OSX_SYSROOT "iphoneos")

# C++标准
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

# 源文件
set(SOURCES
    main.m
    AppDelegate.m
    ViewController.m
    ImageProcessor.cpp
    ImageProcessorBridge.mm
)

# 头文件
set(HEADERS
    AppDelegate.h
    ViewController.h
    ImageProcessor.hpp
    ImageProcessorBridge.h
)

# 资源文件
set(RESOURCES
    Info.plist
    Base.lproj/LaunchScreen.storyboard
    Assets.xcassets
)

# 创建iOS应用
add_executable(Tutu MACOSX_BUNDLE ${SOURCES} ${HEADERS} ${RESOURCES})

# 设置iOS应用属性
set_target_properties(Tutu PROPERTIES
    MACOSX_BUNDLE_INFO_PLIST ${CMAKE_CURRENT_SOURCE_DIR}/Info.plist
    XCODE_ATTRIBUTE_TARGETED_DEVICE_FAMILY "1,2"
    XCODE_ATTRIBUTE_IPHONEOS_DEPLOYMENT_TARGET 13.0
    XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "iPhone Developer"
    XCODE_ATTRIBUTE_DEVELOPMENT_TEAM ""
    XCODE_ATTRIBUTE_PRODUCT_BUNDLE_IDENTIFIER "com.tutu.app"
    XCODE_ATTRIBUTE_ASSETCATALOG_COMPILER_APPICON_NAME AppIcon
    XCODE_ATTRIBUTE_ASSETCATALOG_COMPILER_LAUNCHIMAGE_NAME LaunchImage
)

# 链接iOS框架
target_link_libraries(Tutu 
    PRIVATE
        "-framework UIKit"
        "-framework Foundation"
        "-framework CoreGraphics"
        "-framework CoreImage"
        "-framework Photos"
        "-framework PhotosUI"
        "-framework Accelerate"
)

# 编译选项
target_compile_options(Tutu PRIVATE
    -fobjc-arc
    -fobjc-weak
    -fmodules
)

# 资源文件处理
set_source_files_properties(Assets.xcassets/Base.lproj/LaunchScreen.storyboard
    PROPERTIES
    MACOSX_PACKAGE_LOCATION "Resources"
)

# 设置CMake策略
cmake_policy(SET CMP0079 NEW)  # 允许target_link_libraries与不在目录中的目标一起工作