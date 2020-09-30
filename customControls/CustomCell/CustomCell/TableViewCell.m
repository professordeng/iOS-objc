//
//  TableViewCell.m
//  CustomCell
//
//  Created by deng on 2020/6/23.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCell ()

// 标签高度，这里默认为 29，写这个变量是为了防止需求升级
@property (assign, nonatomic) float labelHeight;
@property (assign, nonatomic) float labelViewHeight;

@property (strong, nonatomic) NSMutableArray *labelsArray;

// 计算所有标签的宽度，之后布局用
@property (strong, nonatomic) NSMutableArray *labelsOffsetArray;

@end

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // 初始化标签高度
    self.labelHeight = 29;
    self.labelViewHeight = 45;
}

- (void)setView {
    // 首先得清除重用单元格的所有标签
    for (UIView *labelView in [self.contentView subviews]) {
        if ([labelView isKindOfClass:[UIButton class]]) {
            [labelView removeFromSuperview];
        }
    }
    // 重置偏移数组
    self.labelsOffsetArray = [[NSMutableArray alloc] init];
    
    [self setStatus];
    [self setStatus1];
    
    [self handleLabels];
    
    for (int i = 0; i < [self.labelsArray count]; i ++) {
        [self computeLabelWidth:i];
    }
    
    [self setTopContentLabel];
}

// 将标签字符串转为标签数组
- (void)handleLabels {
    // 按 “/” 分割标签
    self.labelsArray = (NSMutableArray *)[self.labels componentsSeparatedByString:@"/"];
    
    // 删除无用标签
    [self.labelsArray removeObject:@""];
}

- (void)setStatus {
    CGRect frame = self.frame;
    CGFloat width = frame.size.width;
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"私" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    CGSize labelSize = [@"私" sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:btn.titleLabel.font.fontName size:btn.titleLabel.font.pointSize]}];
    
    labelSize.width += 12;
    
    [btn.layer setCornerRadius:3];
    btn.frame = CGRectMake(width - 20 - labelSize.width, 8, labelSize.width, self.labelHeight);
    
    // 背景为绿色
    btn.backgroundColor = [UIColor colorWithRed:54.0/255 green:181.0/255 blue:157.0/255 alpha:1.0];
    btn.enabled = NO;
    [self.contentView addSubview:btn];
}

- (void)setStatus1 {
    CGRect frame = self.frame;
    CGFloat width = frame.size.width;
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"我" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    CGSize labelSize = [@"我" sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:btn.titleLabel.font.fontName size:btn.titleLabel.font.pointSize]}];
    
    labelSize.width += 12;
    
    [btn.layer setCornerRadius:3];
    btn.frame = CGRectMake(width - 20 - labelSize.width - 40, 8, labelSize.width, self.labelHeight);
    
    // 背景为绿色
    btn.backgroundColor = [UIColor colorWithRed:54.0/255 green:181.0/255 blue:157.0/255 alpha:1.0];
    btn.enabled = NO;
    [self.contentView addSubview:btn];
}

// 计算标签数组
- (void)computeLabelWidth:(NSUInteger)index {
    float offset = 0;
    if (index > 0) {
        offset = [self.labelsOffsetArray[index - 1] floatValue];
    }
    
    UIButton *label = [[UIButton alloc] init];
    [label setTitle:self.labelsArray[index] forState:UIControlStateNormal];
    [label setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    CGSize labelSize = [self.labelsArray[index] sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:label.titleLabel.font.fontName size:label.titleLabel.font.pointSize]}];
    
    labelSize.width += 12;
    
    label.frame = CGRectMake(20 + offset, 8, labelSize.width, self.labelHeight);
    [label.layer setCornerRadius:3];
    label.enabled = NO;
    label.backgroundColor = [UIColor colorWithRed:221.0/255 green:221.0/255 blue:221.0/255 alpha:1.0];
    [self.contentView addSubview:label];

    // 记录下一个标签的偏移值
    offset += labelSize.width + 8;
    [self.labelsOffsetArray insertObject:[NSNumber numberWithFloat:offset] atIndex:index];
}

// 在设置完后修改相应约束（单元格高度）
- (void)setTopContentLabel {
    // 自动布局，腾出空间放标签，必须等标签渲染完才设置下面语句

    NSArray *constrains = self.contentView.constraints;
    for (NSLayoutConstraint *constraint in constrains) {
        if (constraint.firstAttribute == NSLayoutAttributeTop) {
            constraint.constant = 90;
            break;
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
