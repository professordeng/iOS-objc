//
//  ViewController.m
//  AlertViewActionSheet
//
//  Created by deng on 2020/6/1.
//  Copyright © 2020 professordeng. All rights reserved.
//

// iOS 中的警告框是 “模态” 的
// “模态” 表示不关闭它就不能做别的事情

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//--------------------------------------------警告框按钮
    // 获取屏幕大小
    CGRect screen = [[UIScreen mainScreen] bounds];
    
    // 创建并设置 “test 警告框” 按钮控件
    UIButton* buttonAlertView = [UIButton buttonWithType:UIButtonTypeSystem];
    
    // 设置按钮标题
    [buttonAlertView setTitle: @"Test 警告框" forState:UIControlStateNormal];
    
    CGFloat buttonAlertViewWidth = 100;
    CGFloat buttonAlertViewHeight = 30;
    CGFloat buttonAlertViewTopView = 130;
    
    // 设置按钮布局
    buttonAlertView.frame = CGRectMake((screen.size.width - buttonAlertViewWidth)/2, buttonAlertViewTopView, buttonAlertViewWidth, buttonAlertViewHeight);
    
    // 给 “test” 按钮设置响应事件
    [buttonAlertView addTarget:self action:@selector(testAlertView:) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加按钮到当前视图
    [self.view addSubview:buttonAlertView];
    
//-----------------------------------------------操作表按钮
    
    // Test 操作表按钮设置
    UIButton *buttonActionSheet = [UIButton buttonWithType:UIButtonTypeSystem];
    
    // 按钮标题
    [buttonActionSheet setTitle:@"Test 操作表" forState:UIControlStateNormal];
    
    CGFloat buttonActionSheetWidth = 130;
    CGFloat buttonActionSheetHeight = 30;
    CGFloat buttonActionSheetTopView = 260;
    
    // 按钮布局
    buttonActionSheet.frame = CGRectMake((screen.size.width - buttonActionSheetWidth)/2, buttonActionSheetTopView, buttonActionSheetWidth, buttonActionSheetHeight);
    
    // 指定事件处理方法
    [buttonActionSheet addTarget:self action:@selector(testActionSheet:) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加按钮
    [self.view addSubview:buttonActionSheet];
}

- (void)testAlertView:(id)sender
{
    // 创建并初始化 UIAlertController 对象
    // preferredStyle 表示警告框
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Alert text goes here" preferredStyle:UIAlertControllerStyleAlert];
    
    // 每个 UIAlertAction 对象对应一个按钮动作
    // style 是按钮样式
    // handler 是响应方法
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"Top No Button");
    }];
    
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"Tap Yes Button");
    }];
    
    // 将两个 UIAlertAction 对象添加到 UIAlertController 对象中
    [alertController addAction:noAction];
    [alertController addAction:yesAction];
    
    // “模态” 方式显示
    [self presentViewController:alertController animated:TRUE completion:nil];
}

- (void)testActionSheet:(id)sender
{
    // 默认样式是操作表，不需要设置 preferedStyle
    UIAlertController *actionSheetController = [[UIAlertController alloc] init];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"Tap 取消 Button");
    }];
    
    UIAlertAction* destructiveAction = [UIAlertAction actionWithTitle:@"破坏性按钮" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        NSLog(@"破坏性按钮");
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"新浪微博" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"Tap 新浪微博 Button");
    }];
    
    // 添加顺序很重要，先添加的按钮在操作表下方
    [actionSheetController addAction:cancelAction];
    [actionSheetController addAction:destructiveAction];
    [actionSheetController addAction:otherAction];
    
    // 在i iPad 设备下运行操作表时会以浮动层视图方式显示
    // iPad 设备浮动层设置锚点，这里的 sender 是响应该方法的按钮
    // 除了 sourceView，还有 barButtonItem 和 sourceRect（P81）
    actionSheetController.popoverPresentationController.sourceView = sender;
    
    // “模态” 方式显示
    [self presentViewController:actionSheetController animated:TRUE completion:nil];
}

@end
