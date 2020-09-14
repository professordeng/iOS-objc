//
//  TableViewController.m
//  RootController
//
//  Created by deng on 2020/7/13.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "TableViewController.h"
#import "ViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)dealloc
{
    NSLog(@"销毁笔记列表");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)logout:(id)sender {
    NSLog(@"退出登录");
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *vc = [sb instantiateViewControllerWithIdentifier:NSStringFromClass(ViewController.class)];
       
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = vc;
}

@end
