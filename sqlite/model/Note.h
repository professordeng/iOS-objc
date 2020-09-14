//
//  Note.h
//  sqlite
//
//  Created by deng on 2020/6/13.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Note : NSObject

@property (strong, nonatomic) NSDate* date;
@property (strong, nonatomic) NSString* content;

- (instancetype)initWithDate:(NSDate *)date content:(NSString *)content;
- (instancetype)init;

@end

NS_ASSUME_NONNULL_END
