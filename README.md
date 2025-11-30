# Tutu (图途) - iOS图像编辑应用

一个功能强大的iOS图像编辑应用，使用Objective-C和C++原生语言开发。

## 功能特性

- 📸 从相册导入图片
- 🔍 图片缩放和旋转操作
- 💾 导出保存到相册
- 🎨 基本图像编辑功能
- ✨ 多种滤镜效果（灰度、棕褐、颜色反转等）
- 🔧 图像参数调整（亮度、对比度、饱和度）
- 👆 手势操作支持（缩放、旋转、拖动）

## 技术栈

- Objective-C (主要开发语言)
- C++ (图像处理核心)
- Objective-C++ (混合编程桥接)
- UIKit
- Photos Framework
- Core Graphics
- Core Image
- Accelerate Framework

## 项目状态

✅ **项目已修复并构建成功！**

当前项目包含完整的Xcode项目配置，支持命令行构建和Xcode IDE开发。

## 项目结构

```
Tutu/
├── AppDelegate.h/m          # 应用代理
├── ViewController.h/m       # 主视图控制器
├── ImageProcessor.hpp       # C++图像处理引擎头文件
├── ImageProcessor.cpp       # C++图像处理引擎实现
├── ImageProcessorBridge.h   # Objective-C++桥接头文件
├── ImageProcessorBridge.mm  # Objective-C++桥接实现
├── main.m                   # 应用入口文件
├── Info.plist              # 应用配置文件
├── Base.lproj/             # 启动屏幕资源
├── Assets.xcassets/        # 应用图标资源
├── CMakeLists.txt          # CMake构建配置
└── build_xcode/            # Xcode项目文件
    └── Tutu.xcodeproj      # Xcode项目文件
```

## 开发环境要求

- Xcode 12.0+
- iOS 13.0+
- CMake 3.10+
- macOS 开发环境

## 快速开始

### 方法1：使用Xcode IDE（推荐）

1. 打开Xcode
2. 选择 "Open a project or file"
3. 导航到 `/Users/xunshan/tutu/build_xcode/`
4. 选择 `Tutu.xcodeproj`
5. 选择合适的模拟器或真机设备
6. 点击运行按钮（▶️）

### 方法2：命令行构建

```bash
# 生成Xcode项目
cd /Users/xunshan/tutu
./generate_xcode_project.sh

# 构建项目
cd build_xcode
xcodebuild -project Tutu.xcodeproj -scheme Tutu -destination 'platform=iOS Simulator,name=iPhone 16' build
```

### 方法3：完整构建流程

```bash
# 使用一键构建脚本
cd /Users/xunshan/tutu
./build_detailed.sh
```

## 核心功能详解

### 已实现功能
- ✅ **图片导入**（从相册）
- ✅ **图片导出**（保存到相册）
- ✅ **手势操作**：
  - 缩放（捏合手势）
  - 旋转（旋转手势）
  - 拖动（平移手势）
- ✅ **C++图像处理引擎**：
  - 灰度滤镜
  - 棕褐滤镜
  - 颜色反转
  - 图像旋转
  - 图像缩放
  - 图像裁剪
  - 亮度调整
  - 对比度调整
  - 饱和度调整

### 技术特性
- 🚀 **原生iOS性能**：使用Objective-C和C++原生开发
- 🔗 **Objective-C++混合编程**：无缝桥接Objective-C和C++代码
- ⚡ **Core Graphics优化**：利用系统级图形处理框架
- 🎯 **Accelerate框架**：高性能数学计算优化
- 📱 **现代iOS支持**：支持iOS 13.0及以上版本

## 权限配置

应用需要在 `Info.plist` 中配置以下权限：

```xml
<key>NSPhotoLibraryUsageDescription</key>
<string>需要访问相册以选择要编辑的图片</string>
<key>NSPhotoLibraryAddUsageDescription</key>
<string>需要保存编辑后的图片到相册</string>
```

## 构建和开发

### 语法检查
```bash
# 检查所有源代码语法
./check_syntax.sh
```

### 项目生成
```bash
# 重新生成Xcode项目
./generate_xcode_project.sh
```

### 详细构建
```bash
# 执行详细构建流程
./build_detailed.sh
```

## 下一步开发建议

### 功能扩展
1. **UI改进**：
   - 添加滤镜选择界面
   - 添加参数调节滑块
   - 改进按钮样式和布局

2. **高级功能**：
   - 实现撤销/重做功能
   - 添加文字和贴纸功能
   - 支持图层操作
   - 添加滤镜预览功能

3. **性能优化**：
   - 实现图像处理异步操作
   - 添加进度指示器
   - 优化大图片处理性能

### 技术改进
1. **架构优化**：
   - 实现MVC/MVVM架构
   - 添加单元测试
   - 实现模块化设计

2. **用户体验**：
   - 添加操作引导
   - 实现智能推荐
   - 支持批量处理

## 注意事项

- 🔒 **权限配置**：确保在Info.plist中正确配置相册权限描述
- 📱 **真机测试**：相册功能需要在真机上进行完整测试
- 🎯 **性能考虑**：大图片处理时注意内存使用情况
- 🔧 **兼容性**：确保在不同iOS版本和设备上测试兼容性

## 故障排除

### 常见问题
1. **构建失败**：检查Xcode版本和开发者证书配置
2. **权限问题**：确认相册权限描述已正确添加
3. **语法错误**：运行 `./check_syntax.sh` 检查代码语法
4. **项目问题**：重新生成Xcode项目 `./generate_xcode_project.sh`

### 支持工具
- ✅ `check_syntax.sh` - 语法检查脚本
- ✅ `generate_xcode_project.sh` - 项目生成脚本
- ✅ `build_detailed.sh` - 详细构建脚本

## 作者

图途开发团队

---

**最后更新**：项目已修复并构建成功，支持完整开发流程！