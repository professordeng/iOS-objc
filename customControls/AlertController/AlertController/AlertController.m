//
//  AlertController.m
//  AlertController
//
//  Created by deng on 2020/7/13.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "AlertController.h"

@interface AlertController ()

@property (strong, nonatomic) UITapGestureRecognizer *closeGesture;

@end

@implementation AlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.closeGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeAlert:)];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // 如果没有关闭手势，则添加点击关闭手势
    UIView *superView = self.view.superview;
    if (![superView.gestureRecognizers containsObject:self.closeGesture]) {
        [superView addGestureRecognizer:self.closeGesture];
        superView.userInteractionEnabled = YES;
    }
}

- (void)closeAlert:(UITapGestureRecognizer *)gesture {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
