//
//  ViewController.m
//  IndexTable
//
//  Created by deng on 2020/6/11.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSDictionary *dictData;

// 小组名集合
@property (strong, nonatomic) NSArray *listGroupname;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"team_dictionary" ofType:@"plist"];
    
    // 获取属性列表文件中的全部数据
    self.dictData = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    NSArray *tempList = [self.dictData allKeys];
    
    // 对 key 进行排序
    self.listGroupname = [tempList sortedArrayUsingSelector:@selector(compare:)];
}

#pragma mark - 实现数据源协议方法
// 返回每个节的大小
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 按照节索引从小组名数组中获得组名
    NSString *groupName = self.listGroupname[section];
    
    // 将组名作为 key，从字典中取出球队数组集合
    NSArray *listTeams = self.dictData[groupName];
    return [listTeams count];
}

// 设置第 section 个节第 row 行的单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    
    // 获得选择的节
    NSUInteger section = [indexPath section];
    // 获得选择节中的行索引
    NSUInteger row = [indexPath row];
    // 按照节索引从小组名数组中获得组名
    NSString *groupName = self.listGroupname[section];
    // 将组名作为 key，从字典中取出球队数组集合
    NSArray *listTeams = self.dictData[groupName];
    
    cell.textLabel.text = listTeams[row];
    return cell;
}

// 设置表视图的节的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.listGroupname count];
}

// 设置节头
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.listGroupname[section];
}

// 设置节索引，可以实现快速定位
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *listTitles = [[NSMutableArray alloc] init];
    // 把 "A 组" 改为 "A"
    for (NSString *item in self.listGroupname) {
        NSString *title = [item substringToIndex:1];
        [listTitles addObject:title];
    }
    return listTitles;
}

@end
