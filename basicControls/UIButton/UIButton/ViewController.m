//
//  ViewController.m
//  UIButton
//
//  Created by deng on 2020/5/30.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// 该属性记录生成的标签，这样 self 就可以随时访问
// strong 可以保证申请的对象不会被释放
@property (strong, nonatomic) UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // CGRect 是一种结构体类型，创建该类型需要使用 CGRectMake 方法
    // CGRect 有两个成员，分别是 CGPoint(origin) 和 CGSize(size)，分别表示坐标和大小
    // 获得屏幕的边界，bounds 属性表示该视图中本地坐标系统（相对于自己）中的位置和大小
    CGRect screen = [[UIScreen mainScreen] bounds];
    // CGFloat 其实是 float 的别名
    CGFloat labelWidth = 90;
    CGFloat labelHeight = 20;
    CGFloat labelTopView = 150;
    
    // frame 属性表示该视图中父视图坐标系统（相对于父视图）中的位置和大小
    CGRect frame = CGRectMake((screen.size.width - labelWidth)/2, labelTopView, labelWidth, labelHeight);
    self.label = [[UILabel alloc] initWithFrame:frame];
    
    self.label.text = @"请点击登录";
    // 字体左右居中
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.label];
    
    // 按钮类型为系统默认
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    
    // 设置按钮标题，状态是默认状态
    [button setTitle:@"登录" forState:UIControlStateNormal];
    
    CGFloat buttonWidth = 60;
    CGFloat buttonHeight = 20;
    CGFloat buttonTopView = 240;
    
    button.frame = CGRectMake((screen.size.width - buttonWidth)/2, buttonTopView, buttonWidth, buttonHeight);
    [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
}

// 该方法仅供内部使用，因此不需要在头文件里面声明
- (void)onClick:(id)sender
{
    // 点击按钮后，将标签的文字改为 “登录成功”
    self.label.text = @"登录成功";
}

@end
