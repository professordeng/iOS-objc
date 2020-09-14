//
//  NoteManagedObject+CoreDataProperties.h
//  CoreData
//
//  Created by deng on 2020/6/13.
//  Copyright © 2020 professordeng. All rights reserved.
//
//

#import "NoteManagedObject+CoreDataClass.h"

// 标志为 nonnull
NS_ASSUME_NONNULL_BEGIN

@interface NoteManagedObject (CoreDataProperties)

+ (NSFetchRequest<NoteManagedObject *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *date;
@property (nullable, nonatomic, copy) NSString *content;

@end

NS_ASSUME_NONNULL_END
