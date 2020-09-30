//
//  ViewController.m
//  Notification
//
//  Created by deng on 2020/6/24.
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
    
    // 注册通知，当有其他方法发出 changeLabel 通知后会响应 changeLabel: 方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLabel:) name:@"changeLabel" object:nil];
}

- (void)changeLabel:(NSNotification *)notification {
    NSString *text = [notification object];
    self.label.text = text;
}

@end
