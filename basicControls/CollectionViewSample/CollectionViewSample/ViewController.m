//
//  ViewController.m
//  CollectionViewSample
//
//  Created by deng on 2020/6/2.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"
#import "EventCollectionViewCell.h"

// 集合视图列数，即：每一行有几个单元格
#define COL_NUM 3

// 集合视图需要实现相应的委托协议和数据源协议
@interface ViewController ()
    <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) NSArray *events;
@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 获取资源路径
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"events" ofType:@"plist"];
    
    // 获取属性列表文件中的全部数据
    self.events = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    // 调用 setupCollectionView
    [self setupCollectionView];
}

// 设置集合视图布局
- (void)setupCollectionView
{
    // 1. 创建流式布局，即从左到右从上到下布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 设置每个格子的尺寸，正方形
    layout.itemSize = CGSizeMake(80, 101);
    // 3. 设置整个 collectionView 的内边距
    layout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    // 重新设置 iPhone 6/6s/7/7s/Plus
    if (screenSize.height > 568) {
        layout.itemSize = CGSizeMake(100, 121);
        // 重新设置 collectionView 的内边距
        layout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
    }
    
    // 4. 设置单元格之间的间距最小为 5，这里是自动缩展的，因此单元格会对称分布
    layout.minimumLineSpacing = 5;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    
    // 设置可重用单元格标识与单元格类型，cellIdentifier 是标识符
    [self.collectionView registerClass:[EventCollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    
    // 背景颜色
    self.collectionView.backgroundColor = [UIColor yellowColor];
    
    
    // 将数据源对象和委托对象都设置为 ViewController
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.view addSubview:self.collectionView];
}

# pragma mark - UICollectionViewDataSource
// （数据源协议）返回节的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    int num = [self.events count] % COL_NUM;
    if (num == 0) {   // 整除
        return [self.events count] / COL_NUM;
    } else {
        return [self.events count] / COL_NUM + 1;
    }
}

// （数据源协议）返回节内单元格个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return COL_NUM;
}


// （数据源协议）返回集合视图的单元格，应该是根据前面两个协议来确定调用次数的
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    // indexPath 是复杂多维数组结构，常用属性有 section（节）和 row（节内索引）
    EventCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    // 计算 events 集合下标索引
    NSInteger idx = indexPath.section * COL_NUM + indexPath.row;
    
    if (self.events.count <= idx) { // 防止下标越界
        return cell;
    }
    
    // 设置好单元格并返回
    NSDictionary *event = self.events[idx];
    cell.label.text = event[@"name"];
    cell.imageView.image = [UIImage imageNamed:event[@"image"]];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
// （委托协议）点击单元格触发响应
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *event = self.events[indexPath.section * COL_NUM + indexPath.row];
    NSLog(@"select event name: %@", event[@"name"]);
}
                                      
@end
