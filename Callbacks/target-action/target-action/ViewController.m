//
//  ViewController.m
//  target-action
//
//  Created by deng on 2020/6/24.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// 输入
@property (weak, nonatomic) IBOutlet UITextField *input;

// 根据输入实时渲染
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.input addTarget:self action:@selector(changeLabel:) forControlEvents:UIControlEventEditingChanged];
}


// 一对一响应事件
- (void)changeLabel:(id)sender {
    self.label.text = self.input.text;
}

@end
