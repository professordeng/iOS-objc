//
//  NoteViewController.m
//  sqlite
//
//  Created by deng on 2020/6/13.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "NoteViewController.h"
#import "Note.h"
#import "NoteDAO.h"

@interface NoteViewController ()

// 正文
@property (weak, nonatomic) IBOutlet UITextView *textInput;

@end

@implementation NoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"创建笔记";
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(toNotesList:)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    if (self.note) {
        self.textInput.text = self.note.content;
    }
}

- (void)toNotesList:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveNote:(id)sender {
    // 获得 DAO 对象
    NoteDAO *dao = [NoteDAO sharedInstance];
    
    if (self.note) {  // 已有该笔记
        self.note.content = self.textInput.text;
        [dao modify:self.note];
    } else {          // 创建新笔记
        self.note = [[Note alloc] init];
        self.note.date = [[NSDate alloc] init];
        self.note.content = self.textInput.text;
        [dao create:self.note];
    }
    
    // 重新查询所有数据
    NSMutableArray *reslist = [dao findAll];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadViewNotification" object:reslist userInfo:nil];
    
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
