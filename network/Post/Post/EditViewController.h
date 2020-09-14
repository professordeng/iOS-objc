//
//  EditViewController.h
//  Post
//
//  Created by deng on 2020/6/17.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EditViewController : UIViewController

// 用户标识码（登录后才有）
@property (strong, nonatomic) NSString *jwt;

// 接收点击单元格进来的笔记
@property (strong, nonatomic) NSMutableDictionary *note;

@end

NS_ASSUME_NONNULL_END
