//
//  PFReadHttpTool.m
//  简
//
//  Created by 周坤磊 on 16/1/21.
//  Copyright © 2016年 周坤磊. All rights reserved.
//

#import "PFReadHttpTool.h"
#import "PFHttpTool.h"
#import "MJExtension.h"

@implementation PFReadHttpTool

+ (void)readDetailWithParameter:(PFReadHeaderAticleRequest *)parame success:(void(^)(PFArticleModel *result))success failure:(void(^)(NSError *error))failure
{
    [self POST:@"http://api2.pianke.me/article/info" parameters:parame resultClass:[PFArticleModel class] success:success failure:failure];
}

+ (void)readDetailWithParameterSuccess:(void(^)(PFReadDataModel *result))success failure:(void(^)(NSError *error))failure
{
    [self GET:@"http://api2.pianke.me/read/columns?client=2" parameters:nil resultClass:[PFReadDataModel class] success:success failure:failure];
}

+ (void)readDetailListWithUrl:(NSString *)url parameter:(PFReadDetailRequest *)parame success:(void(^)(PFReadDetailModel *result))success failure:(void(^)(NSError *error))failure
{
    
    [self POST:url parameters:parame resultClass:[PFReadDetailModel class] success:success failure:failure];
}

@end
