//
//  ViewController.m
//  segue
//
//  Created by deng on 2020/6/15.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"进入登录界面");
}

- (void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"Login"]) {
        NSLog(@"我要跳转了");
        return NO;
    }
    return YES;
}

@end
