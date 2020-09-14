//
//  TabBarController.m
//  anki
//
//  Created by deng on 2020/7/16.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "TabBarController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 去除边框黑线
//    [self.tabBar setShadowImage:[TabBarController imageWithColor:[UIColor whiteColor]]];
//    [self.tabBar setBackgroundImage:[TabBarController imageWithColor:[UIColor whiteColor]]];
    
    // 修复右上角黑边
    self.view.backgroundColor = [UIColor whiteColor];
}

+ (UIImage *)imageWithColor:(UIColor *)color {
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
