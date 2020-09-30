//
//  NextViewController.h
//  Delegate
//
//  Created by deng on 2020/6/24.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 自定义协议
@protocol NextViewControllerDelegate <NSObject>

- (void)reloadView:(NSDictionary *)note;

@end

// 外部接口
@interface NextViewController : UIViewController

@property (weak, nonatomic) id<NextViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
