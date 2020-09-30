//
//  ViewController.m
//  Note
//
//  Created by deng on 2020/6/5.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"
#import "NoteListViewController.h"

@interface ViewController ()
    <UITextFieldDelegate>

// 登录页面相应控件
@property (strong, nonatomic) UIButton *loginButton;
@property (strong, nonatomic) UITextField *usernameInput;
@property (strong, nonatomic) UITextField *passwordInput;
@property (strong, nonatomic) UILabel *logoName;

// 笔记列表
@property (strong, nonatomic) NoteListViewController *noteListViewController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 登录界面的背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 登录页面不需要 UINavigationBar
    self.navigationController.navigationBar.hidden = YES;
    
    // 不让 view 延伸到整个屏幕（界限分明）
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // 获取屏幕的尺寸
    CGRect screen = [[UIScreen mainScreen] bounds];
    
//------------------------------------------------------------------- 登录按钮
    
    // 使用自定义按钮（如果使用系统自带按钮是修改不了颜色的）
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // 设置登录按钮位于屏幕中央
    self.loginButton.frame = CGRectMake(20, (screen.size.height - 44)/2, screen.size.width - 40, 44);
    
    // 设置按钮的标题和状态
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    
    // 设置按钮的背景颜色
    self.loginButton.backgroundColor = [UIColor grayColor];
    
    // 设置按钮的文字颜色
    self.loginButton.titleLabel.textColor = [UIColor whiteColor];
    
    // 监听按钮点击
    [self.loginButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    
    // 将登录按钮添加到登录页面
    [self.view addSubview:self.loginButton];

//------------------------------------------------------------------- 输入密码
    
    // 密码输入框以 loginButton 进行相对布局
    CGRect loginButton = self.loginButton.frame;
    
    // 创建密码输入框
    self.passwordInput = [[UITextField alloc] initWithFrame:CGRectMake(loginButton.origin.x, loginButton.origin.y - 20 - 44, screen.size.width - 40, 44)];
    
    // 设置输入框的边框样式
    self.passwordInput.borderStyle = UITextBorderStyleRoundedRect;
    
    // 设置输入框的占位符
    self.passwordInput.placeholder = @"请输入密码";
    
    // 设置输入框为秘密模式
    self.passwordInput.secureTextEntry = YES;
    
    // self 负责处理 usernameInput 的响应
    self.passwordInput.delegate = self;
    
    // 输入密码后，键盘上的 return 键显示 “go”
    self.passwordInput.returnKeyType = UIReturnKeyGo;
    
    // 密码的键盘类型为默认类型
    self.passwordInput.keyboardType = UIKeyboardTypeDefault;
    
    // 将密码输入框加入登录页面
    [self.view addSubview:self.passwordInput];

//------------------------------------------------------------------ 输入账号
    
    // 账号输入框以 passwordInput 进行相对布局
    CGRect passwordInput = self.passwordInput.frame;
    
    // 创建用户名输入框
    self.usernameInput = [[UITextField alloc] initWithFrame:CGRectMake(passwordInput.origin.x, passwordInput.origin.y - 7 - 44, screen.size.width - 40, 44)];
    
    // 设置输入框的边框样式
    self.usernameInput.borderStyle = UITextBorderStyleRoundedRect;
    
    // 设置输入框的占位符
    self.usernameInput.placeholder = @"请输入墨墨账号";
    
    // self 负责处理 usernameInput 的响应
    self.usernameInput.delegate = self;
    
    // 输入账号后，键盘上的 return 键显示 “go”
    self.usernameInput.returnKeyType = UIReturnKeyNext;
    
    // 账号的键盘类型为默认类型
    self.usernameInput.keyboardType = UIKeyboardTypeDefault;
    
    // 将用户输入框加入登录页面
    [self.view addSubview:self.usernameInput];
    
//---------------------------------------------------------------- 品牌名称
    
    // logoName 以 usernameInput 进行相对布局
    CGRect usernameInput = self.passwordInput.frame;
    
    // 创建 logoName 对象
    self.logoName = [[UILabel alloc] init];
    
    // 设置 logoName 的内容
    self.logoName.text = @"笔记";
    
    // 设置 logoName 的位置和大小
    self.logoName.frame = CGRectMake(usernameInput.origin.x, usernameInput.origin.y - 80 - 44, screen.size.width - 40, 44);
    
    // 设置字体大小
    self.logoName.font = [UIFont systemFontOfSize:32];
    
    // 字体左右居中
    self.logoName.textAlignment = NSTextAlignmentCenter;
    
    // 将 logoName 添加到登录界面中
    [self.view addSubview:self.logoName];
}

// 点击登录按钮，登录成功后跳转到笔记列表
- (void)login:(id)sender
{
    if ([self.usernameInput.text isEqualToString:@"110"]) {
        NSLog(@"账号正确");
        self.noteListViewController = [[NoteListViewController alloc] init];
        [self.navigationController pushViewController:self.noteListViewController animated:YES];
    } else {
        self.usernameInput.textColor = [UIColor redColor];
        NSLog(@"账号错误");
    }
}

#pragma mark - 实现 UITextFieldDelegate 委托协议方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"监听到 UITextField 中使用了 return 键");
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"监听输入框的变化");
    self.usernameInput.textColor = [UIColor blackColor];
    
    if (self.usernameInput.text.length != 0 && self.passwordInput.text.length >= 6) {
        self.loginButton.backgroundColor = [UIColor darkGrayColor];
    } else {
        self.loginButton.backgroundColor = [UIColor grayColor];
    }
    return YES;
}

@end
