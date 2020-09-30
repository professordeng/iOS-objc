//
//  TableViewCell.h
//  CustomCell
//
//  Created by deng on 2020/6/23.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableViewCell : UITableViewCell

@property (strong, nonatomic) NSString *labels;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

- (void)setView;

@end

NS_ASSUME_NONNULL_END
