//
//  Cell.h
//  LayoutSubview
//
//  Created by deng on 2020/7/2.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Cell : UITableViewCell

// 标签视图，存放标签
@property (weak, nonatomic) IBOutlet UIView *labelsView;

// 正文
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelsViewHeight;

@end

NS_ASSUME_NONNULL_END
