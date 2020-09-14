//
//  ViewController.m
//  AFNetworkingDemo
//
//  Created by deng on 2020/6/19.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()

@property (strong, nonatomic) NSString *jwt;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self login];
    
    // 登录通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNotes:) name:@"login" object:nil];
    
    // 获取笔记列表通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteNote:) name:@"getNotes" object:nil];
    
    // 删除笔记通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addNote:) name:@"deleteNote" object:nil];
}

- (void)login
{
        // 设置请求字符串
    NSString *urlStr = @"https://mainote.maimemo.com/api/auth/login";
    
    // 设置 URL
    NSURL *url = [NSURL URLWithString: [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
    
    // 初始化请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // 设置请求方法为 POST 请求
    [request setHTTPMethod:@"POST"];
    
    // 请求体类型是 json
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
       
    // 设置请求体
    NSDictionary *json = @{
        @"identity" : @"wf.deng@maimemo.com",
        @"password" : @"123456"
    };
    
    // 协议数据需要封装为 NSData
    NSData *postData = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:nil];
    
    // 将数据放到请求体中
    [request setHTTPBody:postData];
    
    // 会话配置
    NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:defaultConfig];
    
    // 设置请求任务，包括请求成功后需要做的事
    // AFNetworking 不需要我们解析服务器发来的 json 文件了
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        NSLog(@"登录请求完成");
        if (!error) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:responseObject];
        } else {
            NSLog(@"error : %@", error.localizedDescription);
        }
    }];
    
    [task resume];
}

- (void)getNotes:(NSNotification *)notification
{
    NSDictionary *loginMessage = [notification object];
    self.jwt = loginMessage[@"jwt"];
    
    // URL 字符串格式
    NSString *urlStr = @"https://mainote.maimemo.com/api/notes?skip=0&limit=30";
    
    // 设置 URL
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
    
    // 初始化请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
       
    // 请求方法是 GET
    [request setHTTPMethod:@"GET"];

    // 表明访问者的身份
    [request setValue: [NSString stringWithFormat: @"Bearer %@", self.jwt] forHTTPHeaderField: @"Authorization"];
    
    // 使用默认会话
    NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:defaultConfig];
      
    // 设置请求任务，包括请求成功后需要做的事
    // AFNetworking 不需要我们解析服务器发来的 json 文件了
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            NSLog(@"获取笔记列表请求完成");
        if (!error) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getNotes" object:responseObject];
        } else {
            NSLog(@"error : %@", error.localizedDescription);
        }
    }];
    
    // 创建任务后，需要恢复任务才能执行操作
    [task resume];

}

- (void)deleteNote:(NSNotification *)notification
{
    NSDictionary *retData = [notification object];
    NSArray *notes = retData[@"items"];
    NSString *nid = [notes[0] valueForKey:@"id"];
    NSLog(@"待删笔记的 nid : %@", nid);
    
    // 设置 URL
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://mainote.maimemo.com/api/notes/%@", nid]];
      
    // 初始化请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // 请求方法是 DELETE
    [request setHTTPMethod:@"DELETE"];
    
    // 表明访问者的身份
    [request setValue: [NSString stringWithFormat: @"Bearer %@", self.jwt] forHTTPHeaderField: @"Authorization"];
    
    // 使用默认会话
    NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:defaultConfig];
      
    // 设置请求任务，包括请求成功后需要做的事
    // AFNetworking 不需要我们解析服务器发来的 json 文件了
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            NSLog(@"删除笔记请求完成");
        if (!error) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteNote" object:responseObject];
        } else {
            NSLog(@"error : %@", error.localizedDescription);
        }
    }];
    
    // 创建任务后，需要恢复任务才能执行操作
    [task resume];
}

- (void)addNote:(NSNotification *)notification
{
    NSDictionary *retData = [notification object];
    NSLog(@"删除笔记 : %@", retData);
}

@end
