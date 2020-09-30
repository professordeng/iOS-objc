//
//  ViewController.m
//  PickerViewSample
//
//  Created by deng on 2020/6/10.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"

// 普通选择器需要实现委托协议和数据源协议
@interface ViewController ()
    <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (strong, nonatomic) NSDictionary *pickerData;     // 保存全部数据
@property (strong, nonatomic) NSArray *pickerProvincesData; // 当前的省数据
@property (strong, nonatomic) NSArray *pickerCitiesData;    // 当前省下面的市数据

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"provinces_cities" ofType:@"plist"];
    
    // 获取属性列表文件中的全部数据
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    self.pickerData = dict;
    
    // 省份名数据
    self.pickerProvincesData = [self.pickerData allKeys];
    
    // 默认取出第一个省的所有市的数据
    NSString *selectedProvince = [self.pickerProvincesData objectAtIndex:0];
    self.pickerCitiesData = [self.pickerData objectForKey:selectedProvince];
}

- (IBAction)onclick:(id)sender {
    // 获取当前选择器中不同拨盘的索引，Component 就是指拨盘
    NSInteger row1 = [self.pickerView selectedRowInComponent:0];
    NSInteger row2 = [self.pickerView selectedRowInComponent:1];
    
    // 根据索引将拨盘显示的数据读取出来
    NSString *selected1 = [self.pickerProvincesData objectAtIndex:row1];
    NSString *selected2 = [self.pickerProvincesData objectAtIndex:row2];
    
    NSString *title = [[NSString alloc] initWithFormat:@"%@, %@市", selected1, selected2];
    
    self.label.text = title;
}

#pragma mark - 实现 UIPickerViewDataSource 协议
// 2 个拨轮（省，市）
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

// 每个拨轮中的选择数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) { // 第一个拨轮表示省份
        return [self.pickerProvincesData count];
    } else {  // 第二个拨轮表示城市
        return [self.pickerCitiesData count];
    }
}

#pragma mark - 实现 UIPickerViewDelegate 协议
// 为拨轮提供显示的数据
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return [self.pickerProvincesData objectAtIndex:row];
    } else {
        return [self.pickerCitiesData objectAtIndex:row];
    }
}

// 选中选择器的某个拨轮中的某行时调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // 省份发生变化时，需要重新加载城市列表
    if (component == 0) {
        NSString *selectedProvince = [self.pickerProvincesData objectAtIndex:row];
        NSArray *array = [self.pickerData objectForKey:selectedProvince];
        self.pickerCitiesData = array;
        [self.pickerView reloadComponent:1];
    }
}

@end
