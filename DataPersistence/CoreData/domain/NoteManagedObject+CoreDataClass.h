//
//  NoteManagedObject+CoreDataClass.h
//  CoreData
//
//  Created by deng on 2020/6/13.
//  Copyright © 2020 professordeng. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

// 继承自 NSManagedObject，成为被 Core Data 栈管理的对象
@interface NoteManagedObject : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "NoteManagedObject+CoreDataProperties.h"
