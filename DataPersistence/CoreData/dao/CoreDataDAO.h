//
//  CoreDataDAO.h
//  CoreData
//
//  Created by deng on 2020/6/13.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataDAO : NSObject

// 返回持久化存储容器
@property (strong, readonly) NSPersistentContainer *persistentContainer;

// 保存数据
- (void)saveContext;

@end

NS_ASSUME_NONNULL_END
