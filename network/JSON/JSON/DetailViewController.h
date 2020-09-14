//
//  DetailViewController.h
//  JSON
//
//  Created by deng on 2020/6/16.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController

@property(strong, nonatomic) id detailItem;

// 显示详细信息
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

NS_ASSUME_NONNULL_END
