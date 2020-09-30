//
//  PasswordTextField.m
//  PasswordTextField
//
//  Created by deng on 2020/6/28.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "PasswordTextField.h"

@interface PasswordTextField ()

@property (strong, nonatomic) CALayer *bottomBorder;
@property (strong, nonatomic) UIButton *rightButton;

@end

@implementation PasswordTextField


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    // 密码模式
    self.secureTextEntry = YES;
    
    [self addRightView];
    
    [self addBottomBorder];
    
}

- (void)addRightView {
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightButton setImage:[UIImage imageNamed:@"ceye.png"] forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(displayPassword)
            forControlEvents:UIControlEventTouchUpInside];
    
    // 按钮图片的内边距
    self.rightButton.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    
    // Assign the overlay button to a stored text field
    self.rightView = self.rightButton;
    self.rightViewMode = UITextFieldViewModeAlways;
}

- (void)addBottomBorder {
    self.bottomBorder = [CALayer layer];
    self.bottomBorder.frame = CGRectMake(0.0f, self.frame.size.height, self.frame.size.width, 1.0f);
    self.bottomBorder.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1.0].CGColor;
    [self.layer addSublayer:self.bottomBorder];
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds {
    bounds.origin.x = bounds.size.width - 44;
    bounds.size.width = 44;
    bounds.size.height = 44;
    return bounds;
}

- (void)displayPassword {
    NSLog(@"你好");
}

- (void)changeBottomBorder {
    self.bottomBorder.frame = CGRectMake(0.0f, self.frame.size.height, self.frame.size.width, 1.0f);
}

@end
