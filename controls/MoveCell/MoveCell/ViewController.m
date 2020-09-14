//
//  ViewController.m
//  MoveCell
//
//  Created by deng on 2020/6/11.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray *data;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *tempArray = @[@"hello", @"thank you", @"are you ok", @"雷军"];
    self.data = [NSMutableArray arrayWithArray:tempArray];
    
    // 设置导航栏的右按钮为编辑按钮，会进入编辑状态（系统自带）
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.title = @"单元格的移动";
}


// 单元格个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}

// 单元格设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    
    cell.textLabel.text = self.data[indexPath.row];
    
    return cell;
}

// 重排时不出现删除按钮
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

// 允许移动单元格
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TRUE;
}

// 响应单元格移动
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSString *stringToMove = self.data[sourceIndexPath.row];
    
    [self.data removeObjectAtIndex:sourceIndexPath.row];
    [self.data insertObject:stringToMove atIndex:destinationIndexPath.row];
}

@end
