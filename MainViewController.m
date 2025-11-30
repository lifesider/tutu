//
//  MainViewController.m
//  Tutu
//

#import "MainViewController.h"
#import "ImageProcessor.h"
#import <Photos/Photos.h>

@interface MainViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIButton *importButton;
@property (strong, nonatomic) UIButton *exportButton;
@property (strong, nonatomic) UIView *adjustmentBar;
@property (strong, nonatomic) UIScrollView *adjustmentScrollView;

// 图片处理状态
@property (strong, nonatomic) UIImage *originalImage;
@property (assign, nonatomic) CGFloat currentRotation;
@property (assign, nonatomic) CGFloat currentScale;
@property (assign, nonatomic) CGFloat brightness;
@property (assign, nonatomic) CGFloat contrast;
@property (assign, nonatomic) CGFloat saturation;
@property (assign, nonatomic) TTFilterType currentFilter;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置深色背景
    self.view.backgroundColor = [UIColor colorWithRed:37.0/255.0 green:37.0/255.0 blue:37.0/255.0 alpha:1.0];
    
    // 初始化变量
    self.currentRotation = 0.0;
    self.currentScale = 1.0;
    self.brightness = 0.0;
    self.contrast = 1.0;
    self.saturation = 1.0;
    self.currentFilter = TTFilterTypeNone;
    
    // 创建UI组件
    [self createImportExportButtons];
    [self createImageView];
    [self createAdjustmentBar];
    
    // 添加手势
    [self addGesturesToImageView];
    
    // 添加状态栏半透明效果
    self.navigationController.navigationBarHidden = YES;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    // 确保在视图布局后正确设置组件位置
    [self layoutUIComponents];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)createImportExportButtons {
    // 导入按钮 - 左上角
    self.importButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.importButton setTitle:@"📷" forState:UIControlStateNormal];
    self.importButton.titleLabel.font = [UIFont systemFontOfSize:24];
    [self.importButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.importButton.backgroundColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
    self.importButton.layer.cornerRadius = 25;
    self.importButton.layer.shadowColor = [UIColor blackColor].CGColor;
    self.importButton.layer.shadowOpacity = 0.3;
    self.importButton.layer.shadowOffset = CGSizeMake(0, 2);
    self.importButton.layer.shadowRadius = 4;
    [self.importButton addTarget:self action:@selector(importImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.importButton];
    
    // 导出按钮 - 右上角
    self.exportButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.exportButton setTitle:@"⬆️" forState:UIControlStateNormal];
    self.exportButton.titleLabel.font = [UIFont systemFontOfSize:24];
    [self.exportButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.exportButton.backgroundColor = [UIColor colorWithRed:0.0 green:139.0/255.0 blue:69.0/255.0 alpha:1.0];
    self.exportButton.layer.cornerRadius = 25;
    self.exportButton.layer.shadowColor = [UIColor blackColor].CGColor;
    self.exportButton.layer.shadowOpacity = 0.3;
    self.exportButton.layer.shadowOffset = CGSizeMake(0, 2);
    self.exportButton.layer.shadowRadius = 4;
    [self.exportButton addTarget:self action:@selector(exportImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.exportButton];
}

- (void)createImageView {
    self.imageView = [[UIImageView alloc] init];
    self.imageView.backgroundColor = [UIColor colorWithRed:45.0/255.0 green:45.0/255.0 blue:45.0/255.0 alpha:1.0];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.layer.cornerRadius = 12;
    self.imageView.clipsToBounds = YES;
    self.imageView.layer.borderWidth = 1;
    self.imageView.layer.borderColor = [UIColor colorWithRed:60.0/255.0 green:60.0/255.0 blue:60.0/255.0 alpha:1.0].CGColor;
    [self.view addSubview:self.imageView];
}

- (void)createAdjustmentBar {
    // 底部调节栏容器
    self.adjustmentBar = [[UIView alloc] init];
    self.adjustmentBar.backgroundColor = [UIColor colorWithRed:28.0/255.0 green:28.0/255.0 blue:30.0/255.0 alpha:1.0];
    self.adjustmentBar.layer.cornerRadius = 16;
    self.adjustmentBar.layer.shadowColor = [UIColor blackColor].CGColor;
    self.adjustmentBar.layer.shadowOpacity = 0.5;
    self.adjustmentBar.layer.shadowOffset = CGSizeMake(0, -4);
    self.adjustmentBar.layer.shadowRadius = 8;
    [self.view addSubview:self.adjustmentBar];
    
    // 横向滚动视图
    self.adjustmentScrollView = [[UIScrollView alloc] init];
    self.adjustmentScrollView.showsHorizontalScrollIndicator = NO;
    [self.adjustmentBar addSubview:self.adjustmentScrollView];
    
    // 创建调节选项按钮
    [self createAdjustmentButtons];
}

- (void)createAdjustmentButtons {
    NSArray *options = @[@"滤镜", @"旋转", @"缩放", @"亮度", @"对比度", @"饱和度", @"裁剪"];
    NSArray *icons = @[@"🎨", @"🔄", @"🔍", @"☀️", @"🌈", @"🎭", @"✂️"];
    
    CGFloat buttonWidth = 80;
    CGFloat buttonHeight = 80;
    CGFloat padding = 10;
    
    for (NSInteger i = 0; i < options.count; i++) {
        UIView *buttonContainer = [[UIView alloc] initWithFrame:CGRectMake(i * (buttonWidth + padding), 10, buttonWidth, buttonHeight)];
        [self.adjustmentScrollView addSubview:buttonContainer];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(0, 0, buttonWidth, buttonHeight);
        [button setTitle:icons[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:32];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor colorWithRed:45.0/255.0 green:45.0/255.0 blue:45.0/255.0 alpha:1.0];
        button.layer.cornerRadius = 12;
        button.tag = i + 100;
        [button addTarget:self action:@selector(adjustmentButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [buttonContainer addSubview:button];
        
        // 下方标签
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, buttonHeight + 5, buttonWidth, 20)];
        label.text = options[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:12];
        [buttonContainer addSubview:label];
    }
    
    self.adjustmentScrollView.contentSize = CGSizeMake(options.count * (buttonWidth + padding), buttonHeight + 30);
}

- (void)layoutUIComponents {
    CGFloat safeAreaTop = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat buttonSize = 50;
    CGFloat padding = 20;
    CGFloat adjustmentBarHeight = 140;
    
    // 导入导出按钮布局
    self.importButton.frame = CGRectMake(padding, safeAreaTop + padding, buttonSize, buttonSize);
    self.exportButton.frame = CGRectMake(self.view.bounds.size.width - padding - buttonSize, safeAreaTop + padding, buttonSize, buttonSize);
    
    // 图片视图布局
    CGFloat imageViewY = CGRectGetMaxY(self.importButton.frame) + padding;
    CGFloat imageViewHeight = self.view.bounds.size.height - imageViewY - adjustmentBarHeight - padding;
    self.imageView.frame = CGRectMake(padding, imageViewY, self.view.bounds.size.width - 2 * padding, imageViewHeight);
    
    // 调节栏布局
    self.adjustmentBar.frame = CGRectMake(padding, self.view.bounds.size.height - adjustmentBarHeight - padding, self.view.bounds.size.width - 2 * padding, adjustmentBarHeight);
    self.adjustmentScrollView.frame = self.adjustmentBar.bounds;
}

- (void)addGesturesToImageView {
    // 缩放手势
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    [self.imageView addGestureRecognizer:pinchGesture];
    
    // 旋转手势
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotation:)];
    [self.imageView addGestureRecognizer:rotationGesture];
    
    // 拖动手势
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.imageView addGestureRecognizer:panGesture];
    
    self.imageView.userInteractionEnabled = YES;
    self.imageView.multipleTouchEnabled = YES;
}

#pragma mark - 手势处理

- (void)handlePinch:(UIPinchGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan || gesture.state == UIGestureRecognizerStateChanged) {
        self.currentScale *= gesture.scale;
        // 限制缩放范围
        self.currentScale = MAX(0.5, MIN(self.currentScale, 3.0));
        [self applyTransforms];
        gesture.scale = 1.0;
    }
}

- (void)handleRotation:(UIRotationGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan || gesture.state == UIGestureRecognizerStateChanged) {
        self.currentRotation += gesture.rotation;
        [self applyTransforms];
        gesture.rotation = 0.0;
    }
}

- (void)handlePan:(UIPanGestureRecognizer *)gesture {
    static CGPoint lastTranslation;
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        lastTranslation = CGPointZero;
    } else if (gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gesture translationInView:self.imageView.superview];
        CGPoint delta = CGPointMake(translation.x - lastTranslation.x, translation.y - lastTranslation.y);
        
        CGRect newFrame = self.imageView.frame;
        newFrame.origin.x += delta.x;
        newFrame.origin.y += delta.y;
        
        // 简单的边界检查，防止图片完全拖出屏幕
        CGRect safeBounds = CGRectInset(self.imageView.superview.bounds, -200, -200);
        if (CGRectIntersectsRect(newFrame, safeBounds)) {
            self.imageView.frame = newFrame;
        }
        
        lastTranslation = translation;
    }
}

- (void)applyTransforms {
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformScale(transform, self.currentScale, self.currentScale);
    transform = CGAffineTransformRotate(transform, self.currentRotation);
    self.imageView.transform = transform;
}

#pragma mark - 图片导入导出

- (void)importImage:(UIButton *)sender {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{            if (status == PHAuthorizationStatusAuthorized) {
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                imagePicker.allowsEditing = NO;
                [self presentViewController:imagePicker animated:YES completion:nil];
            } else {
                [self showPermissionAlert];
            }
        });
    }];
}

- (void)exportImage:(UIButton *)sender {
    if (!self.imageView.image) {
        [self showAlertWithTitle:@"提示" message:@"没有可导出的图片"];
        return;
    }
    
    // 创建要保存的图片（应用当前变换）
    UIGraphicsBeginImageContextWithOptions(self.imageView.bounds.size, NO, 0.0);
    [self.imageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            [PHPhotoLibrary.sharedPhotoLibrary performChanges:^{
                [PHAssetCreationRequest creationRequestForAssetFromImage:finalImage];
            } completionHandler:^(BOOL success, NSError * _Nullable error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (success) {
                        [self showAlertWithTitle:@"成功" message:@"图片已保存到相册"];
                    } else {
                        [self showAlertWithTitle:@"失败" message:@"保存图片失败"];
                    }
                });
            }];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showPermissionAlert];
            });
        }
    }];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 重置所有变换和效果参数
    self.currentRotation = 0.0;
    self.currentScale = 1.0;
    self.brightness = 0.0;
    self.contrast = 1.0;
    self.saturation = 1.0;
    
    // 保存原始图片
    self.originalImage = info[UIImagePickerControllerOriginalImage];
    self.imageView.image = self.originalImage;
    self.imageView.transform = CGAffineTransformIdentity;
    
    // 重置位置
    [self.view layoutIfNeeded];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 调节按钮处理

- (void)adjustmentButtonTapped:(UIButton *)sender {
    switch (sender.tag) {
        case 100: // 滤镜
            [self showFilterOptions];
            break;
        case 101: // 旋转
            [self rotateImageBy90Degrees];
            break;
        case 102: // 缩放
            [self showScaleSlider];
            break;
        case 103: // 亮度
            [self showBrightnessSlider];
            break;
        case 104: // 对比度
            [self showContrastSlider];
            break;
        case 105: // 饱和度
            [self showSaturationSlider];
            break;
        case 106: // 裁剪
            [self showCropOptions];
            break;
        default:
            break;
    }
}

- (IBAction)rotateButtonTapped:(id)sender {
    [self rotateImageBy90Degrees];
}

- (IBAction)zoomButtonTapped:(id)sender {
    [self showScaleSlider];
}

- (IBAction)brightnessButtonTapped:(id)sender {
    [self showBrightnessSlider];
}

- (IBAction)contrastButtonTapped:(id)sender {
    [self showContrastSlider];
}

- (IBAction)saturationButtonTapped:(id)sender {
    [self showSaturationSlider];
}

- (IBAction)importButtonTapped:(id)sender {
    [self importImage:sender];
}

- (IBAction)exportButtonTapped:(id)sender {
    [self exportImage];
}

- (IBAction)filterButtonTapped:(id)sender {
    [self showFilterOptions];
}

- (void)exportImage {
    if (!self.imageView.image) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"没有图片可导出" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    UIAlertController *alert;
    if (error) {
        alert = [UIAlertController alertControllerWithTitle:@"导出失败" message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
    } else {
        alert = [UIAlertController alertControllerWithTitle:@"导出成功" message:@"图片已保存到相册" preferredStyle:UIAlertControllerStyleAlert];
    }
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showFilterOptions {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择滤镜" 
                                                                   message:nil 
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    // 使用ImageProcessor获取所有滤镜类型和名称
    for (NSNumber *filterTypeNum in [ImageProcessor allFilterTypes]) {
        TTFilterType filterType = (TTFilterType)[filterTypeNum integerValue];
        NSString *filterName = [ImageProcessor nameForFilterType:filterType];
        
        [alert addAction:[UIAlertAction actionWithTitle:filterName style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.currentFilter = filterType;
            [self applyFilter];
        }]];
    }
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)rotateImageBy90Degrees {
    self.currentRotation += M_PI_2;
    [self applyTransforms];
}

- (void)showScaleSlider {
    [self showSliderForType:@"缩放" minimumValue:0.5 maximumValue:3.0 initialValue:self.currentScale target:self selector:@selector(scaleSliderChanged:) confirmAction:@selector(confirmScale:)];
}

- (void)showBrightnessSlider {
    [self showSliderForType:@"亮度" minimumValue:-1.0 maximumValue:1.0 initialValue:self.brightness target:self selector:@selector(brightnessSliderChanged:) confirmAction:@selector(confirmBrightness:)];
}

- (void)showContrastSlider {
    [self showSliderForType:@"对比度" minimumValue:0.5 maximumValue:2.0 initialValue:self.contrast target:self selector:@selector(contrastSliderChanged:) confirmAction:@selector(confirmContrast:)];
}

- (void)showSaturationSlider {
    [self showSliderForType:@"饱和度" minimumValue:0.0 maximumValue:2.0 initialValue:self.saturation target:self selector:@selector(saturationSliderChanged:) confirmAction:@selector(confirmSaturation:)];
}

- (void)showCropOptions {
    [self showAlertWithTitle:@"提示" message:@"裁剪功能即将上线"];
}

- (void)showSliderForType:(NSString *)type minimumValue:(CGFloat)minimumValue maximumValue:(CGFloat)maximumValue initialValue:(CGFloat)initialValue target:(id)target selector:(SEL)selector confirmAction:(SEL)confirmAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:type 
                                                                   message:nil 
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(10, 10, 250, 40)];
    slider.minimumValue = minimumValue;
    slider.maximumValue = maximumValue;
    slider.value = initialValue;
    slider.minimumTrackTintColor = [UIColor systemBlueColor];
    slider.maximumTrackTintColor = [UIColor lightGrayColor];
    [slider addTarget:target action:selector forControlEvents:UIControlEventValueChanged];
    slider.tag = 200;
    
    UIView *sliderContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 270, 40)];
    [sliderContainer addSubview:slider];
    
    [alert.view addSubview:sliderContainer];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [target performSelector:confirmAction withObject:slider];
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 滑块事件处理

- (void)scaleSliderChanged:(UISlider *)slider {
    self.currentScale = slider.value;
    [self applyTransforms];
}

- (void)confirmScale:(UISlider *)slider {
    // 已在scaleSliderChanged中实时应用
}

- (void)brightnessSliderChanged:(UISlider *)slider {
    self.brightness = slider.value;
    [self applyImageEffects];
}

- (void)confirmBrightness:(UISlider *)slider {
    // 已在brightnessSliderChanged中实时应用
}

- (void)contrastSliderChanged:(UISlider *)slider {
    self.contrast = slider.value;
    [self applyImageEffects];
}

- (void)confirmContrast:(UISlider *)slider {
    // 已在contrastSliderChanged中实时应用
}

- (void)saturationSliderChanged:(UISlider *)slider {
    self.saturation = slider.value;
    [self applyImageEffects];
}

- (void)confirmSaturation:(UISlider *)slider {
    // 已在saturationSliderChanged中实时应用
}

#pragma mark - 图像处理

- (void)applyFilter {
    if (!self.originalImage) return;
    
    // 使用ImageProcessor应用滤镜
    self.imageView.image = [ImageProcessor applyCombinedEffects:self.originalImage
                                                      filterType:self.currentFilter
                                                       brightness:self.brightness
                                                        contrast:self.contrast
                                                       saturation:self.saturation];
}

- (void)applyImageEffects {
    if (!self.originalImage) return;
    
    // 使用ImageProcessor应用组合效果
    self.imageView.image = [ImageProcessor applyCombinedEffects:self.originalImage
                                                      filterType:self.currentFilter
                                                       brightness:self.brightness
                                                        contrast:self.contrast
                                                       saturation:self.saturation];
}

// 现在使用ImageProcessor类进行图像处理，不再需要这个方法

#pragma mark - 工具方法

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showPermissionAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"权限请求"
                                                                   message:@"需要访问相册权限才能使用图片导入导出功能"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end