//
//  ViewController.m
//  TableReload
//
//  Created by deng on 2020/7/8.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray *listData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.listData = [[NSMutableArray alloc] init];
    for (int i = 0; i < 30; i ++) {
        [self.listData addObject:@"hello"];
    }
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.listData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.listData[indexPath.row];
    
    return cell;
}

- (IBAction)changeCell:(id)sender {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:28 inSection:0];
    
    self.listData[28] = @"are you ok?";
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
}

@end
