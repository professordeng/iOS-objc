//
//  ViewController.m
//  NavigationBarSample
//
//  Created by deng on 2020/6/10.
//  Copyright © 2020 professordeng. All rights reserved.
//

// IOS 视图是可视区域，自然包括状态栏，状态栏的高度是 20

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *leftButton;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    leftView.image = [UIImage imageNamed:@"arrow_down.png"];
    self.leftButton.customView = leftView;
}

- (IBAction)save:(id)sender {
    self.label.text = @"点击 Save";
}

- (IBAction)add:(id)sender {
    self.label.text = @"点击 Add";
}


@end
