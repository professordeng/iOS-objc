//
//  ViewController.m
//  sqlite
//
//  Created by deng on 2020/6/13.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"
#import "NoteViewController.h"

@interface ViewController ()

// 保存从数据库中获取的笔记
@property (strong, nonatomic) NSMutableArray *listData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 获得 DAO 对象
    NoteDAO *dao = [NoteDAO sharedInstance];
    
    // 查询所有数据
    self.listData = [dao findAll];
        
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadView:) name:@"reloadViewNotification" object:nil];
    
    
}

#pragma mark - 处理重新加载表格的通知
- (void)reloadView:(NSNotification *)notification
{
    NSMutableArray *resList = [notification object];
    self.listData = resList;
    [self.tableView reloadData];
}

#pragma mark - 表格视图的数据源协议实现
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    
    Note *note = self.listData[indexPath.row];
        
    cell.textLabel.text = note.content;
    cell.detailTextLabel.text = [note.date description];
    
    return cell;
}

#pragma mark - 表格视图的左滑删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Note *note = self.listData[indexPath.row];
        // 获得 DAO 对象
        NoteDAO *dao = [NoteDAO sharedInstance];
        
        // 删除数据
        [dao remove:note];
        // 重新查询所有数据
        self.listData = [dao findAll];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}


// 点击单元格响应
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Note* note = self.listData[indexPath.row];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    NoteViewController *noteViewController = [storyboard instantiateViewControllerWithIdentifier:@"NoteViewController"];
    
    noteViewController.note = [[Note alloc] initWithDate:note.date content:note.content];
    [self.navigationController pushViewController:noteViewController animated:YES];
}
@end
