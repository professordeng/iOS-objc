//
//  Cell.m
//  LayoutSubview
//
//  Created by deng on 2020/7/2.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "Cell.h"

@implementation Cell



- (void)awakeFromNib {
    [super awakeFromNib];
    
//    self.labelsViewHeight.constant = 40;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.labelsViewHeight.constant = 40;
    NSLog(@"调用了单元格的 layoutSubviews");
}

@end
