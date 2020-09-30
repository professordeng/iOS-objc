//
//  ViewController.m
//  ScreenTest
//
//  Created by deng on 2020/6/3.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// 故事板已有拥有权
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 获取屏幕大小
    CGSize iOSDeviceScreenSize = [UIScreen mainScreen].bounds.size;
    
    NSString *s = [NSString stringWithFormat:@"%.0f x %.0f", iOSDeviceScreenSize.width, iOSDeviceScreenSize.height];
    NSLog(@"%@", s);
    
    self.label.text = s;
    
    // 判断是否为 iPhone 设备
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        if (iOSDeviceScreenSize.height > iOSDeviceScreenSize.width) { // 竖屏情况
            if (iOSDeviceScreenSize.height == 568) { // iPhone 5/5s/5c/SE 设备
                NSLog(@"iPhone 5/5s/5c/SE 设备");
            } else if (iOSDeviceScreenSize.height == 667) { // iPhone 6/6s/7
                NSLog(@"iPhone 6/6s/7 设备");
            } else if ( iOSDeviceScreenSize.height == 736) {  // iPhone Plus
                NSLog(@"iPhone Plus 设备");
            } else {
                NSLog(@"其他设备");
            }
        }
        if (iOSDeviceScreenSize.width > iOSDeviceScreenSize.height) { // 横屏情况
            if (iOSDeviceScreenSize.width == 568) {  // iPhone 5/5s/5c/SE 设备
                NSLog(@"iPhone 5/5s/5c/SE 设备");
            } else if (iOSDeviceScreenSize.width == 667) { // iPhone 6/6s/7
                NSLog(@"iPhone 6/6s/7 设备");
            } else if (iOSDeviceScreenSize.width == 736) { // iPhone Plus
                NSLog(@"iPhone Plus 设备");
            } else { // 其他设备
                NSLog(@"其他设备");
            }
        }
    }
}


@end
