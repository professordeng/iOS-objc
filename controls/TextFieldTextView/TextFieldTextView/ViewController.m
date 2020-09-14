//
//  ViewController.m
//  TextFieldTextView
//
//  Created by deng on 2020/6/9.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
    <UITextFieldDelegate, UITextViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

#pragma mark - 实现 UITextFieldDelegate 委托协议方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // 放弃 “第一响应者”，也就是隐藏键盘
    [textField resignFirstResponder];
    NSLog(@"TextField 获得焦点，点击 return 键");
    return YES;
}

#pragma mark - 实现 UITextViewDelegate 委托协议方法
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        // 放弃 “第一响应者”，也就是隐藏键盘
        [textView resignFirstResponder];
        NSLog(@"TextView 获得焦点，点击 return 键");
        return NO;
    }
    return YES;
}

#pragma mark - 在视图的不同生命周期做一些事

// 视图出现前做的一些事件绑定
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 注册键盘出现通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    // 注册键盘隐藏通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboradDidHide:) name:UIKeyboardDidHideNotification object:nil];
}

// 视图消失前做的一些事件处理
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 注销键盘出现通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    
    // 注销键盘隐藏通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

// 键盘显示时会调用该方法
- (void)keyboardDidShow:(NSNotification *)notification
{
    NSLog(@"键盘打开");
}

// 键盘消失时会调用该方法
- (void)keyboradDidHide:(NSNotification *)notification
{
    NSLog(@"键盘关闭");
}

@end
