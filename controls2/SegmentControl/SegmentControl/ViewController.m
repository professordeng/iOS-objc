//
//  ViewController.m
//  SegmentControl
//
//  Created by deng on 2020/7/13.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 背景色
    [self.segmentControl setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:54.0/255 green:181.0/255 blue:157.0/255 alpha:1.0]] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    
    [self.segmentControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
        
    // #e5d5d5
    [self.segmentControl setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1.0]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];

    [self.segmentControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
        
    // 去掉中间的分割线
    [self.segmentControl setDividerImage:[self imageWithColor:[UIColor colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1.0]] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

//  颜色转换为背景图片
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
