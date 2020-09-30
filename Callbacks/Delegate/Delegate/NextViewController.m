//
//  NextViewController.m
//  Delegate
//
//  Created by deng on 2020/6/24.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "NextViewController.h"

@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)backToPre:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        NSDictionary *note = @{
               @"labels"  : @"a/b/c",
               @"content" : @"你好"
        };
        if (self.delegate && [self.delegate respondsToSelector:@selector(reloadView:)]) {
            [self.delegate reloadView:note];
        }
    }];
}

@end
