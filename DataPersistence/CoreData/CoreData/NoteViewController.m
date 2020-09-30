//
//  NoteViewController.m
//  CoreData
//
//  Created by deng on 2020/6/16.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "NoteViewController.h"

@interface NoteViewController ()

// 编辑区
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation NoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backToNotesList:)];
    self.navigationItem.leftBarButtonItem = leftButton;
}

- (void)backToNotesList:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveNote:(id)sender {
    // 获得 DAO 对象
    NoteDAO *dao = [NoteDAO sharedInstance];
    
    if (self.note) { // 已有该笔记
        self.note.content = self.textView.text;
        [dao modify:self.note];
    } else { // 新笔记
        self.note = [[Note alloc] initWithDate:[[NSDate alloc] init] content:self.textView.text];
        [dao create:self.note];
    }
    
    // 重新查询所有数据
    NSMutableArray *resList = [dao findAll];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadViewNotification" object:resList userInfo:nil];
    [self.textView resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
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
