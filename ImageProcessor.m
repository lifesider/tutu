//
//  ImageProcessor.m
//  Tutu
//
//  图像处理工具类实现
//

#import "ImageProcessor.h"
#import <CoreImage/CoreImage.h>

@implementation ImageProcessor

#pragma mark - 滤镜应用

+ (UIImage *)applyFilter:(UIImage *)image withType:(TTFilterType)filterType {
    if (!image) return nil;
    
    // 如果是原图，直接返回
    if (filterType == TTFilterTypeNone) {
        return image;
    }
    
    // 创建CIContext和CIImage
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:image];
    
    // 根据滤镜类型选择对应的CIFilter
    CIFilter *filter = nil;
    
    switch (filterType) {
        case TTFilterTypeMono:
            filter = [CIFilter filterWithName:@"CIPhotoEffectMono"];
            break;
        case TTFilterTypeTransfer:
            filter = [CIFilter filterWithName:@"CIPhotoEffectTransfer"];
            break;
        case TTFilterTypeChrome:
            filter = [CIFilter filterWithName:@"CIPhotoEffectChrome"];
            break;
        case TTFilterTypeInstant:
            filter = [CIFilter filterWithName:@"CIPhotoEffectInstant"];
            break;
        case TTFilterTypeFade:
            filter = [CIFilter filterWithName:@"CIPhotoEffectFade"];
            break;
        default:
            return image;
    }
    
    // 设置输入图像
    [filter setValue:inputImage forKey:kCIInputImageKey];
    
    // 获取输出图像
    CIImage *outputImage = filter.outputImage;
    if (!outputImage) return image;
    
    // 转换为UIImage
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:outputImage.extent];
    UIImage *resultImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    return resultImage;
}

#pragma mark - 图像调整

+ (UIImage *)adjustImage:(UIImage *)image 
              brightness:(CGFloat)brightness 
               contrast:(CGFloat)contrast 
              saturation:(CGFloat)saturation {
    if (!image) return nil;
    
    // 如果所有参数都是默认值，直接返回
    if (brightness == 0 && contrast == 1.0 && saturation == 1.0) {
        return image;
    }
    
    // 创建CIContext和CIImage
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:image];
    
    // 创建颜色控制滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIColorControls"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:@(brightness) forKey:kCIInputBrightnessKey];
    [filter setValue:@(contrast) forKey:kCIInputContrastKey];
    [filter setValue:@(saturation) forKey:kCIInputSaturationKey];
    
    // 获取输出图像
    CIImage *outputImage = filter.outputImage;
    if (!outputImage) return image;
    
    // 转换为UIImage
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:outputImage.extent];
    UIImage *resultImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    return resultImage;
}

#pragma mark - 图像变换

+ (UIImage *)rotateImage:(UIImage *)image degrees:(CGFloat)degrees {
    if (!image) return nil;
    
    // 转换角度为弧度
    CGFloat radians = degrees * M_PI / 180.0;
    
    // 获取图像尺寸
    CGSize size = image.size;
    
    // 计算旋转后的尺寸
    CGFloat newWidth = fabsf(size.width * cosf(radians)) + fabsf(size.height * sinf(radians));
    CGFloat newHeight = fabsf(size.height * cosf(radians)) + fabsf(size.width * sinf(radians));
    CGSize newSize = CGSizeMake(newWidth, newHeight);
    
    // 创建图形上下文
    UIGraphicsBeginImageContextWithOptions(newSize, NO, image.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 移动原点到中心
    CGContextTranslateCTM(context, newSize.width / 2, newSize.height / 2);
    
    // 应用旋转变换
    CGContextRotateCTM(context, radians);
    
    // 绘制原图
    [image drawInRect:CGRectMake(-size.width / 2, -size.height / 2, size.width, size.height)];
    
    // 获取旋转后的图像
    UIImage *rotatedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束图形上下文
    UIGraphicsEndImageContext();
    
    return rotatedImage;
}

+ (UIImage *)scaleImage:(UIImage *)image byScale:(CGFloat)scale {
    if (!image || scale <= 0) return nil;
    
    // 计算新尺寸
    CGSize newSize = CGSizeMake(image.size.width * scale, image.size.height * scale);
    
    // 创建图形上下文
    UIGraphicsBeginImageContextWithOptions(newSize, NO, image.scale);
    
    // 绘制缩放后的图像
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    
    // 获取缩放后的图像
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束图形上下文
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

+ (UIImage *)cropImage:(UIImage *)image toRect:(CGRect)rect {
    if (!image) return nil;
    
    // 确保裁剪区域有效
    CGRect validRect = CGRectIntersection(rect, CGRectMake(0, 0, image.size.width, image.size.height));
    if (CGRectIsNull(validRect)) return nil;
    
    // 考虑Retina屏幕的缩放
    CGRect scaledRect = CGRectMake(validRect.origin.x * image.scale,
                                 validRect.origin.y * image.scale,
                                 validRect.size.width * image.scale,
                                 validRect.size.height * image.scale);
    
    // 获取CGImage并裁剪
    CGImageRef originalCGImage = image.CGImage;
    CGImageRef croppedCGImage = CGImageCreateWithImageInRect(originalCGImage, scaledRect);
    
    // 创建新的UIImage
    UIImage *croppedImage = [UIImage imageWithCGImage:croppedCGImage scale:image.scale orientation:image.imageOrientation];
    
    // 释放资源
    CGImageRelease(croppedCGImage);
    
    return croppedImage;
}

#pragma mark - 组合效果

+ (UIImage *)applyCombinedEffects:(UIImage *)image
                       filterType:(TTFilterType)filterType
                        brightness:(CGFloat)brightness
                         contrast:(CGFloat)contrast
                        saturation:(CGFloat)saturation {
    if (!image) return nil;
    
    // 先应用亮度、对比度和饱和度调整
    UIImage *adjustedImage = [self adjustImage:image 
                                    brightness:brightness 
                                     contrast:contrast 
                                    saturation:saturation];
    
    // 再应用滤镜效果
    UIImage *finalImage = [self applyFilter:adjustedImage withType:filterType];
    
    return finalImage;
}

#pragma mark - 工具方法

+ (NSString *)nameForFilterType:(TTFilterType)filterType {
    switch (filterType) {
        case TTFilterTypeNone:
            return @"原图";
        case TTFilterTypeMono:
            return @"黑白";
        case TTFilterTypeTransfer:
            return @"怀旧";
        case TTFilterTypeChrome:
            return @"冷色调";
        case TTFilterTypeInstant:
            return @"暖色调";
        case TTFilterTypeFade:
            return @"复古";
        default:
            return @"未知";
    }
}

+ (NSArray<NSNumber *> *)allFilterTypes {
    return @[@(TTFilterTypeNone), 
             @(TTFilterTypeMono), 
             @(TTFilterTypeTransfer), 
             @(TTFilterTypeChrome), 
             @(TTFilterTypeInstant), 
             @(TTFilterTypeFade)];
}

@end