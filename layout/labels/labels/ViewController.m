//
//  ViewController.m
//  labels
//
//  Created by deng on 2020/6/24.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray *labels;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 存储标签字符串
    self.labels = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 30; i ++) {
        int x = rand() % 3;
        switch (x) {
            case 0:
                [self.labels addObject:@"萨瓦迪卡"];
                break;
                
            case 1:
                [self.labels addObject:@"萨瓦迪卡萨瓦迪卡萨瓦迪卡萨瓦迪卡萨瓦迪卡萨瓦迪卡萨瓦迪卡萨瓦迪卡萨瓦迪卡萨瓦迪卡萨瓦迪卡萨瓦迪卡"];
                break;
            case 2:
                [self.labels addObject:@"你好"];
            default:
                break;
        }
    }
}

// 当屏幕旋转时做相应的布局调整
- (void)viewWillLayoutSubviews {
    // 首先得清除重用单元格的所有标签
    for (UIView *labelView in [self.view subviews]) {
        if ([labelView isKindOfClass:[UIButton class]]) {
            [labelView removeFromSuperview];
        }
    }
    
    // 开始渲染
    float yOffset = 40;
    float xOffset = 20;
    
    CGRect frame = self.view.frame;
    CGFloat width = frame.size.width;
    
    UIButton *label = nil;
    
    for (int i = 0; i < [self.labels count]; i ++) {
        label = [[UIButton alloc] init];
        [label setTitle:self.labels[i] forState:UIControlStateNormal];
        [label setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        label.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        
        CGSize labelSize = [self.labels[i] sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:label.titleLabel.font.fontName size:label.titleLabel.font.pointSize]}];
        
        labelSize.width += 12;
        labelSize.height = 29;
        
        // 判断位置是否足够，若不足够则转行
        if (xOffset + labelSize.width + 20 > width) {
            xOffset = 20;
            yOffset += 37;
        }
        
        // 标签长度不超过屏幕宽度
        if (labelSize.width + 40 > width) {
            labelSize.width = width - 40;
        }
        
        label.frame = CGRectMake(xOffset, yOffset, labelSize.width, labelSize.height);
        [label.layer setCornerRadius:3];
        label.enabled = NO;
        label.backgroundColor = [UIColor grayColor];
        [self.view addSubview:label];
        
        // 调整下一个标签的偏移位置
        xOffset += labelSize.width + 10;
    }
}

@end
