//
//  AppDelegate.h
//  UIButton
//
//  Created by deng on 2020/5/30.
//  Copyright © 2020 professordeng. All rights reserved.
//

// AppDelegate 是应用程序托管对象，继承了 UIResponder 类，并实现了 UIApplicationDelegate 委托协议
// UIResponder 类可以使子类 AppDelegate 具有处理响应事件的能力
// UIApplicationDelegate 委托协议使 AppDelegate 能够成为应用程序委托对象，能够响应应用程序的生命周期
// AppDelegate 类中继承的一系列方法在应用生命周期的不同阶段会被调用

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>


@end

