//
//  ViewController.m
//  CRC32
//
//  Created by deng on 2020/6/18.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"
#import "NSData+CRC32.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *str = @"aa";
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    int32_t checksum = [data crc32];
    NSLog(@"aa 的 32 位校验码是 %x", checksum);
}

@end
