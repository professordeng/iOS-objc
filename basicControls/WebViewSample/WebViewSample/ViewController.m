//
//  ViewController.m
//  WebViewSample
//
//  Created by deng on 2020/6/1.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"

// 引入 WebKit 模块
#import <WebKit/WebKit.h>

@interface ViewController ()
    <WKNavigationDelegate> // 与 Web 视图界面加载过程有关
// WKWebView 中 WK 表示 WebKit
@property(nonatomic, strong) WKWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 获取屏幕大小
    CGRect screen = [[UIScreen mainScreen] bounds];
    
    // 按钮栏
    // 按钮栏宽
    CGFloat buttonBarWidth = 316;
    
    // 20 是状态栏高度
    UIView *buttonBar = [[UIView alloc] initWithFrame:CGRectMake((screen.size.width - buttonBarWidth)/2, 20, buttonBarWidth, 30)];
    
    // 添加按钮栏
    [self.view addSubview:buttonBar];
    
    // 1. 添加 LoadHTMLString 按钮
    UIButton *buttonLoadHTMLString = [UIButton buttonWithType:UIButtonTypeSystem];
    [buttonLoadHTMLString setTitle:@"LoadHTMLString" forState:UIControlStateNormal];
    buttonLoadHTMLString.frame = CGRectMake(0, 0, 117, 30);
    
    // action-target 事件处理方法
    [buttonLoadHTMLString addTarget:self action:@selector(testLoadHTMLString:) forControlEvents:UIControlEventTouchUpInside];
    [buttonBar addSubview: buttonLoadHTMLString];
    
    // 2. 添加 LoadData 按钮
    UIButton *buttonLoadData = [UIButton buttonWithType:UIButtonTypeSystem];
    [buttonLoadData setTitle:@"LoadData" forState:UIControlStateNormal];
    buttonLoadData.frame = CGRectMake(137, 0, 67, 30);
    
    // action-target 事件处理方法
    [buttonLoadData addTarget:self action:@selector(testLoadData:) forControlEvents:UIControlEventTouchUpInside];
    [buttonBar addSubview: buttonLoadData];
    
    // 3. 添加 LoadRequest 按钮
    UIButton *buttonLoadRequest = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [buttonLoadRequest setTitle:@"LoadRequest" forState:UIControlStateNormal];
    buttonLoadRequest.frame = CGRectMake(224, 0, 92, 30);
    
    // action-target 事件处理方法
    [buttonLoadRequest addTarget:self action:@selector(testLoadRequest:) forControlEvents:UIControlEventTouchUpInside];
    [buttonBar addSubview:buttonLoadRequest];
    
    // 4. 添加 WKWebView
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 60, screen.size.width, screen.size.height - 80)];
    
    [self.view addSubview: self.webView];
}

// 通过 HEML 字符串加载本地主页数据
- (void)testLoadHTMLString:(id)sender
{
    NSLog(@"LoadHTMLString test");
    
    // 获取当前路径下的一个 html 文件
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    
    NSURL *bundleUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    NSError *error = nil;
    
    NSString *html = [[NSString alloc] initWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:&error];
    
    // 如果获得 html 路径则开始下载
    if (error == nil) {
        [self.webView loadHTMLString:html baseURL:bundleUrl];
    }
}

// 先将数据存入 NSData，然后用 webView 的 loadData 方法加载数据
- (void)testLoadData:(id)sender
{
    NSLog(@"LoadData test");
    
    // html 路径
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    
    // 程序包路径
    NSURL *bundleUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    
    // 从 htmlPath 中得到数据
    NSData *htmlData = [[NSData alloc] initWithContentsOfFile: htmlPath];
    
    // 显示 htmlData 中的数据
    [self.webView loadData:htmlData MIMEType:@"html" characterEncodingName:@"UTF-8" baseURL:bundleUrl];
}

// 直接用 URL 下载数据
- (void)testLoadRequest:(id)sender
{
    NSURL *url = [NSURL URLWithString: @"https://professordeng.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    self.webView.navigationDelegate = self;
}

#pragma mark --实现 WKNavigationDelegate 委托协议
// 在 Web 视图开始加载界面时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    NSLog(@"开始加载");
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    NSLog(@"内容开始返回");
}

// 在 Web 视图完成加载之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSLog(@"加载完成");
}

// 在 Web 视图加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"加载失败 error : %@", error.description);
}

@end
