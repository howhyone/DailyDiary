//
//  HYOCoding_NetAPIManager.m
//  HYOCoding
//
//  Created by mob on 2019/5/21.
//  Copyright © 2019 mob. All rights reserved.
//

#import "HYOCoding_NetAPIManager.h"
#import "HYOCoding_NetAPIClient.h"


@implementation HYOCoding_NetAPIManager


+(instancetype)sharedManager
{
    static HYOCoding_NetAPIManager *shared_manager = nil;
    static dispatch_once_t shared_Token;
    dispatch_once(&shared_Token, ^{
        shared_manager = [[self alloc] init];
    });
    return shared_manager;
}


-(void)request_VerifyLogin_WithPath:(NSString *)path Params:(id)params andBlock:(void (^)(id data, NSError * error))block
{
    HYOCoding_NetAPIClient *manager = [HYOCoding_NetAPIClient sharedManager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
 
    [manager request_Login_WithPath:path Params:params methord:POST andBlock:^(id  _Nonnull data, NSError * _Nonnull error) {
        if (data && !error) {
            NSDictionary *dataDic = [data objectForKey:@"data"];
            NSLog(@"dataDic =========== $%@",dataDic);
            NSArray *dataAerr = [HYOJson objectWithModelClass:@"LoginModel" withJsonString:data];
            
//            User *userM = [NSObject objectOfClass:@"User" fromJson:dataDic];
//            block(userM,nil);
        }else{
            block(nil,error);
            NSLog(@"error is==========+%@",error);
        }
        
        
    }];
}


-(void)request_SMSLogin_WithPath:(NSString *)path Params:(id)params andBlock:(void (^)(id _Nonnull, NSError * _Nonnull))block
{
    
    HYOCoding_NetAPIClient *manager = [HYOCoding_NetAPIClient sharedManager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager request_Login_WithPath:path Params:params methord:POST andBlock:^(id  _Nonnull data, NSError * _Nonnull error) {
        if (data && !error) {
            NSDictionary *dataDic = [data objectForKey:@"data"];
            NSLog(@"dataDic =========== $%@",dataDic);
            //            User *userM = [NSObject objectOfClass:@"User" fromJson:dataDic];
            //            block(userM,nil);
        }else{
            block(nil,error);
            NSLog(@"error is==========+%@",error);
        }
    }];
}

@end
