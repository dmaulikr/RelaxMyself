//
//  PFReadDataCacheTool.m
//  RelaxMyself
//
//  Created by 周坤磊 on 16/1/21.
//  Copyright © 2016年 周坤磊. All rights reserved.
//


#import "PFReadDataCacheTool.h"
#import "PFReadDataModel.h"


@implementation PFReadDataCacheTool

static FMDatabaseQueue *_queue;

+ (void)initialize
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"data.sqlite"];
    
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    // 建表
    [_queue inDatabase:^(FMDatabase *db) {
        BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS read (ID integer PRIMARY KEY AUTOINCREMENT, data blob, idstr text)"];
        if (!result) {
            PFLog(@"建表失败");
        }else{
            PFLog(@"建表成功");
        }
    }];
    
}


+ (void)saveDataWithArr:(NSArray *)arr idstr:(NSString *)idstr
{
    [self deleteWithIdstr:idstr];
    
    for (PFReadDataModel *model in arr) {
        [self saveDataWithModel:model idstr:idstr];
    }
}

+ (void)saveDataWithModel:(PFReadDataModel *)model idstr:(NSString *)idstr
{
    [_queue inDatabase:^(FMDatabase *db) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
        [db executeUpdate:@"INSERT INTO read(data,idstr) VALUES(?,?)",data,idstr];
    }];
}
+ (NSArray *)dataWithIdstr:(NSString *)idstr
{
    __block NSMutableArray *arr = [NSMutableArray array];
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *result = [db executeQuery:@"SELECT * FROM read WHERE idstr = ?",idstr];
        if (result) {
            while ([result next]) {
                NSData *data = [result dataForColumn:@"data"];
                PFReadDataModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                [arr addObject:model];
            }
        }
    }];
    return arr;
}

+ (void)deleteWithIdstr:(NSString *)idstr
{
    [_queue inDatabase:^(FMDatabase *db) {
        BOOL result = [db executeUpdate:@"DELETE FROM read WHERE idstr = ?",idstr];
        if (!result) {
            PFLog(@"删除失败");
        }
    }];
}

@end
