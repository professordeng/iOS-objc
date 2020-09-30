//
//  SearchTextField.m
//  CustomSearchBar
//
//  Created by deng on 2020/7/14.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "SearchTextField.h"

@interface SearchTextField ()

@property (strong, nonatomic) UIButton *leftButton;

@end

@implementation SearchTextField

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self addLeftView];
    }
    return self;
}

- (void)addLeftView {
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftButton setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    self.leftButton.imageEdgeInsets = UIEdgeInsetsMake(11, 11, 11, 11);
    
    self.leftView = self.leftButton;
    self.leftViewMode = UITextFieldViewModeAlways;
}

// 搜索图标的位置
- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    bounds.origin.x = 0;
    bounds.size.width = 36;
    bounds.size.height = 36;
    return bounds;
}

@end
