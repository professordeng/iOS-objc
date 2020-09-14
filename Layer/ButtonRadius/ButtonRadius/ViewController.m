//
//  ViewController.m
//  ButtonRadius
//
//  Created by deng on 2020/7/8.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置 button1 的边角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.button1.bounds
                                                   byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft
                                                         cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.button1.bounds;
    maskLayer.path = maskPath.CGPath;
    self.button1.layer.mask = maskLayer;
    
    // 设置 button2 的边角
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.button2.bounds
                                     byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight
                                           cornerRadii:CGSizeMake(8, 8)];
    maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.button2.bounds;
    maskLayer.path = maskPath.CGPath;
    self.button2.layer.mask = maskLayer;
}

- (IBAction)clickButton1:(id)sender {
    [self.button1 setBackgroundColor:[UIColor purpleColor]];
    [self.button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.button2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

- (IBAction)clickButton2:(id)sender {
    [self.button2 setBackgroundColor:[UIColor purpleColor]];
    [self.button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       
    [self.button1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}


@end
