//
//  ViewController.m
//  JSON
//
//  Created by deng on 2020/6/16.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()

// 保存数据列表
@property (strong, nonatomic) NSMutableArray *listData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Notes" ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:path];
    
    NSError *error;
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (!jsonObj || error) {
        NSLog(@"JSON 解码失败");
    }
    
    self.listData = jsonObj[@"Record"];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSMutableDictionary *dict = self.listData[indexPath.row];
        DetailViewController *controller = segue.destinationViewController;
        [controller setDetailItem:dict];
    }
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    
    NSMutableDictionary *dict = self.listData[indexPath.row];
    cell.textLabel.text = dict[@"Content"];
    cell.detailTextLabel.text = dict[@"CDate"];
    
    return cell;
}

@end
