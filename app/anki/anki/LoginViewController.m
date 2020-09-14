//
//  LoginViewController.m
//  anki
//
//  Created by deng on 2020/7/17.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "LoginViewController.h"
#import "TabBarController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)dealloc {
    NSLog(@"__%@__dealloc__", self.class);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)loginTapped:(id)sender {
    NSArray *windows = [UIApplication sharedApplication].windows;
    UIWindow *firstWindow = nil;
    if ([windows count] == 1) {
        firstWindow = [windows firstObject];
    } else {
        for (UIWindow *window in windows) {
            if (window.windowLevel == UIWindowLevelNormal) {
                firstWindow = window;
                break;
            }
        }
    }
    
    if (firstWindow) {
        // 获取故事板
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

        // 获取目标页面
        TabBarController *vc = [sb instantiateViewControllerWithIdentifier:NSStringFromClass(TabBarController.class)];

        // 默认 tab
        vc.selectedIndex = 0;
        
        // 切换根视图控制器为目标页面
        firstWindow.rootViewController = vc;
    }
}

@end
