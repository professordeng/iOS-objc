//
//  Note.m
//  CoreData
//
//  Created by deng on 2020/6/13.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "Note.h"

@implementation Note

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
    self = [super init];
    
    if (self) {
        self.date = [[NSDate alloc] init];
        self.content = @"";
    }
    
    return self;
}

@end
