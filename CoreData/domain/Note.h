//
//  Note.h
//  CoreData
//
//  Created by deng on 2020/6/13.
//  Copyright © 2020 professordeng. All rights reserved.
//

// 注意区分 Note 类和 NoteManageObject 类
// Note 类可在控制器层使用
// 而 NoteManageObject 必须限制在持久层中
// 在持久层中将 Core Data 栈查询出的 NoteManageObject 数据转换为 Note 对象，返回表示层和业务逻辑层

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Note : NSObject 

@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSString *content;

- (instancetype)initWithDate:(NSDate *)date content:(NSString *)content;

- (instancetype)init;

@end

NS_ASSUME_NONNULL_END
