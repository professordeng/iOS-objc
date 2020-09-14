//
//  ViewController.m
//  DeleteAddCell
//
//  Created by deng on 2020/6/11.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
    <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtField;
@property (strong, nonatomic) NSMutableArray *listTeams;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置导航栏
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.title = @"单元格插入和删除";
    
    // 设置单元格文本框
    self.txtField.hidden = TRUE;
    self.txtField.delegate = self;
    
    self.listTeams = [[NSMutableArray alloc] initWithObjects:@"黑龙江", @"吉林", @"辽宁", nil];
}

#pragma mark - UIViewController 生命周期方法，用于响应视图编辑状态变化
// 点击 edit 按钮调用
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:TRUE];
    
    [self.tableView setEditing:editing animated:TRUE];
    if (editing) {
        self.txtField.hidden = FALSE;
    } else {
        self.txtField.hidden = TRUE;
    }
}

#pragma mark - 表示图协议
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listTeams count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL b_addCell = (indexPath.row == self.listTeams.count);
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    
    if (!b_addCell) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = self.listTeams[indexPath.row];
    } else {
        // 将 textField 放到单元格中
        self.txtField.frame = CGRectMake(50, 0, 300, cell.frame.size.height);
        self.txtField.borderStyle = UITextBorderStyleNone;
        self.txtField.placeholder = @"Add...";
        self.txtField.text = @"";
        [cell addSubview:self.txtField];
    }
    return cell;
}

#pragma mark - 最后一个是 add 图标，其他是 delete 图标
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self.listTeams count]) {
        return UITableViewCellEditingStyleInsert;
    } else {
        return UITableViewCellEditingStyleDelete;
    }
}

#pragma mark - 实现删除或插入操作
// 苹果手机可以实现左滑手势删除单元格
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.listTeams removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        [self.listTeams insertObject:self.txtField.text atIndex:[self.listTeams count]];
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    }
    [self.tableView reloadData];
}

// 在非编辑状态下，不能看到最后一行（添加栏）
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self.listTeams count]) {
        return FALSE;
    } else {
        return TRUE;
    }
}

// 实现 UITextFieldDelegate 委托方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return TRUE;
}

@end
