//
//  Note.h
//  MyNotes
//
//  Created by deng on 2020/6/9.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Note : NSObject

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *content;

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content;

- (instancetype)init;

@end

NS_ASSUME_NONNULL_END
