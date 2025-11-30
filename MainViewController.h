//
//  MainViewController.h
//  Tutu
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

// 导入/导出按钮方法
- (IBAction)importButtonTapped:(id)sender;
- (IBAction)exportButtonTapped:(id)sender;

// 特效调节方法
- (IBAction)filterButtonTapped:(id)sender;
- (IBAction)rotateButtonTapped:(id)sender;
- (IBAction)zoomButtonTapped:(id)sender;
- (IBAction)brightnessButtonTapped:(id)sender;
- (IBAction)contrastButtonTapped:(id)sender;
- (IBAction)saturationButtonTapped:(id)sender;

// 滑块显示方法
- (void)showSliderForType:(NSString *)type minimumValue:(CGFloat)minValue maximumValue:(CGFloat)maxValue initialValue:(CGFloat)initialValue target:(id)target selector:(SEL)selector confirmAction:(SEL)confirmAction;

// 滑块变化方法
- (void)brightnessSliderChanged:(UISlider *)sender;
- (void)contrastSliderChanged:(UISlider *)sender;
- (void)saturationSliderChanged:(UISlider *)sender;

// 确认调节方法
- (void)confirmBrightness:(UISlider *)sender;
- (void)confirmContrast:(UISlider *)sender;
- (void)confirmSaturation:(UISlider *)sender;

@end