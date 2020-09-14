//
//  NoteDAO.m
//  sqlite
//
//  Created by deng on 2020/6/13.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "NoteDAO.h"
#import "sqlite3.h"

// 声明 NoteDAO 拓展
@interface NoteDAO ()
{
    // 数据库也是一个对象
    sqlite3 *db;
}

// NoteDAO 拓展中 DateFormatter 属性是私有的
@property (strong, nonatomic) NSDateFormatter *dateFormatter;

// NoteDAO 拓展中沙箱目录的数据库路径是私有的
@property (strong, nonatomic) NSString *dbPath;

@end

@implementation NoteDAO

static NoteDAO *sharedSingleton = nil;

+ (NoteDAO *)sharedInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedSingleton = [[self alloc] init];
        
        // 初始化沙箱目录中数据库路径
        sharedSingleton.dbPath = [sharedSingleton applicationDocumentsDirectoryFile];
        
        // 初始化 DateFormatter
        sharedSingleton.dateFormatter = [[NSDateFormatter alloc] init];
        [sharedSingleton.dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        // 初始化数据库
        [sharedSingleton createEditableCopyOfDatabaseIfNeeded];
    });
    return sharedSingleton;
}

- (NSString *)applicationDocumentsDirectoryFile
{
    // 找到路径列表的最后一个元素
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, TRUE) lastObject];
    
    // 在元素后面插入一个新的路径，也就是数据库路径
    NSString *path = [documentDirectory stringByAppendingPathComponent:@"NotesList.sqlite3"];
    NSLog(@"path = %@", path);
    return path;
}

// 初始化数据库
- (void)createEditableCopyOfDatabaseIfNeeded
{
    const char *cpath = [self.dbPath UTF8String];

    if (sqlite3_open(cpath, &db) != SQLITE_OK) {
        NSLog(@"数据库打开失败");
    } else {
        // 表 Note 不存在时创建；否则不创建
        NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS Note (cdate TEXT PRIMARY KEY, content TEXT);"];
        const char *cSql = [sql UTF8String];
        
        // 使用 sqlite3_exec 函数创建数据库表
        if (sqlite3_exec(db, cSql, NULL, NULL, NULL) != SQLITE_OK) {
            NSLog(@"建表失败");
        }
    }
    // 执行完 SQL 语句都应该及时关闭数据库，释放资源
    sqlite3_close(db);
}

// 插入 Note 方法
- (int)create:(Note *)model
{

    const char *cpath = [self.dbPath UTF8String];

    if (sqlite3_open(cpath, &db) != SQLITE_OK) {
        NSLog(@"数据库打开失败");
    } else {
        // (?, ?) 是需要绑定的参数，在后面会用 sqlite3_bind_text 绑定
        NSString *sql = @"INSERT OR REPLACE INTO note (cdate, content) VALUES (?,?)";
        const char *cSql = [sql UTF8String];
        
        // 语句对象
        sqlite3_stmt *statement;
        // 预处理过程，sqlite3_prepare_v2 将 SQL 编译成二进制代码，提高 SQL 语句的执行速度
        if (sqlite3_prepare_v2(db, cSql, -1, &statement, NULL) == SQLITE_OK) {

            NSString *strDate = [self.dateFormatter stringFromDate:model.date];
            const char *cDate = [strDate UTF8String];

            const char *cContent = [model.content UTF8String];

            // 绑定参数开始
            sqlite3_bind_text(statement, 1, cDate, -1, NULL);
            sqlite3_bind_text(statement, 2, cContent, -1, NULL);

            // 执行插入动作，遍历结果集
            if (sqlite3_step(statement) != SQLITE_DONE) {
                NSLog(@"插入数据失败");
            }
        }
        // 释放语句对象 statement
        sqlite3_finalize(statement);
    }
    // 关闭数据库
    sqlite3_close(db);
    return 0;
}

// 删除 Note 方法
- (int)remove:(Note *)model {

    const char *cpath = [self.dbPath UTF8String];

    if (sqlite3_open(cpath, &db) != SQLITE_OK) {
        NSLog(@"数据库打开失败");
    } else {
        NSString *sql = @"DELETE  from note where cdate =?";
        const char *cSql = [sql UTF8String];

        // 语句对象
        sqlite3_stmt *statement;
        // 预处理过程
        if (sqlite3_prepare_v2(db, cSql, -1, &statement, NULL) == SQLITE_OK) {

            NSString *strDate = [self.dateFormatter stringFromDate:model.date];
            const char *cDate = [strDate UTF8String];

            // 绑定参数开始
            sqlite3_bind_text(statement, 1, cDate, -1, NULL);
            // 执行删除数据
            if (sqlite3_step(statement) != SQLITE_DONE) {
                NSLog(@"删除数据失败");
            }
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(db);
    return 0;
}

// 修改 Note 方法
- (int)modify:(Note *)model {

    const char *cpath = [self.dbPath UTF8String];

    if (sqlite3_open(cpath, &db) != SQLITE_OK) {
        NSLog(@"数据库打开失败");
    } else {

        NSString *sql = @"UPDATE note set content=? where cdate =?";
        const char *cSql = [sql UTF8String];

        // 语句对象
        sqlite3_stmt *statement;
        // 预处理过程
        if (sqlite3_prepare_v2(db, cSql, -1, &statement, NULL) == SQLITE_OK) {

            NSString *strDate = [self.dateFormatter stringFromDate:model.date];
            const char *cDate = [strDate UTF8String];

            const char *cContent = [model.content UTF8String];

            // 绑定参数开始
            sqlite3_bind_text(statement, 1, cContent, -1, NULL);
            sqlite3_bind_text(statement, 2, cDate, -1, NULL);
            // 执行
            if (sqlite3_step(statement) != SQLITE_DONE) {
                NSLog(@"修改数据失败");
            }
        }

        sqlite3_finalize(statement);

    }
    sqlite3_close(db);
    return 0;
}

// 查询所有数据方法
- (NSMutableArray *)findAll {

    const char *cpath = [self.dbPath UTF8String];
    
    NSMutableArray *listData = [[NSMutableArray alloc] init];
    
    if (sqlite3_open(cpath, &db) != SQLITE_OK) {
        NSLog(@"数据库打开失败");
    } else {

        NSString *sql = @"SELECT cdate,content FROM Note";
        const char *cSql = [sql UTF8String];

        // 语句对象
        sqlite3_stmt *statement;
        // 预处理过程
        if (sqlite3_prepare_v2(db, cSql, -1, &statement, NULL) == SQLITE_OK) {
            
            // 执行查询
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char *bufDate = (char *) sqlite3_column_text(statement, 0);
                NSString *strDate = [[NSString alloc] initWithUTF8String:bufDate];
                NSDate *date = [self.dateFormatter dateFromString:strDate];

                char *bufContent = (char *) sqlite3_column_text(statement, 1);
                NSString *strContent = [[NSString alloc] initWithUTF8String:bufContent];

                Note *note = [[Note alloc] initWithDate:date content:strContent];

                [listData addObject:note];
            }
            
            sqlite3_finalize(statement);
            sqlite3_close(db);
            
            return listData;
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(db);
    return listData;
}

// 按照主键查询数据方法
- (Note *)findById:(Note *)model {

    const char *cpath = [self.dbPath UTF8String];

    if (sqlite3_open(cpath, &db) != SQLITE_OK) {
        NSLog(@"数据库打开失败");
    } else {
        NSString *sql = @"SELECT cdate,content FROM Note where cdate =?";
        const char *cSql = [sql UTF8String];

        // 语句对象
        sqlite3_stmt *statement;
        // 预处理过程
        if (sqlite3_prepare_v2(db, cSql, -1, &statement, NULL) == SQLITE_OK) {
            // 准备参数
            NSString *strDate = [self.dateFormatter stringFromDate:model.date];
            const char *cDate = [strDate UTF8String];

            // 绑定参数开始
            sqlite3_bind_text(statement, 1, cDate, -1, NULL);

            // 执行查询
            if (sqlite3_step(statement) == SQLITE_ROW) {

                char *bufDate = (char *) sqlite3_column_text(statement, 0);
                NSString *strDate = [[NSString alloc] initWithUTF8String:bufDate];
                NSDate *date = [self.dateFormatter dateFromString:strDate];

                char *bufContent = (char *) sqlite3_column_text(statement, 1);
                NSString *strContent = [[NSString alloc] initWithUTF8String:bufContent];

                Note *note = [[Note alloc] initWithDate:date content:strContent];

                sqlite3_finalize(statement);
                sqlite3_close(db);

                return note;
            }
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(db);
    return nil;
}


@end
