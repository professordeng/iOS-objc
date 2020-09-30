//
//  ViewController.m
//  Delegate
//
//  Created by deng on 2020/6/24.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"

@interface ViewController () <NextViewControllerDelegate>

// 标签输入
@property (weak, nonatomic) IBOutlet UITextField *labelsInput;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"next"]) {
        NextViewController *destViewController = segue.destinationViewController;
        destViewController.delegate = self;
    }
}

// 代理
- (void)reloadView:(NSDictionary *)note {
    self.labelsInput.text = note[@"labels"];
}

@end
