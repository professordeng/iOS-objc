//
//  NoteListViewController.m
//  Note
//
//  Created by deng on 2020/6/5.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "NoteListViewController.h"

@interface NoteListViewController ()

@end

@implementation NoteListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 笔记列表的背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 笔记列表需要 UINavigationBar
    self.navigationController.navigationBar.hidden = NO;
    
    // 不让笔记列表的内容延伸到整个屏幕（不影响导航栏）
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
}

#pragma mark - 监听返回按钮

- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"该页面被摧毁");
    self.navigationController.navigationBar.hidden = YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
