//
//  CoreDataDAO.m
//  CoreData
//
//  Created by deng on 2020/6/13.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "CoreDataDAO.h"

@implementation CoreDataDAO

// 持久化容器，用来简化之前的 Core Data 栈创建过程
@synthesize persistentContainer = _persistentContainer;

#pragma mark - Core Data 堆栈
// 返回持久化存储容器
- (NSPersistentContainer *)persistentContainer
{
    @synchronized (self) {
        if (_persistentContainer == nil) {
            
            // 创建容器对象，CoreData 就是容器的名字
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"CoreData"];
            
            // NSPersistentStoreDescription 是用来描述配置信息的类
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    NSLog(@"持久化存储容器错误：%@", error.localizedDescription);
                    abort();
                }
            }];
        }
    }
    return _persistentContainer;
}

#pragma mark - 保存数据
- (void)saveContext
{
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    // 执行保存操作
    if ([context hasChanges] && ![context save:&error]) {
        NSLog(@"数据保存错误：%@", error.localizedDescription);
        abort();
    }
}

@end
