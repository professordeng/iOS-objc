//
//  NSArray+Functional.m
//  InterceptableNavigation
//
//  Created by leon on 03/07/2020.
//  Copyright © 2020 Maimemo Inc. All rights reserved.
//

#import "NSArray+Functional.h"

@implementation NSArray (Functional)


- (NSArray *)map:(id (^)(id object))block {
    if (!block || self.count == 0) return self;
    NSMutableArray *array = NSMutableArray.array;
    for (id obj in self) {
        @autoreleasepool {
            id value = block(obj);
            if (value) [array addObject:value];
        }
    }
    return array.copy;
}


- (NSArray *)filter:(BOOL (^)(id object))block {
    if (!block || self.count == 0) return self;
    NSMutableArray *array = NSMutableArray.array;
    for (id obj in self) {
        @autoreleasepool {
            if (block(obj) == YES) {
                [array addObject:obj];
            }
        }
    }
    return array.copy;
}


@end
