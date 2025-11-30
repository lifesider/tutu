#include "ImageProcessor.hpp"
#import <CoreGraphics/CoreGraphics.h>
#import <Accelerate/Accelerate.h>

UIImage* ImageProcessor::applyBasicFilter(UIImage* image, const std::string& filterType) {
    if (!image) return nullptr;
    
    // 获取图像尺寸
    CGSize size = image.size;
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    // 创建图形上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, image.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 绘制原始图像
    [image drawInRect:rect];
    
    // 根据滤镜类型应用效果
    if (filterType == "grayscale") {
        // 灰度滤镜
        CGContextSetBlendMode(context, kCGBlendModeSaturation);
        CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 1.0);
        CGContextFillRect(context, rect);
    } else if (filterType == "sepia") {
        // 棕褐滤镜
        CGContextSetBlendMode(context, kCGBlendModeColor);
        CGContextSetRGBFillColor(context, 0.8, 0.6, 0.4, 0.3);
        CGContextFillRect(context, rect);
    }
    
    // 获取处理后的图像
    UIImage* filteredImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return filteredImage;
}

UIImage* ImageProcessor::rotateImage(UIImage* image, float degrees) {
    if (!image) return nullptr;
    
    // 转换角度为弧度
    CGFloat radians = degrees * M_PI / 180.0;
    
    // 计算旋转后的尺寸
    CGSize size = image.size;
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    // 创建图形上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, image.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 移动到中心点并旋转
    CGContextTranslateCTM(context, size.width / 2, size.height / 2);
    CGContextRotateCTM(context, radians);
    CGContextTranslateCTM(context, -size.width / 2, -size.height / 2);
    
    // 绘制图像
    [image drawInRect:rect];
    
    // 获取旋转后的图像
    UIImage* rotatedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return rotatedImage;
}

UIImage* ImageProcessor::scaleImage(UIImage* image, float scale) {
    if (!image) return nullptr;
    
    // 计算缩放后的尺寸
    CGSize originalSize = image.size;
    CGSize newSize = CGSizeMake(originalSize.width * scale, originalSize.height * scale);
    
    // 创建图形上下文
    UIGraphicsBeginImageContextWithOptions(newSize, NO, image.scale);
    CGRect rect = CGRectMake(0, 0, newSize.width, newSize.height);
    
    // 绘制缩放后的图像
    [image drawInRect:rect];
    
    // 获取缩放后的图像
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

UIImage* ImageProcessor::cropImage(UIImage* image, CGRect cropRect) {
    if (!image) return nullptr;
    
    // 创建图形上下文
    UIGraphicsBeginImageContextWithOptions(cropRect.size, NO, image.scale);
    
    // 绘制裁剪区域
    [image drawInRect:CGRectMake(-cropRect.origin.x, -cropRect.origin.y, image.size.width, image.size.height)];
    
    // 获取裁剪后的图像
    UIImage* croppedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return croppedImage;
}

UIImage* ImageProcessor::adjustBrightness(UIImage* image, float brightness) {
    if (!image) return nullptr;
    
    // 调整亮度的简单实现
    CGSize size = image.size;
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, image.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 绘制原始图像
    [image drawInRect:rect];
    
    // 应用亮度调整
    CGContextSetBlendMode(context, kCGBlendModeOverlay);
    CGContextSetRGBFillColor(context, brightness, brightness, brightness, 0.5);
    CGContextFillRect(context, rect);
    
    UIImage* adjustedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return adjustedImage;
}

UIImage* ImageProcessor::adjustContrast(UIImage* image, float contrast) {
    if (!image) return nullptr;
    
    // 调整对比度的简单实现
    CGSize size = image.size;
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, image.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 绘制原始图像
    [image drawInRect:rect];
    
    // 应用对比度调整
    CGContextSetBlendMode(context, kCGBlendModeSoftLight);
    CGContextSetRGBFillColor(context, contrast, contrast, contrast, 0.3);
    CGContextFillRect(context, rect);
    
    UIImage* adjustedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return adjustedImage;
}

UIImage* ImageProcessor::adjustSaturation(UIImage* image, float saturation) {
    if (!image) return nullptr;
    
    // 调整饱和度的简单实现
    CGSize size = image.size;
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, image.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 绘制原始图像
    [image drawInRect:rect];
    
    // 应用饱和度调整
    if (saturation < 1.0) {
        CGContextSetBlendMode(context, kCGBlendModeSaturation);
        CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 1.0 - saturation);
        CGContextFillRect(context, rect);
    }
    
    UIImage* adjustedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return adjustedImage;
}

void ImageProcessor::processImagePixels(void* pixelData, int width, int height, const std::string& operation) {
    // 像素级图像处理的基础实现
    // 这里可以添加更复杂的图像处理算法
    
    unsigned char* pixels = static_cast<unsigned char*>(pixelData);
    int pixelCount = width * height * 4; // RGBA
    
    if (operation == "invert") {
        // 颜色反转
        for (int i = 0; i < pixelCount; i += 4) {
            pixels[i] = 255 - pixels[i];     // R
            pixels[i + 1] = 255 - pixels[i + 1]; // G
            pixels[i + 2] = 255 - pixels[i + 2]; // B
            // Alpha 通道保持不变
        }
    }
}