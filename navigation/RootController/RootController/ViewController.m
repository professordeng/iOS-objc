//
//  ViewController.m
//  RootController
//
//  Created by deng on 2020/7/10.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)clickLoginButton:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TableViewController *vc = [sb instantiateViewControllerWithIdentifier:NSStringFromClass(TableViewController.class)];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;   //获得主窗口
    window.rootViewController = vc;                                   //将主窗口的根
}

- (void)dealloc
{
    NSLog(@"销毁登录页面");
}

@end
