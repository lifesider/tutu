#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface ViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIButton *importButton;
@property (strong, nonatomic) UIButton *exportButton;
@property (strong, nonatomic) UIImage *currentImage;

@end