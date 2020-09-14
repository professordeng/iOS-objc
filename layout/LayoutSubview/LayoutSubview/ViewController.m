//
//  ViewController.m
//  LayoutSubview
//
//  Created by deng on 2020/7/2.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"
#import "Cell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"调用 viewDidLoad");
}

- (void)viewWillLayoutSubviews {
    NSLog(@"调用 viewWillLayoutSubviews");
}

- (void)viewDidLayoutSubviews {
    NSLog(@"调用 viewDidLayoutSubviews");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.contentLabel.text = @"你好";
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 我尝试在屏幕旋转的时候在这里重新渲染对应的单元格
    // 然后返回相应的高度，但是发现在这里获取单元格会报错
    NSLog(@"调用了 heightForRowAtIndexPath");
    
    return 40;
}

@end
