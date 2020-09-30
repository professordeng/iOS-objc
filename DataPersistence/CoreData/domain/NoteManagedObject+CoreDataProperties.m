//
//  NoteManagedObject+CoreDataProperties.m
//  CoreData
//
//  Created by deng on 2020/6/13.
//  Copyright © 2020 professordeng. All rights reserved.
//
//

#import "NoteManagedObject+CoreDataProperties.h"

@implementation NoteManagedObject (CoreDataProperties)

+ (NSFetchRequest<NoteManagedObject *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Note"];
}

// 在 objc 分类中声明的属性是动态的
// 访问属性存取方法（getter 和 setter）会在运行时由 Core Data 动态创建
@dynamic date;
@dynamic content;

@end
