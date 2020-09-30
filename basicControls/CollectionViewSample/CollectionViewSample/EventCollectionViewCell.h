//
//  EventCollectionViewCell.h
//  CollectionViewSample
//
//  Created by deng on 2020/6/2.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EventCollectionViewCell : UICollectionViewCell

// 单元格里的图片
@property (strong, nonatomic) UIImageView *imageView;

// 单元格里的标签
@property (strong, nonatomic) UILabel *label;

@end

NS_ASSUME_NONNULL_END
