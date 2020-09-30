//
//  NavigationController.m
//  CustomSearchBar
//
//  Created by deng on 2020/7/14.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()


@end

@implementation NavigationController

- (void)dealloc {
    NSLog(@"__%@__dealloc__", self.class);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 去除黑线
    self.navigationBar.shadowImage = [UIImage new];
    self.navigationBar.barTintColor =  [self colorWithHexString:@"#ecedee" alpha:1.0];
    self.navigationBar.tintColor = [self colorWithHexString:@"#36B59D" alpha:1.0];
}

- (UIColor *)colorWithHexString:(NSString *)hexColor alpha:(float)opacity {
    // 预处理十六进制颜色值，去除空格和换行后转大写
    NSString * colorStr = [[hexColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([colorStr length] < 6) return [UIColor blackColor];

    // strip 0X if it appears
    if ([colorStr hasPrefix:@"0X"]) colorStr = [colorStr substringFromIndex:2];
    if ([colorStr hasPrefix:@"#"]) colorStr = [colorStr substringFromIndex:1];

    if ([colorStr length] != 6) return [UIColor blackColor];

    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString * rString = [colorStr substringWithRange:range];

    range.location = 2;
    NSString * gString = [colorStr substringWithRange:range];

    range.location = 4;
    NSString * bString = [colorStr substringWithRange:range];

    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];

    return [UIColor colorWithRed:((float)r / 255.0f)
                           green:((float)g / 255.0f)
                            blue:((float)b / 255.0f)
                           alpha:opacity];
}

@end
