//
//  ViewController.m
//  SearchbarTable
//
//  Created by deng on 2020/6/11.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
    <UISearchBarDelegate, UISearchResultsUpdating>

@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) NSMutableArray *filterData;

// 搜索框
@property (strong, nonatomic) UISearchController *searchController;

// 内容过滤方法
- (void)filterDataForSearchText:(NSString *)searchText scope:(NSUInteger)scope;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.data = @[@"hello", @"goodbye", @"loveyou"];
    
    // 查询所有数据
    [self filterDataForSearchText:@"" scope:-1];
    
    // 实例化 UISearchController
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    
    // 设置 self 为更新搜索结果对象
    self.searchController.searchResultsUpdater = self;
    
    // 在搜索时，设置背景为灰色
    self.searchController.obscuresBackgroundDuringPresentation = FALSE;
    
    // 设置搜索范围栏中的按钮
    self.searchController.searchBar.scopeButtonTitles = @[@"中文", @"英文"];
    self.searchController.searchBar.delegate = self;
    
    // 将搜索栏放到表视图的表头中
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    [self.searchController.searchBar sizeToFit];
}

#pragma mark - 表格视图数据源协议
// 单元格个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.filterData count];
}

// 单元格数据设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    
    NSUInteger row = [indexPath row];
    cell.textLabel.text = self.filterData[row];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - 搜索栏相关协议
// 点击搜索范围栏的按钮时触发
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    NSLog(@"当前索引是 %ld", (long)selectedScope);
    [self updateSearchResultsForSearchController:self.searchController];
}

// 搜索框内容发生改变时触发
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchString = searchController.searchBar.text;
    // selectedScopeButtonIndex 表示当前选中的范围栏按钮的索引
    [self filterDataForSearchText:searchString scope:searchController.searchBar.selectedScopeButtonIndex];
    [self.tableView reloadData];
}

#pragma mark - 搜索方法
- (void)filterDataForSearchText:(NSString *)searchText scope:(NSUInteger)scope
{
    if ([searchText length] == 0) {
        // 查询所有
        self.filterData = [NSMutableArray arrayWithArray:self.data];
        return;
    }
    
    NSPredicate *scopePredicate;
    NSArray *tempArray;
    
    // predicate 是谓语的意思
    scopePredicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@", searchText];
    tempArray = [self.data filteredArrayUsingPredicate:scopePredicate];
    self.filterData = [NSMutableArray arrayWithArray:tempArray];
}

@end
