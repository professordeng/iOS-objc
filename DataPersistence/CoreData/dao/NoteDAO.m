//
//  NoteDAO.m
//  CoreData
//
//  Created by deng on 2020/6/13.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "NoteDAO.h"
#import "NoteManagedObject+CoreDataProperties.h"

// 生命 NoteDAO 拓展
@interface NoteDAO ()

// NoteDAO 拓展中 DateFormatter 属性是私有的
@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation NoteDAO

static NoteDAO *sharedSingleton = nil;

+ (NoteDAO *)sharedInstance {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        sharedSingleton = [[self alloc] init];
        
        //初始化DateFormatter
        sharedSingleton.dateFormatter = [[NSDateFormatter alloc] init];
        [sharedSingleton.dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
    });
    return sharedSingleton;
}

// 插入 Note 方法
- (int)create:(Note *)model {
    
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    
    // 创建一个被管理的 Note 实体对象
    // insertNewObjectForEntityForName 执行插入操作
    NoteManagedObject *note = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:context];
    // 设置相应的属性值，可以用 KVC 方式
    note.date = model.date;
    note.content = model.content;
    
    // 保存数据，同步到持久数据文件中
    [self saveContext];
    
    return 0;
}

// 删除 Note 方法
- (int)remove:(Note *)model {
    //--- 根据 date 查询到要删除的笔记
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"date = %@", model.date];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *listData = [context executeFetchRequest:request error:&error];
    
    //--- 执行删除操作
    if (error == nil && [listData count] > 0) {
        NoteManagedObject *note = [listData lastObject];
        [context deleteObject:note];
        // 保存数据
        [self saveContext];
    }
    
    return 0;
}

// 修改 Note 方法
- (int)modify:(Note *)model {
    // --- 查询得到要修改的记录
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"date = %@", model.date];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *listData = [context executeFetchRequest:request error:&error];
    
    // --- 执行修改操作
    if (error == nil && [listData count] > 0) {
        NoteManagedObject *note = [listData lastObject];
        note.content = model.content;
        // 保存数据
        [self saveContext];
    }
    return 0;
}

// 查询所有数据方法（无条件查询）
- (NSMutableArray *)findAll {
    
    // 获取容器上下文
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    
    // NSEntityDescription 实体关联的描述类
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:context];
    
    // 数据提取请求类，用于查询
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    // 把实体描述设定到请求对象中
    fetchRequest.entity = entity;
    
    // 排序描述类，指定排序字段以及排序方式
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:TRUE];
    
    // 将排序描述对象赋值给请求对象
    NSArray *sortDescriptors = @[sortDescriptor];
    fetchRequest.sortDescriptors = sortDescriptors;
    
    // 根据请求对象执行查询，返回数组集合
    NSError *error = nil;
    NSArray *listData = [context executeFetchRequest:fetchRequest error:&error];
    
    if (error != nil) {
        return nil;
    }
    
    // 将 NoteManagedObject 转为 Note 然后返回
    NSMutableArray *resListData = [[NSMutableArray alloc] init];
    for (NoteManagedObject *mo in listData) {
        Note *note = [[Note alloc] initWithDate:mo.date content:mo.content];
        [resListData addObject:note];
    }
    
    return resListData;
}

// 按照主键查询数据方法（有条件查询）
- (Note *)findById:(Note *)model {
    
    // 得到上下文
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:context];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = entity;
    
    // NSPredicate 用来定义一个逻辑查询条件，可以过来集合对象
    fetchRequest.predicate = [NSPredicate predicateWithFormat: @"date = %@", model.date];
    
    NSError *error = nil;
    NSArray *listData = [context executeFetchRequest:fetchRequest error:&error];

    if (error == nil && [listData count] > 0) {
        NoteManagedObject *mo = [listData lastObject];
        Note *note = [[Note alloc] initWithDate:mo.date content:mo.content];
        return note;
    }
    return nil;
}

// 按关键词搜索
- (NSMutableArray *)searchByKeyword:(NSString *)keyword
{
    // 得到上下文
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:context];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = entity;
    
    // NSPredicate 用来定义一个逻辑查询条件，可以过来集合对象
    fetchRequest.predicate = [NSPredicate predicateWithFormat: @"content CONTAINS[c] %@", keyword];
    
    NSError *error = nil;
    NSArray *listData = [context executeFetchRequest:fetchRequest error:&error];

    if (error == nil && [listData count] > 0) {
        NSMutableArray *resList = [[NSMutableArray alloc] init];
        for (NoteManagedObject *mo in listData) {
            Note *note = [[Note alloc] initWithDate:mo.date content:mo.content];
            [resList addObject:note];
        }
        return resList;
    }
    return nil;
}

@end
