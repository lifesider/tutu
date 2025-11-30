//
//  AppDelegate.m
//  Tutu
//
//  应用委托 - 支持新的UI布局
//

#import "AppDelegate.h"
#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // 使用新的MainViewController作为根视图控制器
    MainViewController *mainViewController = [[MainViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    navigationController.navigationBarHidden = YES;
    self.window.rootViewController = navigationController;
    
    // 显示窗口
    [self.window makeKeyAndVisible];
    
    return YES;
}

// 所有UI相关功能现在都在MainViewController中实现
// 保持AppDelegate的简洁，只负责应用启动和窗口管理

- (void)applicationWillResignActive:(UIApplication *)application {
    // 应用即将进入后台
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // 应用已经进入后台
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // 应用即将进入前台
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // 应用已经进入前台
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // 应用即将终止
}

@end