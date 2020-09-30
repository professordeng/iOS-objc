//
//  NextViewController.m
//  Notification
//
//  Created by deng on 2020/6/24.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "NextViewController.h"

@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)quit:(id)sender {
    [self dismissViewControllerAnimated:TRUE completion:^{
        // 发送 changeLabel 通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeLabel" object:@"那女孩对我说"];
        NSLog(@"点击按钮退出，关闭模态视图");
    }];
}


@end
