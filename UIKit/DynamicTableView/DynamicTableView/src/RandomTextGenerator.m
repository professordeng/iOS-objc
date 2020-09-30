//
//  RandomTextGenerator.m
//  DynamicTableView
//
//  Created by leon on 08/07/2020.
//  Copyright © 2020 Maimemo Inc. All rights reserved.
//

#import "RandomTextGenerator.h"

@implementation RandomTextGenerator


+ (NSString *)text:(NSInteger)length {
    // generate random string
    NSString *cs = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    if (length < 0) length = (NSInteger)arc4random_uniform(1000) + 50;
    NSMutableString *string = NSMutableString.string;
    for (uint32_t i = 0; i < length; i++) {
        const char c = [cs characterAtIndex:(NSUInteger)arc4random_uniform((uint32_t)cs.length)];
        [string appendFormat:@"%c", c];
    }
    return string.copy;
}


@end
