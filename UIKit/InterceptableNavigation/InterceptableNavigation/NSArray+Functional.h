//
//  NSArray+Functional.h
//  InterceptableNavigation
//
//  Created by leon on 03/07/2020.
//  Copyright © 2020 Maimemo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSArray<__covariant ObjectType> (Functional)

- (NSArray *)map:(id (^)(ObjectType object))block;

- (NSArray *)filter:(BOOL (^)(ObjectType object))block;

@end

