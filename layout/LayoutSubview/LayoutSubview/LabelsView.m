//
//  LabelsView.m
//  LayoutSubview
//
//  Created by deng on 2020/7/2.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "LabelsView.h"

@implementation LabelsView


- (void)drawRect:(CGRect)rect {
    NSLog(@"绘制正方形");
    CGRect frame = self.frame;
    frame.size.height = 40;
    self.frame = frame;
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self addSubview:btn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"调用了 UIView 的 layoutSubviews");
}

@end
