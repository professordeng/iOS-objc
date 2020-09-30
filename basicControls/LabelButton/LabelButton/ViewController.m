//
//  ViewController.m
//  LabelButton
//
//  Created by deng on 2020/6/9.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// IBOutlet 用于定义输出口属性
// weak 表示本视图不拥有 label，label 属于故事板
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (weak, nonatomic) IBOutlet UIButton *button;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.button setBackgroundImage:[self imageWithColor:[UIColor.blueColor colorWithAlphaComponent:0.1]] forState:UIControlStateNormal];
}

// IBAction 表示动作方法，sender 是拖拽时设置的参数，表示事件源
// 拖拽时可以选择参数，none 表示不需要参数，sender and events 表示两个参数（事件源和事件对象）
- (IBAction)onClick:(id)sender {
    self.label.text = @"HelloWorld";
}

- (IBAction)changeButtonState:(id)sender {
    
}


- (UIImage *)imageWithColor:(UIColor *)color {
    // 宽高 1.0 只要有值就够了
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    // 在这个范围内开启一段上下文
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 在这段上下文中获取到颜色 UIColor
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 用这个颜色填充这个上下文
    CGContextFillRect(context, rect);
    // 从这段上下文中获取Image属性
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文绘制
    UIGraphicsEndImageContext();

    return image;
}

@end
