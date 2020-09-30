//
//  InterceptableNavigationController.m
//  InterceptableNavigation
//
//  Created by leon on 03/07/2020.
//  Copyright © 2020 Maimemo Inc. All rights reserved.
//

#import "InterceptableNavigationController.h"


@interface InterceptableNavigationController () <UINavigationBarDelegate, UIGestureRecognizerDelegate>

@property (nonatomic) BOOL intercepted;

@end


@implementation InterceptableNavigationController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
}


- (void)dealloc {
    self.interactivePopGestureRecognizer.delegate = nil;
}


#pragma mark - delegate methods


// detect swip back gesture
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        if (self.intercepted) {
            return NO;
        } if (self.onPop) {
            [self showAlert:nil];
            return NO;
        }
    }
    return YES;
}


// detect back button tap
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    if (self.onPop) {
        [self showAlert:nil];
        return NO;
    }
    return YES;
}


- (void)showAlert:(UINavigationItem *)item {
    self.intercepted = YES;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定返回"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"返回"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction *action) {
        if (self.onPop) {
            self.onPop(self, item);
        }
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction *action) {
    }];

    [alert addAction:confirm];
    [alert addAction:cancel];
    alert.view.tintColor = [UIColor.blueColor colorWithAlphaComponent:0.5];
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)navigationBar:(UINavigationBar *)navigationBar didPopItem:(UINavigationItem *)item {
    self.intercepted = NO;
    // reset onPop block
    self.onPop = nil;
}


/* more options
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPushItem:(UINavigationItem *)item {
    if (self.shouldPush) {
        return self.shouldPush(self, item);
    }
    return YES;
}


- (void)navigationBar:(UINavigationBar *)navigationBar didPushItem:(UINavigationItem *)item {
    if (self.didPush) {
        self.didPush(self, item);
        self.didPush = nil;
    }
}
 */


@end

