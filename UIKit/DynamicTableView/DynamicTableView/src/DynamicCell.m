//
//  DynamicCell.m
//  DynamicTableView
//
//  Created by leon on 08/07/2020.
//  Copyright © 2020 Maimemo Inc. All rights reserved.
//

#import "DynamicCell.h"
#import "TagView.h"


@interface DynamicCell ()

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *topViewHeight;
@property (nonatomic, weak  ) IBOutlet TagView *tagView;
@property (nonatomic, weak  ) IBOutlet UITextView *textView;
@property (nonatomic, weak  ) IBOutlet UIView *accessory;

@end


@implementation DynamicCell


- (void)awakeFromNib {
    [super awakeFromNib];
    UIView *view = UIView.new;
    view.backgroundColor = [UIColor.greenColor colorWithAlphaComponent:0.2];
    self.selectedBackgroundView = view;
    self.tagView.backgroundColor = UIColor.clearColor;
    self.textView.backgroundColor = UIColor.clearColor;
    self.textView.textContainer.lineFragmentPadding = 0;
    self.textView.textContainerInset = UIEdgeInsetsZero;

    self.contentView.backgroundColor = [UIColor.cyanColor colorWithAlphaComponent:0.2];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (void)setTags:(NSArray<NSString *> *)tags {
    self.tagView.texts = tags;
}


- (void)setContent:(NSString *)content {
    self.textView.text = content;
}


- (void)prepareForReuse {
    [super prepareForReuse];
    [self.tagView invalidateIntrinsicContentSize];
}


@end
