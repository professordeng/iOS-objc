//
//  ViewController.m
//  CustomSearchBar
//
//  Created by deng on 2020/7/14.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"
#import "NavigationController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)dealloc {
    NSLog(@"__%@__dealloc__", self.class);
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)login:(id)sender {
    // 获取故事板
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    // 获取目标页面
    NavigationController *vc = [sb instantiateViewControllerWithIdentifier:NSStringFromClass(NavigationController.class)];

    // 获取当前窗口
    UIWindow *window = [UIApplication sharedApplication].keyWindow;

    // 切换根视图控制器为目标页面
    window.rootViewController = vc;
}

@end
