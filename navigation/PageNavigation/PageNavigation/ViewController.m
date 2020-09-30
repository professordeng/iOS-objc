//
//  ViewController.m
//  PageNavigation
//
//  Created by deng on 2020/6/4.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"

// 翻页的方向
enum DirectionForward
{
    ForwardBefore = 1 //向前
    ,ForwardAfter =2  //向后
};

@interface ViewController ()
    <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

{
    // 当前 Page 的索引
    int pageIndex;
    // 翻页的方向变量
    int directionForward;
}

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *viewControllers;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 当前 Page 的索引
    pageIndex = 0;
    // 翻页的方向变量
    directionForward = ForwardAfter;
    
    UIViewController *page1ViewController = [[UIViewController alloc] init];
    UIViewController *page2ViewController = [[UIViewController alloc] init];
    UIViewController *page3ViewController = [[UIViewController alloc] init];
       
    // 将 3 个视图控制器 UIViewController 实例添加到数组中
    self.viewControllers = @[page1ViewController, page2ViewController, page3ViewController];
       
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:self.view.frame];
    imageView1.image = [UIImage imageNamed:@"达芬奇-蒙娜丽莎.png"];
    [page1ViewController.view addSubview:imageView1];
       
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:self.view.frame];
    imageView2.image = [UIImage imageNamed:@"罗丹-思想者.png"];
    [page2ViewController.view addSubview:imageView2];
    
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:self.view.frame];
    imageView3.image = [UIImage imageNamed:@"保罗克利-肖像.png"];
    [page3ViewController.view addSubview:imageView3];
       
    // 设置 UIPageViewController 控制器
    // TransitionStyle 为页面翻转的样式
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
        navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
       
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
       
    // 设置首页
    // direction 为翻页方向
    [self.pageViewController setViewControllers:@[page1ViewController]
                                         direction:UIPageViewControllerNavigationDirectionForward animated:TRUE completion:nil];
       
    [self.view addSubview:self.pageViewController.view];
}


#pragma mark - 实现 UIPageViewControllerDataSource 协议
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    pageIndex--;
    
    if (pageIndex < 0){
        pageIndex = 0;
        return nil;
    }
    
    directionForward = ForwardBefore;
    return self.viewControllers[pageIndex];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    pageIndex++;
    
    if (pageIndex > 2){
        pageIndex = 2;
        return nil;
    }
    
    directionForward = ForwardAfter;
    return self.viewControllers[pageIndex];
}

#pragma mark - 实现 UIPageViewControllerDelegate 协议
// 设置是否双面显示以及书脊的位置
- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation {
    self.pageViewController.doubleSided = FALSE;
    // Min 表示只显示一个
    return UIPageViewControllerSpineLocationMin;
}

// 判断用户是否成功翻到了下一页，如果只是翻了一点点，然后又放弃翻页，我们可以通过 completed 来判断是否进行了翻页
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (!completed) {
        if (directionForward == ForwardAfter) {
            pageIndex--;
        }
        if (directionForward == ForwardBefore) {
            pageIndex++;
        }
    }
}

@end
