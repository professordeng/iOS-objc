//
//  SecondViewController.m
//  InterceptableNavigation
//
//  Created by leon on 03/07/2020.
//  Copyright © 2020 Maimemo Inc. All rights reserved.
//

#import "SecondViewController.h"
#import "InterceptableNavigationController.h"
#import "NSArray+Functional.h"


@interface SecondViewController () <UINavigationBarDelegate>

@end


@implementation SecondViewController


- (void)dealloc {
    NSLog(@"__%@__dealloc__", self.class);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"第二页";
    
    // intercept navigation pop event
    [(InterceptableNavigationController *)self.navigationController setOnPop:
     ^(InterceptableNavigationController *navigationController, UINavigationItem *item) {
        [SecondViewController asyncTaskWithCompletionHandler:^{
            [navigationController popViewControllerAnimated:YES];
        }];
    }];
}


// e.g. submit data to server
+ (void)asyncTaskWithCompletionHandler:(void(^)(void))completion {
    dispatch_async(dispatch_get_main_queue(), ^{

        // pretend I have loading HUD, for demonstration purpose only
        // ** fun functional programming **
        UIWindow *keyWindow = [UIApplication.sharedApplication.windows filter:^BOOL(__kindof UIWindow *object) {
            return object.isKeyWindow;
        }].firstObject;

        UILabel *label        = [UILabel new];
        label.text            = @"请稍等...";
        label.font            = [UIFont systemFontOfSize:16];
        label.textColor       = UIColor.whiteColor;
        label.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.35];
        label.textAlignment   = NSTextAlignmentCenter;
        label.frame           = keyWindow.bounds;
        [keyWindow addSubview:label];
        NSLog(@"loading ...");

        // do something, say, for 3 seconds, then callback
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [label removeFromSuperview];
            if (completion) completion();
        });
    });
}


// try functional programming if you want
+ (void)functionalExample {
    // map even numbers to string
    NSLog(@"%@", [[@[@1, @2, @3, @4, @5] filter:^BOOL(NSNumber *object) {
        return object.integerValue % 2 == 0;
    }] map:^id(NSNumber *object) {
        return object.stringValue;
    }]);

    // equivalent to
    NSMutableArray *ret = NSMutableArray.array;
    for (NSNumber *number in @[@1, @2, @3, @4, @5]) {
        if (number.integerValue % 2 == 0) {
            [ret addObject:number.stringValue];
        }
    }
    NSLog(@"%@", ret);
}


@end
