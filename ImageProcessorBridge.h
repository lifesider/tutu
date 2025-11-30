#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageProcessorBridge : NSObject

+ (UIImage *)applyGrayscaleFilter:(UIImage *)image;
+ (UIImage *)rotateImage:(UIImage *)image degrees:(float)degrees;
+ (UIImage *)scaleImage:(UIImage *)image scale:(float)scale;
+ (UIImage *)cropImage:(UIImage *)image rect:(CGRect)cropRect;
+ (UIImage *)adjustBrightness:(UIImage *)image brightness:(float)brightness;
+ (UIImage *)adjustContrast:(UIImage *)image contrast:(float)contrast;
+ (UIImage *)adjustSaturation:(UIImage *)image saturation:(float)saturation;

@end