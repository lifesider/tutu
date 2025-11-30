#ifndef ImageProcessor_hpp
#define ImageProcessor_hpp

#include <stdio.h>
#include <UIKit/UIKit.h>

class ImageProcessor {
public:
    // 基础图像处理操作
    static UIImage* applyBasicFilter(UIImage* image, const std::string& filterType);
    static UIImage* rotateImage(UIImage* image, float degrees);
    static UIImage* scaleImage(UIImage* image, float scale);
    static UIImage* cropImage(UIImage* image, CGRect cropRect);
    
    // 高级图像处理
    static UIImage* adjustBrightness(UIImage* image, float brightness);
    static UIImage* adjustContrast(UIImage* image, float contrast);
    static UIImage* adjustSaturation(UIImage* image, float saturation);
    
private:
    // 辅助方法
    static void processImagePixels(void* pixelData, int width, int height, const std::string& operation);
};

#endif /* ImageProcessor_hpp */