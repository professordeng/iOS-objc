//
//  NotesListViewController.m
//  Post
//
//  Created by deng on 2020/6/17.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "NotesListViewController.h"
#import "EditViewController.h"

@interface NotesListViewController ()
    <UISearchControllerDelegate, UISearchResultsUpdating>
{
    BOOL _canSearch;
}

// 导航栏右侧对添加笔记按钮
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addNoteButton;

// 搜索栏
@property (strong, nonatomic) UISearchController *searchController;

// 方便读取数据的指针
@property (strong, nonatomic) NSMutableArray *items;

// 保存所有笔记
@property (strong, nonatomic) NSMutableDictionary *notes;

@end

@implementation NotesListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 在视图没有加载完成之前是不允许搜索的
    _canSearch = FALSE;
    
    // 设置退出按钮样式
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"退出登录" style:UIBarButtonItemStylePlain target:self action:@selector(logout:)];
    self.navigationItem.leftBarButtonItem = logoutButton;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithRed:142.0/255 green:142.0/255 blue:142.0/255 alpha:1.0];
  
    // 设置导航栏右按钮颜色
    self.addNoteButton.tintColor = [UIColor colorWithRed:54.0/255 green:181.0/255 blue:157.0/255 alpha:1.0];
    
    // 生成搜索控制器
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    
    // 设置搜索控制器的代理为当前视图
    self.searchController.delegate = self;
    
    // 设置搜索代理
    self.searchController.searchResultsUpdater = self;
    
    // 取消搜索栏高亮
    self.searchController.obscuresBackgroundDuringPresentation = FALSE;
    
    // 将搜索栏放在表头
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    // 保证跳转的时候搜索栏消失
    self.definesPresentationContext = YES;
    
    // 尝试自定义搜索框样式
    self.searchController.searchBar.tintColor = [UIColor colorWithRed:54.0/255 green:181.0/255 blue:157.0/255 alpha:1.0];
    self.searchController.searchBar.placeholder = @"搜索";
    
    // 设置取消按钮的文字
    // https://stackoverflow.com/questions/58040519/uisearchbars-set-cancelbuttontext-ivar-is-prohibited
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitle:@"取消"];

    // 网络请求完成后通常需要重新加载页面
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadView:) name:@"reloadNotesList" object:nil];
    
    // 新建笔记需要更新笔记列表，将最新笔记放在笔记列表的最前面
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addNote:) name:@"addNote" object:nil];
    
    // 更新笔记需要更新笔记列表
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateNote:) name:@"updateNote" object:nil];
    
    // 获取所有笔记
    [self getNotes];
}

// 获取笔记，使用 GET 方法
- (void)getNotes
{
    [self getNotesRequest];
}

- (void)getNotesRequest
{
    // 设置 URL 入口
    NSURL *url = [NSURL URLWithString:@"https://mainote.maimemo.com/api/notes?skip=0&limit=30"];
      
    // 初始化请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // 请求方法是 GET
    [request setHTTPMethod:@"GET"];
    
    // 表明访问者的身份
    [request setValue: [NSString stringWithFormat: @"Bearer %@", self.jwt] forHTTPHeaderField: @"Authorization"];
    
    // 使用默认会话
    NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    // 将会话放到执行队列
    NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfig delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    // 设置请求任务
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:
        ^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
           if ([httpResponse statusCode] == 200) {
               NSLog(@"获取笔记列表成功");
               self.notes = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
               
               // 获得数据后重新加载页面
               [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadNotesList" object:nil];
           }
        } else {
            NSLog(@"error : %@", error.localizedDescription);
        }
    }];
    
    // 创建任务后，需要恢复任务才能执行操作
    [task resume];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSDictionary *note = self.items[indexPath.row];
    cell.textLabel.text = note[@"title"];
    cell.detailTextLabel.text = note[@"content"];
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 首先将删除操作同步到服务器
        NSDictionary *note = self.items[indexPath.row];
        
        [self deleteNoteRequest: note[@"id"]];
        
        // 删除然后内存中对应的数据
        [self.items removeObjectAtIndex:indexPath.row];
        
        // 将待删除的笔记从数据源中清除
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


// 删除云端笔记，使用 DELETE 方法
- (void)deleteNoteRequest:(NSString *)nid
{
    // 设置 URL 入口
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://mainote.maimemo.com/api/notes/%@", nid]];
      
    // 初始化请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // 请求方法是 DELETE
    [request setHTTPMethod:@"DELETE"];
    
    // 表明访问者的身份
    [request setValue: [NSString stringWithFormat: @"Bearer %@", self.jwt] forHTTPHeaderField: @"Authorization"];
    
    // 使用默认会话
    NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    // 将会话放到执行队列
    NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfig delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    // 设置请求任务
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:
        ^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if ([httpResponse statusCode] == 200) {
                NSLog(@"删除成功");
            }
        } else {
            NSLog(@"error : %@", error.localizedDescription);
        }
    }];
    
    // 创建任务后，需要恢复任务才能执行操作
    [task resume];
}

- (void)logoutRequest
{
    // 设置 URL 入口
    NSURL *url = [NSURL URLWithString:@"https://mainote.maimemo.com/api/auth/logout"];
    
    // 初始化请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // 请求方法是 POST
    [request setHTTPMethod:@"POST"];
    
    // 表明访问者的身份
    [request setValue: [NSString stringWithFormat: @"Bearer %@", self.jwt] forHTTPHeaderField: @"Authorization"];
    
    // 使用默认会话
    NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    // 将会话放到执行队列
    NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfig delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    // 设置请求任务，还有完成任务后要做的事情
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:
        ^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if ([httpResponse statusCode] == 200) {
                NSLog(@"退出成功");
            }
        } else {
            NSLog(@"error : %@", error.localizedDescription);
        }
    }];
    
    // 创建任务后，需要恢复任务才能执行操作
    [task resume];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    EditViewController *destViewController = segue.destinationViewController;
    destViewController.jwt = self.jwt;
    
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        destViewController.note = self.items[indexPath.row];
    }
}

- (void)reloadView:(NSNotification *)notification
{
    // notes 是从服务器中获取的数据，提取所有的文章到 items
    self.items = [self.notes[@"items"] mutableCopy];
    
    // 重新加载表格视图
    [self.tableView reloadData];
    
    _canSearch = TRUE;
}

- (void)addNote:(NSNotification *)notification
{
    NSString *nid = [notification object];
    NSLog(@"更新的 id 是 %@", nid);
    [self getNoteRequest:nid];
}

- (void)updateNote:(NSNotification *)notification
{
    NSDictionary *note = [notification object];
    [self.items removeObject:note];
    [self getNoteRequest:note[@"id"]];
}

// 获取编号为 nid 的笔记
- (void)getNoteRequest:(NSString *)nid
{
    NSString *urlStr = [NSString stringWithFormat:@"https://mainote.maimemo.com/api/notes/%@", nid];
    
    // 设置 URL 入口
    NSURL *url = [NSURL URLWithString:urlStr];
      
    // 初始化请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // 请求方法是 GET
    [request setHTTPMethod:@"GET"];
    
    // 表明访问者的身份
    [request setValue: [NSString stringWithFormat: @"Bearer %@", self.jwt] forHTTPHeaderField: @"Authorization"];
    
    // 使用默认会话
    NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    // 将会话放到执行队列
    NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfig delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    // 设置请求任务
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:
        ^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
           if ([httpResponse statusCode] == 200) {
               NSDictionary *note = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
               NSLog(@"成功获取 id 为 %@ 的笔记", note[@"id"]);
               
               // 更新笔记列表
               [self.items insertObject:note atIndex:0];
               [self.tableView reloadData];
           }
        } else {
            NSLog(@"error : %@", error.localizedDescription);
        }
    }];
    
    // 创建任务后，需要恢复任务才能执行操作
    [task resume];
}

- (void)logout:(id)sender
{
    // 发出退出请求
    [self logoutRequest];
    
    // 退出登录
    [self.navigationController popViewControllerAnimated:YES];
}

// 搜索策略
// 1. 上次搜索结果返回之前不再进行搜索
// 2. 每隔一段时间搜索
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *keyword = searchController.searchBar.text;
    NSLog(@"关键词是 : %@", keyword);
    if ([keyword length] > 0 && _canSearch) {
        [self searchRequest:keyword];
    }
}

- (void)searchRequest:(NSString *)keyword
{
    // 在上一次搜索结束之前是不允许搜索的
    _canSearch = FALSE;
    
    // 设置 URL 字符串
    NSString *urlStr = [NSString stringWithFormat:@"https://mainote.maimemo.com/api/notes?skip=0&limit=30&search=%@", keyword];
    
    // 设置 URL，注意要转成 URL 允许的字符
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
        
    // 初始化请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
       
    // 请求方法是 GET
    [request setHTTPMethod:@"GET"];
       
    // 表明访问者的身份
    [request setValue: [NSString stringWithFormat: @"Bearer %@", self.jwt] forHTTPHeaderField: @"Authorization"];
       
    // 使用默认会话
    NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
       
    // 将会话放到执行队列
    NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfig delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
       
    // 设置请求任务
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:
        ^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if ([httpResponse statusCode] == 200) {
                NSLog(@"获取笔记列表成功");
                self.notes = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                
                // 获得数据后重新加载页面
                [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadNotesList" object:nil];
            }
        } else {
            NSLog(@"error : %@", error.localizedDescription);
        }
    }];
       
    // 创建任务后，需要恢复任务才能执行操作
    [task resume];
}

@end
