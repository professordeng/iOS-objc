//
//  DynamicCell2.m
//  DynamicTableView
//
//  Created by leon on 12/07/2020.
//  Copyright © 2020 Maimemo Inc. All rights reserved.
//

#import "DynamicCell2.h"
#import "TagView.h"


@interface DynamicCell2 ()

@property (nonatomic, weak) UITextView *textView;
@property (nonatomic, weak) TagView *tagView;
@property (nonatomic, weak) UIView *accessory;

@end


@implementation DynamicCell2



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *view = UIView.new;
        view.backgroundColor = [UIColor.blueColor colorWithAlphaComponent:0.2];
        self.selectedBackgroundView = view;

        TagView *tagView = TagView.new;
        [self.contentView addSubview:tagView];
        self.tagView = tagView;
        self.tagView.backgroundColor = UIColor.clearColor;

        UIView *accessory = UIView.new;
        [self.contentView addSubview:accessory];
        self.accessory = accessory;
        self.accessory.layer.borderWidth = 0.5;

        UILabel *label = UILabel.new;
        label.backgroundColor = UIColor.clearColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"Manual layout";
        label.font = [UIFont systemFontOfSize:12];
        [self.accessory addSubview:label];

        UITextView *textView = UITextView.new;
        [self.contentView addSubview:textView];
        self.textView = textView;
        self.textView.textContainer.lineFragmentPadding = 0;
        self.textView.textContainerInset = UIEdgeInsetsZero;
        self.textView.scrollEnabled = NO;
        self.textView.editable = NO;
        self.textView.userInteractionEnabled = NO;
        self.textView.backgroundColor = UIColor.clearColor;

        self.contentView.backgroundColor = [UIColor.redColor colorWithAlphaComponent:0.2];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat margin = 10;
    CGFloat spacing = 8;
    // be careful of safeAreaInsets
    CGFloat width = self.frame.size.width - self.safeAreaInsets.left - self.safeAreaInsets.right;
    CGFloat accessoryWidth = 90;
    self.accessory.frame = CGRectMake(width - margin - accessoryWidth, margin, accessoryWidth, 20);
    for (UIView *view in self.accessory.subviews) {
        view.frame = self.accessory.bounds;
    }

    self.tagView.bounds = CGRectMake(0, 0, width - accessoryWidth - margin - spacing, 0);
    CGSize size = self.tagView.intrinsicContentSize;
    self.tagView.frame = CGRectMake(margin, margin, size.width, size.height);

    size = [self.textView sizeThatFits:CGSizeMake(width - 2 * margin, CGFLOAT_MAX)];
    self.textView.frame = CGRectMake(margin,
                                     CGRectGetMaxY(self.tagView.frame) + spacing,
                                     width - 2 * margin, size.height);

    self.contentView.bounds = CGRectMake(0, 0, width, CGRectGetMaxY(self.textView.frame) + margin);
}


- (void)setTags:(NSArray<NSString *> *)tags {
    self.tagView.texts = tags;
}


- (void)setContent:(NSString *)content {
    self.textView.text = content;
}


@end
