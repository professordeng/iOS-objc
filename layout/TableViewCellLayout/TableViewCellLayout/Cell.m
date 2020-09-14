//
//  Cell.m
//  TableViewCellLayout
//
//  Created by deng on 2020/7/3.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "Cell.h"

@implementation Cell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    NSLog(@"调用了 Cell 的 layoutSubviews");
}

@end
