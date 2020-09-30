//
//  AppDelegate.m
//  UIButton
//
//  Created by deng on 2020/5/30.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

// 启动工程后，首先会调用该方法
// 应用启动并进行初始化时会调用 application didFinishLaunchingWithOptions 发出 UIApplicationDidFinishLaunchingNotification 通知。这个阶段会初始化视图控制器（17）
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSLog(@"%@", @"application:didFinishLaunchingWithOptions:");
        
    return YES;
}

// 应用从活动状态进入到非活动状态时调用该方法并发出通知
// 这个阶段可以保存 UI 到状态（例如游戏状态等）
- (void)applicationWillResignActive:(UIApplication *)application
{
    NSLog(@"%@", @"applicationWillResignActive:");
}

// 应用进入后台时调用该方法并发出通知
// 这个阶段可以保存用户数据，释放一些资源（例如释放数据库资源等）
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSLog(@"%@", @"applicationDidEnterBackground:");
}

// 应用进入到前台，但是还没有处于活动状态时调用该方法并发出通知
// 这个状态可以恢复用户数据
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSLog(@"%@",@"applicationWillEnterForeground:");
}

// 应用进入前台并处于活动状态时调用该方法并发出通知
// 该阶段可以恢复 UI 的状态（例如游戏状态等）
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"%@", @"applicationDidBecomeActive");
}

// 应用被终止时调用该方法并发出通知，但内存清楚时除外
// 这个阶段释放一些资源，也可以保存用户数据
- (void)applicationWillTerminate:(UIApplication *)application
{
    NSLog(@"%@", @"applicationWillTerminate:");
}

#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

@end
