//
//  ViewController.m
//  RefreshControlSample
//
//  Created by deng on 2020/6/3.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray* logs;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 初始化变量和时间
    self.logs = [[NSMutableArray alloc] init];
    NSDate *date = [[NSDate alloc] init];
    [self.logs addObject:date];
    
    // 初始化 UIRefreshControl
    UIRefreshControl *rc = [[UIRefreshControl alloc] init];
    
    // 下拉时出现的文字
    rc.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    
    // 下拉触发 refreshTableView 方法
    [rc addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    
    // 将该视图的刷新控制交给 rc
    self.refreshControl = rc;
}

- (void)refreshTableView
{
    // 当处于刷新状态时
    if (self.refreshControl.refreshing) {
        // 显示刷新中
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"加载中..."];
        
        // 添加新的单元格数据
        NSDate *date = [[NSDate alloc] init];
        [self.logs addObject:date];
        
        // 完成刷新操作后停止刷新
        [self.refreshControl endRefreshing];
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
        
        // 重新加载控件
        [self.tableView reloadData];
    }
}

#pragma mark - UITableViewDataSource 协议方法
// 节中的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.logs count];
}

// 设置单元格样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    
   // 若队列中没有可用单元格，得自己分配（故事板不需要这步）
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellIdentifier"];
    }
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat: @"yyyy-MM-dd HH:mm:ss zzz"];
    
    cell.textLabel.text = [dateFormat stringFromDate: self.logs[indexPath.row]];
    
    // 设置附件类型（小挂件之类的），单元格右边有个小箭头（也就是拓展视图）
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

@end
