//
//  Note.m
//  sqlite
//
//  Created by deng on 2020/6/13.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "Note.h"

@implementation Note

// 指定初始方法
- (instancetype)initWithDate:(NSDate *)date content:(NSString *)content
{
    self = [super init];
    
    if (self) {
        self.date = date;
        self.content = content;
    }
    return self;
}

- (instancetype)init
{
    return [self initWithDate:[[NSDate alloc] init] content:@""];
}

@end
