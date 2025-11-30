#ifndef ImageProcessor_hpp
#define ImageProcessor_hpp

#include <stdio.h>
#include <string>

// 前向声明，避免在头文件中包含UIKit
#ifdef __OBJC__
@class UIImage;
#else
typedef struct UIImage UIImage;
typedef struct CGRect {
    float x;
    float y;
    float width;
    float height;
} CGRect;
#endif

class ImageProcessor {
public:
    // 基础图像处理操作
    static void* applyBasicFilter(void* image, const std::string& filterType);
    static void* rotateImage(void* image, float degrees);
    static void* scaleImage(void* image, float scale);
    static void* cropImage(void* image, float x, float y, float width, float height);
    
    // 高级图像处理
    static void* adjustBrightness(void* image, float brightness);
    static void* adjustContrast(void* image, float contrast);
    static void* adjustSaturation(void* image, float saturation);
    
private:
    // 辅助方法
    static void processImagePixels(void* pixelData, int width, int height, const std::string& operation);
};

#endif /* ImageProcessor_hpp */