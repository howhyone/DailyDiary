//
//  HYOCoding_NetAPIClient.m
//  HYOCoding
//
//  Created by mob on 2019/7/3.
//  Copyright © 2019 mob. All rights reserved.
//

#import "HYOCoding_NetAPIClient.h"

static NSString *const kBaseURLStr = @"http://9nv7fm.natappfree.cc";

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

            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                block(nil,error);
            }];
        }
            break;
        default:
            break;
    }
}

-(void)request_UserInquiry_WithPath:(NSString *)path Params:(id)params methord:(NetWorkMethord )methord andBlock:(void(^)(id data, NSError *error))block
{
    if (!path || !params) {
        return;
    }
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
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                block(nil,error);
            }];
        }
            break;
        default:
            break;
    }
}

-(void)request_UserEdit_WithPath:(NSString *)path Params:(id)params methord:(NetWorkMethord )methord andBlock:(void(^)(id data, NSError *error))block
{
    if (!path || !params) {
        return;
    }
    NSDictionary *paramDic = (NSDictionary *)params;
    NSString *phoneStr = paramDic[@"phone"];
    NSString *nameStr = paramDic[@"name"];
    UIImage *imageFile = paramDic[@"file"];

    
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
            [self POST:path parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                NSData *phoneData = [phoneStr dataUsingEncoding:NSUTF8StringEncoding];
                [formData appendPartWithFormData:phoneData name:@"phone"];
                NSData *nameData = [nameStr dataUsingEncoding:NSUTF8StringEncoding];
                [formData appendPartWithFormData:nameData name:@"name"];
                NSData *dataFile = UIImageJPEGRepresentation(imageFile, 1.0);
                [formData appendPartWithFileData:dataFile name:[NSString stringWithFormat:@"file"] fileName:[NSString stringWithFormat:@"header.png"] mimeType:@"image/JPG/png"];
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                block(responseObject,nil);

            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                block(nil,error);

            }];
        }
            break;
        default:
            break;
    }
}

-(void)request_EditDiray_WithPath:(NSString *)path Params:(id)params methord:(NetWorkMethord )methord andBlock:(void(^)(id data, NSError *error))block
{
    if (!path || !params) {
        return;
    }
    NSDictionary *paramsDic = (NSDictionary *)params;
    NSString *phoneStr = paramsDic[@"userId"];
    NSString *titleStr = paramsDic[@"title"];
    if (!titleStr || !phoneStr) {
        return;
    }
    NSData *phoneData = [phoneStr dataUsingEncoding:NSUTF8StringEncoding];
    NSData *titleData = [titleStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *dateStr = paramsDic[@"date"];
    NSData *dateData = [dateStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *contextStr = paramsDic[@"context"];
    NSData *contextData = [contextStr dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *imageArr = paramsDic[@"file"];
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
            [self POST:path parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                [formData appendPartWithFormData:phoneData name:@"userId"];
                [formData appendPartWithFormData:titleData name:@"title"];
                [formData appendPartWithFormData:dateData name:@"date"];
                [formData appendPartWithFormData:contextData name:@"context"];
                for (int i = 0; i < imageArr.count; i++) {
                    NSData *dataFile = [NSData data];
                    if ([imageArr[i] isKindOfClass:[NSString class]]) {
                        NSString *urlStr = imageArr[i];
                        dataFile = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
                    }else{
                        UIImage *imageFile = imageArr[i];
                        dataFile = [NSObject imageData:imageFile];
                    }
                    [formData appendPartWithFileData:dataFile name:[NSString stringWithFormat:@"file"] fileName:[NSString stringWithFormat:@"jjy%d.png",i] mimeType:@"image/JPG/PNG"];
                }
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                block(responseObject,nil);
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                block(nil,error);
                
            }];
        }
            break;
        default:
            break;
    }
}

-(void)request_ListDiary_WithPath:(NSString *)path Params:(id)params methord:(NetWorkMethord )methord andBlock:(void(^)(id data, NSError *error))block
{
    if (!path || !params) {
        return;
    }
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
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                block(nil,error);
            }];
        }
            break;
        default:
            break;
    }
}



-(void)request_DetailDiary_WithPath:(NSString *)path Params:(id)params methord:(NetWorkMethord )methord andBlock:(void(^)(id data, NSError *error))block
{
    if (!path || !params) {
        return;
    }
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
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                block(nil,error);
            }];
        }
            break;
        default:
            break;
    }
}

-(void)request_SearchDiary_WithPath:(NSString *)path Params:(id)params methord:(NetWorkMethord )methord andBlock:(void(^)(id data, NSError *error))block
{
    if (!path || !params) {
        return;
    }
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
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                block(nil,error);
            }];
        }
            break;
        default:
            break;
    }
}

-(void)request_PicturesList_WithPath:(NSString *)path Params:(id)params methord:(NetWorkMethord )methord andBlock:(void(^)(id data, NSError *error))block
{
    if (!path || !params) {
        return;
    }
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
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                block(nil,error);
            }];
        }
            break;
        default:
            break;
    }
}

@end
