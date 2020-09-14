//
//  ViewController.m
//  SwitchSliderSegmentedControl
//
//  Created by deng on 2020/6/10.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *leftSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *rightSwitch;
@property (weak, nonatomic) IBOutlet UILabel *sliderValue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// 开关控件的响应事件
- (IBAction)switchValueChanged:(id)sender {
    UISwitch *witchSwitch = (UISwitch *)sender;
    BOOL setting = witchSwitch.isOn;
    [self.leftSwitch setOn:setting animated:TRUE];
    [self.rightSwitch setOn:setting animated:TRUE];
}


// 分段控件的响应事件
- (IBAction)touchDown:(id)sender {
    // id 是指针类型，可指向任何对象，必要时进行强制转换
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    
    // 分段控件通过索引找到相应的段
    NSLog(@"选择的段 : %li", segmentedControl.selectedSegmentIndex);
    
    if (self.leftSwitch.hidden) {
        self.rightSwitch.hidden = FALSE;
        self.leftSwitch.hidden = FALSE;
    } else {
        self.leftSwitch.hidden = TRUE;
        self.rightSwitch.hidden = TRUE;
    }
}

// 滑块控件的响应事件
- (IBAction)sliderValueChange:(id)sender {
    UISlider *slider = (UISlider *)sender;
    int progressAsInt = (int)(slider.value);
    NSString *newText = [[NSString alloc] initWithFormat:@"%d", progressAsInt];
    self.sliderValue.text = newText;
}

@end
