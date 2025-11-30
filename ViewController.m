#import "ViewController.h"
#import <Photos/Photos.h>

@interface ViewController ()

@property (strong, nonatomic) UIPinchGestureRecognizer *pinchGesture;
@property (strong, nonatomic) UIRotationGestureRecognizer *rotationGesture;
@property (strong, nonatomic) UIPanGestureRecognizer *panGesture;
@property (assign, nonatomic) CGFloat lastScale;
@property (assign, nonatomic) CGFloat lastRotation;
@property (assign, nonatomic) CGPoint lastPanPoint;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"图途";
    self.view.backgroundColor = [UIColor blackColor];
    
    [self setupUI];
    [self setupGestures];
    [self requestPhotoPermissions];
}

- (void)setupUI {
    // 图片显示区域
    self.imageView = [[UIImageView alloc] init];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.backgroundColor = [UIColor blackColor];
    self.imageView.userInteractionEnabled = YES;
    
    [self.view addSubview:self.imageView];
    
    // 导入按钮
    self.importButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.importButton setTitle:@"导入图片" forState:UIControlStateNormal];
    [self.importButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.importButton.backgroundColor = [UIColor systemBlueColor];
    self.importButton.layer.cornerRadius = 8;
    [self.importButton addTarget:self action:@selector(importImage:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.importButton];
    
    // 导出按钮
    self.exportButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.exportButton setTitle:@"导出图片" forState:UIControlStateNormal];
    [self.exportButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.exportButton.backgroundColor = [UIColor systemGreenColor];
    self.exportButton.layer.cornerRadius = 8;
    [self.exportButton addTarget:self action:@selector(exportImage:) forControlEvents:UIControlEventTouchUpInside];
    self.exportButton.enabled = NO;
    
    [self.view addSubview:self.exportButton];
    
    // 布局
    [self layoutSubviews];
}

- (void)layoutSubviews {
    CGFloat screenWidth = self.view.bounds.size.width;
    CGFloat screenHeight = self.view.bounds.size.height;
    CGFloat safeAreaTop = self.view.safeAreaInsets.top;
    CGFloat safeAreaBottom = self.view.safeAreaInsets.bottom;
    
    // 图片显示区域 (留出底部按钮空间)
    CGFloat buttonHeight = 50;
    CGFloat buttonSpacing = 20;
    CGFloat bottomArea = buttonHeight + buttonSpacing * 2;
    
    self.imageView.frame = CGRectMake(0, safeAreaTop, screenWidth, screenHeight - safeAreaTop - safeAreaBottom - bottomArea);
    
    // 按钮布局
    CGFloat buttonWidth = (screenWidth - buttonSpacing * 3) / 2;
    CGFloat buttonY = screenHeight - safeAreaBottom - buttonHeight - buttonSpacing;
    
    self.importButton.frame = CGRectMake(buttonSpacing, buttonY, buttonWidth, buttonHeight);
    self.exportButton.frame = CGRectMake(buttonSpacing * 2 + buttonWidth, buttonY, buttonWidth, buttonHeight);
}

- (void)setupGestures {
    // 缩放手势
    self.pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    [self.imageView addGestureRecognizer:self.pinchGesture];
    
    // 旋转手势
    self.rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotation:)];
    [self.imageView addGestureRecognizer:self.rotationGesture];
    
    // 拖动手势
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.imageView addGestureRecognizer:self.panGesture];
    
    self.lastScale = 1.0;
    self.lastRotation = 0.0;
}

- (void)requestPhotoPermissions {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (status != PHAuthorizationStatusAuthorized) {
                [self showPermissionAlert];
            }
        });
    }];
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

#pragma mark - 手势处理方法

- (void)handlePinch:(UIPinchGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.lastScale = 1.0;
    }
    
    CGFloat scale = 1.0 - (self.lastScale - gesture.scale);
    
    CGAffineTransform currentTransform = self.imageView.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
    self.imageView.transform = newTransform;
    
    self.lastScale = gesture.scale;
}

- (void)handleRotation:(UIRotationGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.lastRotation = 0.0;
    }
    
    CGFloat rotation = 0.0 - (self.lastRotation - gesture.rotation);
    
    CGAffineTransform currentTransform = self.imageView.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, rotation);
    self.imageView.transform = newTransform;
    
    self.lastRotation = gesture.rotation;
}

- (void)handlePan:(UIPanGestureRecognizer *)gesture {
    CGPoint translation = [gesture translationInView:self.view];
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.lastPanPoint = translation;
    }
    
    CGFloat dx = translation.x - self.lastPanPoint.x;
    CGFloat dy = translation.y - self.lastPanPoint.y;
    
    CGAffineTransform currentTransform = self.imageView.transform;
    CGAffineTransform newTransform = CGAffineTransformTranslate(currentTransform, dx, dy);
    self.imageView.transform = newTransform;
    
    self.lastPanPoint = translation;
}

#pragma mark - 图片导入导出

- (void)importImage:(UIButton *)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.allowsEditing = NO;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)exportImage:(UIButton *)sender {
    if (!self.currentImage) {
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
    
    UIImage *selectedImage = info[UIImagePickerControllerOriginalImage];
    if (selectedImage) {
        self.currentImage = selectedImage;
        self.imageView.image = selectedImage;
        self.exportButton.enabled = YES;
        
        // 重置变换
        self.imageView.transform = CGAffineTransformIdentity;
        self.lastScale = 1.0;
        self.lastRotation = 0.0;
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 工具方法

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end