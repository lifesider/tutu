#import "ImageProcessorBridge.h"
#include "ImageProcessor.hpp"

@implementation ImageProcessorBridge

+ (UIImage *)applyGrayscaleFilter:(UIImage *)image {
    if (!image) return nil;
    
    void* processedImage = ImageProcessor::applyBasicFilter((__bridge void*)image, "grayscale");
    return (__bridge UIImage*)processedImage;
}

+ (UIImage *)rotateImage:(UIImage *)image degrees:(float)degrees {
    if (!image) return nil;
    
    void* processedImage = ImageProcessor::rotateImage((__bridge void*)image, degrees);
    return (__bridge UIImage*)processedImage;
}

+ (UIImage *)scaleImage:(UIImage *)image scale:(float)scale {
    if (!image) return nil;
    
    void* processedImage = ImageProcessor::scaleImage((__bridge void*)image, scale);
    return (__bridge UIImage*)processedImage;
}

+ (UIImage *)cropImage:(UIImage *)image rect:(CGRect)cropRect {
    if (!image) return nil;
    
    void* processedImage = ImageProcessor::cropImage((__bridge void*)image, cropRect.origin.x, cropRect.origin.y, cropRect.size.width, cropRect.size.height);
    return (__bridge UIImage*)processedImage;
}

+ (UIImage *)adjustBrightness:(UIImage *)image brightness:(float)brightness {
    if (!image) return nil;
    
    void* processedImage = ImageProcessor::adjustBrightness((__bridge void*)image, brightness);
    return (__bridge UIImage*)processedImage;
}

+ (UIImage *)adjustContrast:(UIImage *)image contrast:(float)contrast {
    if (!image) return nil;
    
    void* processedImage = ImageProcessor::adjustContrast((__bridge void*)image, contrast);
    return (__bridge UIImage*)processedImage;
}

+ (UIImage *)adjustSaturation:(UIImage *)image saturation:(float)saturation {
    if (!image) return nil;
    
    void* processedImage = ImageProcessor::adjustSaturation((__bridge void*)image, saturation);
    return (__bridge UIImage*)processedImage;
}

@end