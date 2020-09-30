//
//  ViewController.m
//  AlertController
//
//  Created by deng on 2020/7/13.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"
#import "AlertController.h"

@interface ViewController ()

@property (strong, nonatomic) AlertController *alertController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.alertController = [AlertController alertControllerWithTitle:@"" message:@"确定要退出吗" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [self.alertController addAction:cancel];
}

- (IBAction)quit:(id)sender {
    [self presentViewController:self.alertController animated:YES completion:nil];
}

@end
