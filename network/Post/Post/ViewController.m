//
//  ViewController.m
//  Post
//
//  Created by deng on 2020/6/16.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"
#import "NotesListViewController.h"

@interface ViewController ()

// 账号输入框
@property (weak, nonatomic) IBOutlet UITextField *usernameInput;

// 密码输入框
@property (weak, nonatomic) IBOutlet UITextField *passwordInput;

// 登录按钮
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

// 提示信息
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 监听账号密码输入框
    [self.usernameInput addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventEditingChanged];
    [self.passwordInput addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventEditingChanged];

 }

// 登录功能 : POST 方法发送 JSON 格式的账号密码给服务器，返回 JSON 格式的相应信息
- (IBAction)login:(id)sender {
    if ([self.usernameInput.text length] == 0) {
        self.tipLabel.text = @"请输入账号";
        self.usernameInput.textColor = [UIColor redColor];
        self.passwordInput.textColor = [UIColor redColor];
        self.tipLabel.textColor = [UIColor redColor];
    } else if ([self.passwordInput.text length] == 0) {
        self.tipLabel.text = @"请输入密码";
        self.usernameInput.textColor = [UIColor redColor];
        self.passwordInput.textColor = [UIColor redColor];
        self.tipLabel.textColor = [UIColor redColor];
    } else {
        // 在账号框和密码框都不为空的时候向服务器请求
        [self loginRequest];
    }
}

- (void)loginRequest
{
    // 设置 URL 入口
    NSURL *url = [NSURL URLWithString:@"https://mainote.maimemo.com/api/auth/login"];
    
    // 初始化请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // 请求方法是 POST
    [request setHTTPMethod:@"POST"];
    
    // 请求类型是 json
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    // 请求体是 json 格式的账号和密码
    NSDictionary *json = @{
        @"identity" : [NSString stringWithFormat:@"%@", self.usernameInput.text],
        @"password" : [NSString stringWithFormat:@"%@", self.passwordInput.text]
    };
    
    // 任务数据需要包装成 NSData 格式
    NSData *postData = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:nil];
    
    // 设置请求的请求体
    [request setHTTPBody: postData];
    
    // 使用默认会话
    NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    // 将会话放到执行队列
    NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfig delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    // 设置请求任务，还有完成任务后要做的事情
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:
        ^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            self.loginMessage = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            if (self.loginMessage[@"jwt"]) {
                // 跳转到笔记列表
                [self performSegueWithIdentifier:@"login" sender:nil];
            } else {
                self.tipLabel.text = self.loginMessage[@"message"];
                self.usernameInput.textColor = [UIColor redColor];
                self.passwordInput.textColor = [UIColor redColor];
                self.tipLabel.textColor = [UIColor redColor];
            }
        } else {
            NSLog(@"error : %@", error.localizedDescription);
        }
    }];
    
    // 创建任务后，需要恢复任务才能执行操作
    [task resume];
}

#pragma mark - 给笔记列表控制器传参
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"login"]) {
        NotesListViewController *destViewController = segue.destinationViewController;
        destViewController.jwt = self.loginMessage[@"jwt"];
    }
}

#pragma mark - 设置为不自动跳转
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}

#pragma mark - 清除登录信息
- (void)viewWillDisappear:(BOOL)animated
{
    self.loginMessage = nil;
    self.passwordInput.text = @"";
    self.loginButton.backgroundColor = [UIColor colorWithRed:142.0/255 green:142.0/255 blue:142.0/255 alpha:1.0];
}

#pragma mark - 监听输入框
- (void)changedTextField:(UITextField *)sender
{
    // 输入信息时颜色正常
    self.usernameInput.textColor = [UIColor blackColor];
    self.passwordInput.textColor = [UIColor blackColor];
    self.tipLabel.textColor = [UIColor blackColor];

    self.tipLabel.text = @"";
    
    if ([self.usernameInput.text length] > 0 && [self.passwordInput.text length] > 0) {
        self.loginButton.backgroundColor = [UIColor colorWithRed:54.0/255 green:181.0/255 blue:157.0/255 alpha:1.0];
    } else {
        self.loginButton.backgroundColor = [UIColor colorWithRed:229.0/255 green:229.0/255 blue:229.0/255 alpha:1.0];
    }
}

@end
