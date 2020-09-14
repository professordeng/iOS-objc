//
//  ViewController.m
//  TableViewCellLayout
//
//  Created by deng on 2020/7/3.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"
#import "Cell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSLog(@"调用 numberOfRowsInSection");
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    NSLog(@"调用 cellForRowAtIndexPath");
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"调用了 heightForRowAtIndexPath");
    return 90;
}



@end
