//
//  ImageProcessor.h
//  Tutu
//
//  图像处理工具类 - 封装所有图片特效处理功能
//

#import <UIKit/UIKit.h>

// 滤镜类型枚举
typedef NS_ENUM(NSInteger, TTFilterType) {
    TTFilterTypeNone = 0,     // 原图
    TTFilterTypeMono,         // 黑白
    TTFilterTypeTransfer,     // 怀旧
    TTFilterTypeChrome,       // 冷色调
    TTFilterTypeInstant,      // 暖色调
    TTFilterTypeFade          // 复古
};

@interface ImageProcessor : NSObject

/**
 应用滤镜到图片
 
 @param image 原始图片
 @param filterType 滤镜类型
 @return 应用滤镜后的图片
 */
+ (UIImage *)applyFilter:(UIImage *)image withType:(TTFilterType)filterType;

/**
 调整图片的亮度、对比度和饱和度
 
 @param image 原始图片
 @param brightness 亮度（-1.0到1.0）
 @param contrast 对比度（0.5到2.0）
 @param saturation 饱和度（0.0到2.0）
 @return 调整后的图片
 */
+ (UIImage *)adjustImage:(UIImage *)image 
              brightness:(CGFloat)brightness 
               contrast:(CGFloat)contrast 
              saturation:(CGFloat)saturation;

/**
 旋转图片
 
 @param image 原始图片
 @param degrees 旋转角度（度数）
 @return 旋转后的图片
 */
+ (UIImage *)rotateImage:(UIImage *)image degrees:(CGFloat)degrees;

/**
 缩放图片
 
 @param image 原始图片
 @param scale 缩放比例
 @return 缩放后的图片
 */
+ (UIImage *)scaleImage:(UIImage *)image byScale:(CGFloat)scale;

/**
 裁剪图片
 
 @param image 原始图片
 @param rect 裁剪区域（相对于图片坐标系）
 @return 裁剪后的图片
 */
+ (UIImage *)cropImage:(UIImage *)image toRect:(CGRect)rect;

/**
 应用组合效果
 
 @param image 原始图片
 @param filterType 滤镜类型
 @param brightness 亮度
 @param contrast 对比度
 @param saturation 饱和度
 @return 应用所有效果后的图片
 */
+ (UIImage *)applyCombinedEffects:(UIImage *)image
                       filterType:(TTFilterType)filterType
                        brightness:(CGFloat)brightness
                         contrast:(CGFloat)contrast
                        saturation:(CGFloat)saturation;

/**
 获取滤镜名称
 
 @param filterType 滤镜类型
 @return 滤镜名称
 */
+ (NSString *)nameForFilterType:(TTFilterType)filterType;

/**
 获取所有滤镜类型的数组
 
 @return 包含所有滤镜类型的NSArray
 */
+ (NSArray<NSNumber *> *)allFilterTypes;

@end