//
//  ViewController.m
//  ToolbarSample
//
//  Created by deng on 2020/6/10.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)save:(id)sender {
    self.label.text = @"点击 Save";
}

- (IBAction)open:(id)sender {
    self.label.text = @"点击 Open";
}


@end
