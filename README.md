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

✅ **语法检查通过** - 所有源代码文件语法正确
✅ **Xcode项目生成成功** - CMake配置正确
✅ **构建成功** - 项目可以成功编译
✅ **UI框架设计完成** - SwiftUI风格UIKit界面设计完成
✅ **应用安装成功** - 应用已安装到iOS模拟器

## 项目结构

```
/Users/xunshan/tutu/
├── Tutu.xcodeproj/        # Xcode项目文件
├── build_xcode/           # 构建输出目录
├── MainViewController.h   # 主视图控制器头文件
├── MainViewController.m   # 主视图控制器实现文件
├── AppDelegate.h          # 应用代理头文件
├── AppDelegate.m          # 应用代理实现文件
├── ViewController.h       # 视图控制器头文件
├── ViewController.m       # 视图控制器实现文件
├── Main.storyboard        # 主界面故事板
├── Info.plist             # 应用配置文件
├── README.md              # 项目说明文档
└── *.sh                   # 构建和测试脚本

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

# 安装到模拟器
xcrun simctl install booted Debug-iphonesimulator/Tutu.app
xcrun simctl launch booted com.tutu.app
```

### UI测试
```bash
./test_ui.sh
```

### 方法3：完整构建流程

```bash
# 使用一键构建脚本
cd /Users/xunshan/tutu
./build_detailed.sh
```

## 核心功能详解

### UI界面设计
- **整体布局**: 简约现代风格，符合iOS设计规范
- **顶部导航栏**:
  - **导入按钮**: 左上角 📷 图标，蓝色圆形按钮，用于从相册选择图片
  - **导出按钮**: 右上角 ⬆️ 图标，绿色圆形按钮，用于保存图片到相册
- **图片显示区**: 中央大区域，用于显示当前编辑的图片
- **底部工具栏**:
  - 滤镜按钮：应用各种图像滤镜
  - 旋转按钮：顺时针旋转图片90度
  - 缩放按钮：调整图片大小
  - 亮度按钮：调整图像亮度
  - 对比度按钮：调整图像对比度
  - 饱和度按钮：调整图像饱和度

### 已实现功能
- ✅ **图片导入**（从相册）
- ✅ **图片导出**（保存到相册）
- ✅ **滤镜效果**：支持多种滤镜选项
- ✅ **图像变换**：
  - 旋转（顺时针90度）
  - 缩放（通过滑块控制）
- ✅ **图像调整**：
  - 亮度调节
  - 对比度调节
  - 饱和度调节
- ✅ **用户界面**：按照设计规范实现的简洁界面

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