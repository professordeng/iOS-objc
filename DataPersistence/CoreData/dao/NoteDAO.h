//
//  NoteDAO.h
//  CoreData
//
//  Created by deng on 2020/6/13.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Note.h"
#import "CoreDataDAO.h"

NS_ASSUME_NONNULL_BEGIN

@interface NoteDAO : CoreDataDAO

+ (NoteDAO *)sharedInstance;

// 插入 Note 方法
- (int)create:(Note *)model;

// 删除 Note 方法
- (int)remove:(Note *)model;

// 修改 Note 方法
- (int)modify:(Note *)model;

// 查询所有数据方法
- (NSMutableArray *)findAll;

// 按照主键查询数据方法
- (Note *)findById:(Note *)model;

// 按照关键词查询数据方法
- (NSMutableArray *)searchByKeyword:(NSString *)keyword;

@end

NS_ASSUME_NONNULL_END
