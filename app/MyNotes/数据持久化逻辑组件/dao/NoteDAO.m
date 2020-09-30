//
//  NoteDAO.m
//  MyNotes
//
//  Created by deng on 2020/6/9.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "NoteDAO.h"
#import "sqlite3.h"

// 声明 NoteDAO 拓展
@interface NoteDAO ()
{
    sqlite3 *db;
}

// NoteDAO 扩展中沙箱目录中属性列表文件路径是私有的
@property(nonatomic, strong) NSString *plistFilePath;

@end

@implementation NoteDAO

static NoteDAO *sharedSingleton = nil;

+ (NoteDAO *)sharedInstance {
    static dispatch_once_t once;
    
    // 单例模式
    dispatch_once(&once, ^{

        sharedSingleton = [[self alloc] init];

        //初始化沙箱目录中属性列表文件路径
        sharedSingleton.plistFilePath = [sharedSingleton applicationDocumentsDirectoryFile];
        
        //初始化属性列表文件
        [sharedSingleton createEditableCopyOfDatabaseIfNeeded];

    });
    
    return sharedSingleton;
}

// 初始化数据库文件
- (void)createEditableCopyOfDatabaseIfNeeded {

    const char *cpath = [self.plistFilePath UTF8String];

    if (sqlite3_open(cpath, &db) != SQLITE_OK) {
        NSLog(@"数据库打开失败");
    } else {
        NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS Note (ctitle TEXT PRIMARY KEY, content TEXT);"];
        const char *cSql = [sql UTF8String];

        if (sqlite3_exec(db, cSql, NULL, NULL, NULL) != SQLITE_OK) {
            NSLog(@"建表失败");
        }
    }
    sqlite3_close(db);
}

- (NSString *)applicationDocumentsDirectoryFile {
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, TRUE) lastObject];
    NSString *path = [documentDirectory stringByAppendingPathComponent:@"NotesList.sqlite3"];
    NSLog(@"path = %@", path);
    return path;
}

// 插入 Note 方法
- (int)create:(Note *)model {

    const char *cpath = [self.plistFilePath UTF8String];

    if (sqlite3_open(cpath, &db) != SQLITE_OK) {
        NSLog(@"数据库打开失败");
    } else {
        NSString *sql = @"INSERT OR REPLACE INTO note (title, content) VALUES (?,?)";
        const char *cSql = [sql UTF8String];
        
        //语句对象
        sqlite3_stmt *statement;
        //预处理过程
        if (sqlite3_prepare_v2(db, cSql, -1, &statement, NULL) == SQLITE_OK) {

            const char *cTitle = [model.title UTF8String];

            const char *cContent = [model.content UTF8String];

            //绑定参数开始
            sqlite3_bind_text(statement, 1, cTitle, -1, NULL);
            sqlite3_bind_text(statement, 2, cContent, -1, NULL);

            //执行插入数据
            if (sqlite3_step(statement) != SQLITE_DONE) {
                NSLog(@"插入数据失败");
            }
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(db);
    return 0;
}

// 删除 Note 方法
- (int)remove:(Note *)model {

    const char *cpath = [self.plistFilePath UTF8String];

    if (sqlite3_open(cpath, &db) != SQLITE_OK) {
        NSLog(@"数据库打开失败");
    } else {
        NSString *sql = @"DELETE  from note where title =?";
        const char *cSql = [sql UTF8String];

        // 语句对象
        sqlite3_stmt *statement;
        
        // 预处理过程
        if (sqlite3_prepare_v2(db, cSql, -1, &statement, NULL) == SQLITE_OK) {

            const char *cTitle = [model.title UTF8String];

            //绑定参数开始
            sqlite3_bind_text(statement, 1, cTitle, -1, NULL);
            //执行删除数据
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

    const char *cpath = [self.plistFilePath UTF8String];

    if (sqlite3_open(cpath, &db) != SQLITE_OK) {
        NSLog(@"数据库打开失败");
    } else {

        NSString *sql = @"UPDATE note set content=? where ctitle =?";
        const char *cSql = [sql UTF8String];

        // 语句对象
        sqlite3_stmt *statement;
        // 预处理过程
        if (sqlite3_prepare_v2(db, cSql, -1, &statement, NULL) == SQLITE_OK) {

            const char *cTitle = [model.title UTF8String];

            const char *cContent = [model.content UTF8String];

            // 绑定参数开始
            sqlite3_bind_text(statement, 1, cContent, -1, NULL);
            sqlite3_bind_text(statement, 2, cTitle, -1, NULL);
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

    const char *cpath = [self.plistFilePath UTF8String];
    
    NSMutableArray *listData = [[NSMutableArray alloc] init];
    
    if (sqlite3_open(cpath, &db) != SQLITE_OK) {
        NSLog(@"数据库打开失败");
    } else {

        NSString *sql = @"SELECT ctitle,content FROM Note";
        const char *cSql = [sql UTF8String];

         //语句对象
        sqlite3_stmt *statement;
        //预处理过程
        if (sqlite3_prepare_v2(db, cSql, -1, &statement, NULL) == SQLITE_OK) {
            
            //执行查询
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char *bufTitle = (char *) sqlite3_column_text(statement, 0);
                NSString *strTitle = [[NSString alloc] initWithUTF8String:bufTitle];

                char *bufContent = (char *) sqlite3_column_text(statement, 1);
                NSString *strContent = [[NSString alloc] initWithUTF8String:bufContent];

                Note *note = [[Note alloc] initWithTitle:strTitle content:strContent];

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

    const char *cpath = [self.plistFilePath UTF8String];

    if (sqlite3_open(cpath, &db) != SQLITE_OK) {
        NSLog(@"数据库打开失败");
    } else {
        NSString *sql = @"SELECT ctitle,content FROM Note where ctitle =?";
        const char *cSql = [sql UTF8String];

        // 语句对象
        sqlite3_stmt *statement;
        // 预处理过程
        if (sqlite3_prepare_v2(db, cSql, -1, &statement, NULL) == SQLITE_OK) {
            // 准备参数
            const char *cTitle = [model.title UTF8String];

            // 绑定参数开始
            sqlite3_bind_text(statement, 1, cTitle, -1, NULL);

            // 执行查询
            if (sqlite3_step(statement) == SQLITE_ROW) {

                char *bufTitle = (char *) sqlite3_column_text(statement, 0);
                NSString *strTitle = [[NSString alloc] initWithUTF8String:bufTitle];

                char *bufContent = (char *) sqlite3_column_text(statement, 1);
                NSString *strContent = [[NSString alloc] initWithUTF8String:bufContent];

                Note *note = [[Note alloc] initWithTitle:strTitle content:strContent];

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
