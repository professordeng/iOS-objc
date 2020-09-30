//
//  EventCollectionViewCell.m
//  CollectionViewSample
//
//  Created by deng on 2020/6/2.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "EventCollectionViewCell.h"

@implementation EventCollectionViewCell

// 重写构造函数，该构造函数实例化单元格包含的各个子视图属性对象
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        // 单元格的宽度
        CGFloat cellWidth = self.frame.size.width;
        
        // 1. 添加 ImageView
        // CGRect 数据结构的高度和宽度可以是负数。例如，一个矩形的原点是 [0.0，0.0] 和大小是 [10.0,10.0]。这个矩形完全等同原点是 [10.0，10.0] 和大小是 [-10.0，-10.0] 的矩形。
        self.imageView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, cellWidth, cellWidth)];
        
        // 将 imageView 添加到单元格中
        [self addSubview:self.imageView];
        
        // 2. 添加标签，标签已经超出了 cell 的高度，所以是不合理的
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, cellWidth + 5, cellWidth, 16)];
        
        // 字体左右居中
        self.label.textAlignment = NSTextAlignmentCenter;
        // 设置字体
        self.label.font = [UIFont systemFontOfSize:13];
        // 将 label 添加到单元格中
        [self addSubview:self.label];
    }
    return self;
}

@end
