//
//  HYOCoding_NetAPIClient.m
//  HYOCoding
//
//  Created by mob on 2019/7/3.
//  Copyright © 2019 mob. All rights reserved.
//

#import "HYOCoding_NetAPIClient.h"

static NSString *const kBaseURLStr = @"http://6ypi2h.natappfree.cc";

@implementation HYOCoding_NetAPIClient

static  HYOCoding_NetAPIClient *clienOnce = nil;


+(HYOCoding_NetAPIClient *)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        clienOnce = [[HYOCoding_NetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:[NSObject getBaseUrl]]];

        clienOnce = [[HYOCoding_NetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:kBaseURLStr]];
    });
    return clienOnce;
}

-(void)requestJsonDataWithPath:(NSString *)aPath withParams:(NSDictionary *)params withMethodType:(NetWorkMethord)method andBlock:(void (^)(id _Nonnull, NSError * _Nonnull))block
{
    [self requestJsonDataWithPath:aPath withParams:params withMethodType:method autoShowError:nil andBlock:block];
}

-(void)requestJsonDataWithPath:(NSString *)aPath withParams:(NSDictionary *)params withMethodType:(NetWorkMethord)method autoShowError:(BOOL)autoShowError andBlock:(void (^)(id _Nonnull, NSError * _Nonnull))block
{
    if (!aPath || aPath.length <= 0) {
        return;
    }
    //CSRF - 跨站请求伪造
    NSHTTPCookie *_CSRF = nil;
    for (NSHTTPCookie *tempC in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
        if ([tempC.name isEqualToString:@"XSRF-TOKEN"]) {
            _CSRF = tempC;
        }
    }
    if (_CSRF) {
        [self.requestSerializer setValue:_CSRF.value forHTTPHeaderField:@"X-XSRF-TOKEN"];
    }
//    log请求数据
    DebugLog(@"\n===========request======method=====\n%uaPath========\n%@params=======\n%@", method, aPath, params);

    aPath = [aPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//卧槽了，有些把 params 放在 path 里面的 GET 方法
    switch (method) {
        case GET:
//            NSMutableString *localPath = [aPath]
            break;
            
        default:
            break;
    }
}




-(void)request_Login_WithPath:(NSString *)path Params:(id)params methord:(NetWorkMethord)methord andBlock:(void(^)(id data, NSError *error))block
{
    if (!path || !params) {
        return;
    }
//  CSRF   ----  跨站请求伪造
//    NSHTTPCookie *_CSRF = nil;
//    for (NSHTTPCookie *tempC in [NSHTTPCookieStorage sharedHTTPCookieStorage].cookies) {
//        if ([tempC.name isEqualToString:@"XSRF-TOKEN"]) {
//            _CSRF = tempC;
//        }
//    }
//    if (_CSRF) {
//        [self.requestSerializer setValue:_CSRF.value forKey:@"X-XSRF-TOKEN"];
//    }
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    switch (methord) {
        case GET:
        {
            [self GET:path parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                block(responseObject,nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                block(nil,error);
            }];
        }
            break;
        case POST:
        {
            [self POST:path parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                block(responseObject,nil);
                NSLog(@"dataDic =========== $%@",responseObject);

            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                block(nil,error);
                NSLog(@"error is==========+%@",error);

            }];
        }
            break;
        default:
            break;
    }
}

-(void)request_ProjectCont_WithPath:(NSString *)path Params:(id)params methord:(NetWorkMethord )methord andBlock:(void(^)(id data, NSError *error))block
{
    
}

@end
