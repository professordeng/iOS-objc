//
//  TableViewController.m
//  CustomCell
//
//  Created by deng on 2020/6/23.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"

@interface TableViewController ()

@property (strong, nonatomic) NSMutableArray *listLabels;
@property (strong, nonatomic) NSMutableArray *listContent;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.listLabels = [[NSMutableArray alloc] init];
    self.listContent = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 30; i ++) {
        if (i % 2 == 0) {
            [self.listLabels addObject:@"你说/我做/我做不到"];
            [self.listContent addObject:@"我说我杀人不眨眼，你问我眼睛酸不酸？你好毒你好毒你好毒你好毒你好毒你好毒你好毒你好毒你好毒你好毒你好毒你好毒你好毒你好毒你好毒你好毒你好毒你好毒你好毒毒毒毒毒"];
        } else {
            [self.listLabels addObject:@"盘它/不盘/盘不动"];
            [self.listContent addObject:@"你好"];
        }
    }
    
    // 设置表格下边框颜色
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 20, 0, 20)];
    }
    
    // 设置分割线的颜色及风格
    [self.tableView setSeparatorColor:[UIColor systemGray4Color]];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.listContent count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.labels = self.listLabels[indexPath.row];
    cell.contentLabel.text = self.listContent[indexPath.row];
    [cell setView];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了第 %ld 行", indexPath.row);
}

@end
