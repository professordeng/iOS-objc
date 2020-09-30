//
//  ViewController.m
//  ModalViewSample
//
//  Created by deng on 2020/6/3.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"
#import "RegisterViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    
    self.navigationItem.title = @"登录";
    
    // 1. 添加用户 ID：标签
    UILabel* labelId = [[UILabel alloc] initWithFrame:CGRectMake(80,115, 80, 21)];
    labelId.text = @"用户ID：";
    [self.view addSubview:labelId];
    
    // 2. 添加用户 ID TextField
    UITextField* textFieldId = [[UITextField alloc] initWithFrame:CGRectMake(170, 106, 100, 30)];
    textFieldId.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:textFieldId];
    
    // 3. 添加密码：标签
    UILabel* labelPwd = [[UILabel alloc] initWithFrame:CGRectMake(80, 178, 80, 21)];
    labelPwd.text = @"密码：";
    [self.view addSubview:labelPwd];
    
    // 4. 添加密码 TextField
    UITextField* textFieldPwd = [[UITextField alloc] initWithFrame:CGRectMake(170, 169, 100, 30)];
    textFieldPwd.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:textFieldPwd];
    
    // 5. 添加 登录按钮
    UIButton* buttonLogin = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonLogin.frame = CGRectMake((screen.size.width - 30)/2, 231, 50, 30);
    [buttonLogin setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:buttonLogin];
    
    // 6. 添加 注册按钮
    UIButton* buttonReg = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonReg.frame = CGRectMake((screen.size.width - 30)/2, 294, 50, 30);
    [buttonReg setTitle:@"注册" forState:UIControlStateNormal];
    [buttonReg addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:buttonReg];
    
    // 注册通知 RegisterCompletionNotification，其中 registerCompletion: 是回调方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(registerCompletion:) name:@"RegisterCompletionNotification" object:nil];
}

- (void)onClick:(id)sender {
    
    RegisterViewController* registerViewController = [[RegisterViewController alloc] init];
    
    // 用于实例化导航控制器，然后将 registerViewController 嵌入到该控制器中
    UINavigationController* navigationController = [[UINavigationController alloc] initWithRootViewController:registerViewController];
    
    // 呈现模态视图
    [self presentViewController:navigationController animated:TRUE completion:nil];
}


-(void)registerCompletion:(NSNotification*)notification {
    
    // 获取数据
    NSDictionary *theData = [notification userInfo];
    NSString *username = theData[@"username"];
    
    // 输出注册页面传来的数据
    NSLog(@"username = %@",username);
}

@end
