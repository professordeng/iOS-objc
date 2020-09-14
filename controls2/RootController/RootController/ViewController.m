//
//  ViewController.m
//  RootController
//
//  Created by deng on 2020/7/13.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)dealloc
{
    NSLog(@"销毁登录页面");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)login:(id)sender {
    NSLog(@"登录");
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *vc = [sb instantiateViewControllerWithIdentifier:NSStringFromClass(UINavigationController.class)];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = vc;
}

@end
