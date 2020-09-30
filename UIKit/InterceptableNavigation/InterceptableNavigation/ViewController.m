//
//  ViewController.m
//  InterceptableNavigation
//
//  Created by leon on 03/07/2020.
//  Copyright © 2020 Maimemo Inc. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"


@interface ViewController ()

@end


@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"第一页";

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一页"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(push:)];;
    self.navigationItem.backBarButtonItem =
        [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

    self.navigationItem.rightBarButtonItem.tintColor = [UIColor.blueColor colorWithAlphaComponent:0.5];
    self.navigationItem.backBarButtonItem.tintColor = [UIColor.blueColor colorWithAlphaComponent:0.5];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


- (void)push:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SecondViewController *vc = [sb instantiateViewControllerWithIdentifier:NSStringFromClass(SecondViewController.class)];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
