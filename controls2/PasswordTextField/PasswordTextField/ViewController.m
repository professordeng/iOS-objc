//
//  ViewController.m
//  PasswordTextField
//
//  Created by deng on 2020/6/28.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet PasswordTextField *passwordInput;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)viewDidLayoutSubviews {
    // 设置 textField 底部线
    [self.passwordInput changeBottomBorder];
}

@end
