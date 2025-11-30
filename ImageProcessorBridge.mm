#import "ImageProcessorBridge.h"
#include "ImageProcessor.hpp"

@implementation ImageProcessorBridge

+ (UIImage *)applyGrayscaleFilter:(UIImage *)image {
    if (!image) return nil;
    
    UIImage* processedImage = ImageProcessor::applyBasicFilter(image, "grayscale");
    return processedImage;
}

+ (UIImage *)rotateImage:(UIImage *)image degrees:(float)degrees {
    if (!image) return nil;
    
    UIImage* processedImage = ImageProcessor::rotateImage(image, degrees);
    return processedImage;
}

+ (UIImage *)scaleImage:(UIImage *)image scale:(float)scale {
    if (!image) return nil;
    
    UIImage* processedImage = ImageProcessor::scaleImage(image, scale);
    return processedImage;
}

+ (UIImage *)cropImage:(UIImage *)image rect:(CGRect)cropRect {
    if (!image) return nil;
    
    UIImage* processedImage = ImageProcessor::cropImage(image, cropRect);
    return processedImage;
}

+ (UIImage *)adjustBrightness:(UIImage *)image brightness:(float)brightness {
    if (!image) return nil;
    
    UIImage* processedImage = ImageProcessor::adjustBrightness(image, brightness);
    return processedImage;
}

+ (UIImage *)adjustContrast:(UIImage *)image contrast:(float)contrast {
    if (!image) return nil;
    
    UIImage* processedImage = ImageProcessor::adjustContrast(image, contrast);
    return processedImage;
}

+ (UIImage *)adjustSaturation:(UIImage *)image saturation:(float)saturation {
    if (!image) return nil;
    
    UIImage* processedImage = ImageProcessor::adjustSaturation(image, saturation);
    return processedImage;
}

@end