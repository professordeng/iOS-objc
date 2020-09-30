//
//  ViewController.m
//  frame
//
//  Created by deng on 2020/6/24.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) UIButton *loginButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.loginButton = [[UIButton alloc] init];
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginButton setBackgroundColor:[UIColor darkGrayColor]];
    [self.view addSubview:self.loginButton];
}

- (void)viewWillLayoutSubviews {
    // 重写
    [super viewWillLayoutSubviews];
    CGRect frame = self.view.frame;
    NSLog(@"frame height : %f", frame.size.width);
    NSLog(@"frame width : %f", frame.size.height);
    
    CGFloat width = frame.size.width - 80;
    CGFloat height = 44;
    self.loginButton.frame = CGRectMake(40, (frame.size.height - height) / 2, width, height);
}

@end
