//
//  ViewController.m
//  CoreData
//
//  Created by deng on 2020/6/13.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"
#import "NoteViewController.h"

@interface ViewController ()
    <UISearchBarDelegate, UISearchResultsUpdating>

// 保存数据列表
@property (strong, nonatomic) NSMutableArray *listData;

// 添加搜索栏
@property (strong, nonatomic) UISearchController *searchController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    // 获得 DAO 对象
    NoteDAO *dao = [NoteDAO sharedInstance];
    // 查询所有数据
    self.listData = [dao findAll];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadView:) name:@"reloadViewNotification" object:nil];
    
    // --- 添加搜索栏
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    
    self.searchController.searchResultsUpdater = self;
    
    // 在搜索时，设置背景为灰色
    self.searchController.obscuresBackgroundDuringPresentation = FALSE;

    // 将搜索栏放到表视图的表头中
     self.tableView.tableHeaderView = self.searchController.searchBar;

    [self.searchController.searchBar sizeToFit];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    Note *note = self.listData[indexPath.row];
    cell.textLabel.text = note.content;
    cell.detailTextLabel.text = [note.date description];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TRUE;
}

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

#pragma mark - 处理通知
- (void)reloadView:(NSNotification *)notification
{
    NSMutableArray *resList = [notification object];
    self.listData = resList;
    [self.tableView reloadData];
}

#pragma mark - 故事板跳转前的准备
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ModifyNote"]){
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        Note *note = self.listData[indexPath.row];
        NoteViewController *destViewController = segue.destinationViewController;
        destViewController.note = [[Note alloc] initWithDate:note.date content:note.content];
    }
}

#pragma mark - 搜索栏协议
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *keyword = searchController.searchBar.text;
    NoteDAO *dao = [NoteDAO sharedInstance];
    
    if ([keyword length] == 0) {
        self.listData = [dao findAll];
        return;
    }
    
    self.listData = [dao searchByKeyword:keyword];
    [self.tableView reloadData];
}

@end
