//
//  EditViewController.m
//  Post
//
//  Created by deng on 2020/6/17.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "EditViewController.h"
#import "NSData+CRC32.h"

@interface EditViewController ()

// 保存笔记按钮
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveNoteButton;

// 输入标签
@property (weak, nonatomic) IBOutlet UITextField *labelsInput;

// 输入内容
@property (weak, nonatomic) IBOutlet UITextView *contentInput;

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置返回按钮样式
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backToNotesList:)];
    self.navigationItem.leftBarButtonItem = leftButton;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithRed:54.0/255 green:181.0/255 blue:157.0/255 alpha:1.0];
    
    // 保存按钮样式
    self.saveNoteButton.tintColor = [UIColor colorWithRed:54.0/255 green:181.0/255 blue:157.0/255 alpha:1.0];

    // 点击单元格后显示细节内容
    if (self.note) {
        self.navigationItem.title = self.note[@"title"];
        self.labelsInput.text = self.note[@"title"];
        self.contentInput.text = self.note[@"content"];
    }
}

- (void)backToNotesList:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveNote:(id)sender {
    if (self.note) {
        NSLog(@"需要更新的笔记编号是 : %@", self.note[@"id"]);
        [self updateNoteRequest:self.note[@"id"]];
    } else {
        [self newNoteRequest];
    }
}

- (void)newNoteRequest
{
    // 设置 URL 入口
    NSURL *url = [NSURL URLWithString:@"https://mainote.maimemo.com/api/note"];
    
    // 初始化请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // 请求方法是 POST
    [request setHTTPMethod:@"POST"];
    
    // 请求类型是 json
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    // 表明访问者的身份
    [request setValue: [NSString stringWithFormat: @"Bearer %@", self.jwt] forHTTPHeaderField: @"Authorization"];
    
    NSString *checkStr = [self.labelsInput.text stringByAppendingString:self.contentInput.text];
    NSData *checkData = [checkStr dataUsingEncoding:NSUTF8StringEncoding];
    int32_t checksum = [checkData crc32];
    
    // 新建笔记的 JSON 格式
    NSDictionary *json = @{
        @"title" : [NSString stringWithFormat:@"%@", self.labelsInput.text],
        @"content" :  [NSString stringWithFormat:@"%@", self.contentInput.text],
        @"is_public" : @(YES),
        @"checksum" : [NSString stringWithFormat:@"%x", checksum],
        @"local_updated_at" : @"2019-02-12T15:19:21+08:00"
    };
    
    // JSON 序列化
    NSData *postData = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:nil];
    
    // 设置请求的请求体
    [request setHTTPBody: postData];
    
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
                NSDictionary *nid = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"addNote" object:nid[@"id"]];
                [self.navigationController popViewControllerAnimated:YES];
            }
        } else {
            NSLog(@"error : %@", error.localizedDescription);
        }
    }];
    
    // 创建任务后，需要恢复任务才能执行操作
    [task resume];
}

- (void)updateNoteRequest:(NSString *)nid
{
    NSString *urlStr = [NSString stringWithFormat:@"https://mainote.maimemo.com/api/notes/%@", nid];
    
    // 设置 URL 入口
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
       
    // 初始化请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
       
    // 请求方法是 POST
    [request setHTTPMethod:@"PATCH"];
       
    // 请求类型是 json
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    // 表明访问者的身份
    [request setValue: [NSString stringWithFormat: @"Bearer %@", self.jwt] forHTTPHeaderField: @"Authorization"];
       
    NSString *checkStr = [self.labelsInput.text stringByAppendingString:self.contentInput.text];
    NSData *checkData = [checkStr dataUsingEncoding:NSUTF8StringEncoding];
    int32_t checksum = [checkData crc32];
       
    // 新建笔记的 JSON 格式
    NSDictionary *json = @{
        @"title" : [NSString stringWithFormat:@"%@", self.labelsInput.text],
        @"content" :  [NSString stringWithFormat:@"%@", self.contentInput.text],
        @"is_public" : @(YES),
        @"checksum" : [NSString stringWithFormat:@"%x", checksum],
        @"local_updated_at" : @"2019-02-12T15:19:21+08:00"
    };
       
    // JSON 序列化
    NSData *postData = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:nil];
    
    // 设置请求的请求体
    [request setHTTPBody: postData];
    
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
                [[NSNotificationCenter defaultCenter] postNotificationName:@"updateNote" object:self.note];
                [self.navigationController popViewControllerAnimated:YES];
            }
        } else {
            NSLog(@"error : %@", error.localizedDescription);
        }
    }];
    
    // 创建任务后，需要恢复任务才能执行操作
    [task resume];
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
