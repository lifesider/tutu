# Tutu (图途) - iOS图像编辑应用

一个功能强大的iOS图像编辑应用，使用Objective-C和C++原生语言开发。

## 功能特性

- 📸 从相册导入图片
- 🔍 图片缩放和旋转操作
- 💾 导出保存到相册
- 🎨 基本图像编辑功能

## 技术栈

- Objective-C (主要开发语言)
- C++ (图像处理核心)
- UIKit
- Photos Framework
- Core Graphics

## 项目结构

```
Tutu/
├── AppDelegate.h/m          # 应用代理
├── ViewController.h/m       # 主视图控制器
├── Models/                  # 数据模型
├── Views/                   # 自定义视图
├── Controllers/             # 视图控制器
├── Utils/                   # 工具类
├── C++/                     # C++图像处理代码
└── Resources/               # 资源文件
```

## 开发环境要求

- Xcode 12.0+
- iOS 13.0+
- Swift 5.0+

## 安装和运行

1. 克隆项目
2. 打开 `Tutu.xcodeproj`
3. 选择合适的模拟器或真机
4. 编译运行

## 权限配置

需要在 Info.plist 中添加以下权限：
- 相册读取权限
- 相册写入权限

## 作者

图途开发团队