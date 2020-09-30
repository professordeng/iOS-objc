//
//  DynamicCell2.h
//  DynamicTableView
//
//  Created by leon on 12/07/2020.
//  Copyright © 2020 Maimemo Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DynamicCell2 : UITableViewCell

- (void)setTags:(NSArray<NSString *> *)tags;
- (void)setContent:(NSString *)content;

@end

NS_ASSUME_NONNULL_END
