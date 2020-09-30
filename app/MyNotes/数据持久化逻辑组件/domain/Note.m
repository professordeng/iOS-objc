//
//  Note.m
//  MyNotes
//
//  Created by deng on 2020/6/9.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "Note.h"

@implementation Note

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content
{
    self = [super init];
    if (self) {
        self.title = [[NSString alloc] initWithString:title];
        self.content = [[NSString alloc] initWithString:content];
    }
    
    return self;
}

- (instancetype)init
{
    return [self initWithTitle:@"新标题" content:@"新内容"];
}

@end
