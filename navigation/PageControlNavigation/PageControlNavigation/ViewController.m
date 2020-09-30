//
//  ViewController.m
//  PageControlNavigation
//
//  Created by deng on 2020/6/4.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"

// 定义获取屏幕宽度宏
#define S_WIDTH [[UIScreen mainScreen] bounds].size.width
//定义获取屏幕高度宏
#define S_HEIGHT [[UIScreen mainScreen] bounds].size.height

// UIScrollViewDelegate 用于响应屏幕滚动事件
@interface ViewController () <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;

@property (strong, nonatomic) UIImageView *imageView1;
@property (strong, nonatomic) UIImageView *imageView2;
@property (strong, nonatomic) UIImageView *imageView3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:self.scrollView];
    
    // 设置 scrollView 的委托对象为当前视图控制器
    self.scrollView.delegate = self;
    // 滚动时翻一页
    self.scrollView.pagingEnabled = TRUE;
    // 水平滚动条不显示
    self.scrollView.showsHorizontalScrollIndicator = FALSE;
    // 垂直滚动条不显示
    self.scrollView.showsVerticalScrollIndicator = FALSE;
    
    // 设置滚动视图的 frame 属性，三张图片水平滚动，因此宽度是屏幕的 3 倍
    self.scrollView.contentSize = CGSizeMake(S_WIDTH * 3, S_HEIGHT);
    // 设置滚动视图的可视区域
    self.scrollView.frame = self.view.frame;
    
    // 将图片平铺中内容区中
    self.imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, S_WIDTH, S_HEIGHT)];
    self.imageView1.image = [UIImage imageNamed:@"达芬奇-蒙娜丽莎.png"];
    
    self.imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(S_WIDTH, 0.0f, S_WIDTH, S_HEIGHT)];
    self.imageView2.image = [UIImage imageNamed:@"罗丹-思想者.png"];

    self.imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(2 * S_WIDTH, 0.0f, S_WIDTH, S_HEIGHT)];
    self.imageView3.image = [UIImage imageNamed:@"保罗克利-肖像.png"];
       
    [self.scrollView addSubview:self.imageView1];
    [self.scrollView addSubview:self.imageView2];
    [self.scrollView addSubview:self.imageView3];
       
    CGFloat pageControlWidth  = 300.0;
    CGFloat pageControlHeight = 37.0;
    // 创建分屏控件对象
    self.pageControl = [[UIPageControl alloc]
                           initWithFrame:CGRectMake((S_WIDTH - pageControlWidth) / 2, S_HEIGHT - pageControlHeight, pageControlWidth, pageControlHeight)];
    // 总屏数为 3
    self.pageControl.numberOfPages = 3;
    
    // 添加事件，响应动作为 changePage
    [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents: UIControlEventValueChanged];
    [self.view addSubview:self.pageControl];
}

#pragma mark - 实现 UIScrollViewDelegate 委托协议
- (void) scrollViewDidScroll: (UIScrollView *) scrollView {
    CGPoint offset = scrollView.contentOffset;
    self.pageControl.currentPage = offset.x / S_WIDTH;
}

#pragma mark - 实现 UIPageControl 事件处理
- (void)changePage:(id)sender {
    [UIView animateWithDuration:0.3f animations:^{
        // 获取当前页索引
        NSInteger whichPage = self.pageControl.currentPage;
        // 设置内容偏移
        self.scrollView.contentOffset = CGPointMake(S_WIDTH * whichPage, 0.0f);
    }];
}

@end
