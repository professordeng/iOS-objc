//
//  LabelView.m
//  DynamicTableView
//
//  Created by leon on 08/07/2020.
//  Copyright © 2020 Maimemo Inc. All rights reserved.
//

#import "TagView.h"


@interface TagView ()

@property (nonatomic, copy) NSArray *buttons;

@end


@implementation TagView


+ (instancetype)viewWithTextArray:(NSArray *)texts {
    id view = [[self alloc] init];
    [view setTexts:texts];
    return view;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        self.layer.masksToBounds = YES;
    }
    return self;
}


- (void)setTexts:(NSArray *)texts {
    _texts = texts;
    NSLog(@"%@", texts);
    [self updateButtons];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self calculateSize:self.frame.size.width layout:YES];
}


- (CGSize)intrinsicContentSize {
    [self setNeedsLayout];
    [self layoutIfNeeded];
    return [self calculateSize:self.frame.size.width layout:NO];
}


- (void)updateButtons {
    for (UILabel *button in self.buttons) {
        [button removeFromSuperview];
    }

    NSInteger diff = self.buttons.count - self.texts.count;
    if (diff != 0) {
        NSMutableArray *buttons = [NSMutableArray arrayWithArray:self.buttons ?: @[]];
        for (NSInteger i = 0; i < labs(diff); i++) {
            if (diff > 0) {
                [buttons removeLastObject];
            } else {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                [buttons addObject:button];
            }
        }
        self.buttons = buttons.copy;
    }

    NSInteger index = 0;
    for (UIButton *button in self.buttons) {
        button.userInteractionEnabled = NO;
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        button.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 4);
        button.layer.cornerRadius = 2;
        button.backgroundColor = UIColor.grayColor;
        [button setTitle:self.texts[index] forState:UIControlStateNormal];
        [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor.grayColor colorWithAlphaComponent:0.7]];
        [self addSubview:button];
        index++;
    }
}


- (CGSize)calculateSize:(CGFloat)width layout:(BOOL)layout {
    const CGFloat rowHeight = 20;
    const CGFloat hSpacing = 4;
    const CGFloat vSpacing = 4;
    NSInteger row = 0;
    CGPoint origin = CGPointZero;
    for (UILabel *button in self.buttons) {
        CGSize size = [button sizeThatFits:CGSizeMake(CGFLOAT_MAX, rowHeight)];
        size.height = round(rowHeight);
        if (size.width >= width - origin.x) {
            if (size.width >= width) {
                size.width = width;
            }
            row += (long)(origin.x > 0);
            origin.x = 0;
            origin.y = round(row * (rowHeight + vSpacing));
        }
        CGRect frame = CGRectMake(origin.x, origin.y, size.width, size.height);
        if (layout) button.frame = frame;
        origin.x = round(CGRectGetMaxX(frame) + hSpacing);
        if (origin.x > width) {
            origin.x = 0;
            row++;
        }
        origin.y = round(row * (rowHeight + vSpacing));
    }
    return CGSizeMake(width, origin.y + rowHeight);
}


@end
