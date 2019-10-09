//
//  HYOCoding_NetAPIManager.m
//  HYOCoding
//
//  Created by mob on 2019/5/21.
//  Copyright © 2019 mob. All rights reserved.
//

#import "HYOCoding_NetAPIManager.h"
#import "HYOCoding_NetAPIClient.h"
#import "LoginModel.h"
#import "DiaryListModel.h"
#import "DiaryDetailModel.h"
#import "PicturesListModel.h"
#import "PersonalInfoModel.h"
#import "AFNetworkActivityIndicatorManager.h"
@implementation HYOCoding_NetAPIManager


+(instancetype)sharedManager
{
    static HYOCoding_NetAPIManager *shared_manager = nil;
    static dispatch_once_t shared_Token;
    dispatch_once(&shared_Token, ^{
        shared_manager = [[self alloc] init];
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    });
    return shared_manager;
}


-(void)request_VerifyLogin_WithPath:(NSString *)path Params:(id)params andBlock:(void (^)(id data, NSError * error))block
{
    HYOCoding_NetAPIClient *manager = [HYOCoding_NetAPIClient sharedManager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    [manager request_Login_WithPath:path Params:params methord:POST andBlock:^(id  _Nonnull data, NSError * _Nonnull error) {
        if (data && !error) {
            NSLog(@"dataDic =========== $%@",data);
            LoginModel *loginM  = [HYOJson objectWithModelClass:@"LoginModel" withJsonString:data];
            block(loginM,nil);
            
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
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager request_Login_WithPath:path Params:params methord:POST andBlock:^(id  _Nonnull data, NSError * _Nonnull error) {
        if (data && !error) {
            LoginModel *loginM  = [HYOJson objectWithModelClass:@"LoginModel" withJsonString:data];
            block(loginM,error);
        }else{
            block(data,error);
            NSLog(@"error is==========+%@",error);
        }
    }];
}

-(void)request_UserInquiry_WithPath:(NSString *)path Params:(id)params andBlock:(void(^)(id data, NSError *error))block
{
    HYOCoding_NetAPIClient *manager = [HYOCoding_NetAPIClient sharedManager];
   
    [manager request_UserInquiry_WithPath:path Params:params methord:GET andBlock:^(id  _Nonnull data, NSError * _Nonnull error) {
        if (data && !error) {
            PersonalInfoModel *personalInfoM  = [HYOJson objectWithModelClass:@"PersonalInfoModel" withJsonString:data];
            NSLog(@"data is ======+%@",data);
            block(personalInfoM,error);
        }else{
            NSLog(@"error is==========+%@",error);
            block(data,error);
        }
    }];
}
-(void)request_UserEdit_WithPath:(NSString *)path Params:(id)params andBlock:(void(^)(id data, NSError *error))block
{
    HYOCoding_NetAPIClient *manager = [HYOCoding_NetAPIClient sharedManager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                         @"application/json",
                                                         @"text/html"       ,
                                                         @"image/jpeg"      ,
                                                         @"image/png"       ,
                                                         @"image/jpg"       ,
                                                         @"application/octet-stream",
                                                         @"text/json"      ,
                                                         nil] ;
    
    [manager request_UserEdit_WithPath:path Params:params methord:POST andBlock:^(id  _Nonnull data, NSError * _Nonnull error) {
        if (data && !error) {
            NSLog(@"data is ======+%@",data);
            block(data,error);
        }else{
            NSLog(@"error is==========+%@",error);
            block(data,error);
        }
    }];
}


-(void)request_EditDiray_WithPath:(NSString *)path Params:(id)params andBlock:(void(^)(id data, NSError *error))block
{
    HYOCoding_NetAPIClient *manager = [HYOCoding_NetAPIClient sharedManager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];

    [manager request_EditDiray_WithPath:path Params:params methord:POST andBlock:^(id  _Nonnull data, NSError * _Nonnull error) {
        if (data && !error) {
            block(data,error);
        }else{
            NSLog(@"error is==========+%@",error);
            block(data,error);
        }
    }];
}

-(void)request_ListDiary_WithPath:(NSString *)path Params:(id)params andBlock:(void(^)(id data, NSError *error))block
{
    HYOCoding_NetAPIClient *manager = [HYOCoding_NetAPIClient sharedManager];
    AFHTTPRequestSerializer *httpRequest = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer = httpRequest;
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    response.removesKeysWithNullValues = YES;
    manager.responseSerializer = response;
    [manager request_ListDiary_WithPath:path Params:params methord:POST andBlock:^(id  _Nonnull data, NSError * _Nonnull error) {
        if (data && !error) {
            NSArray *diaryListArr = [HYOJson objectWithModelClass:@"DiaryListModel" withJsonString:data];
            NSLog(@"ListDiary data ===========%@",data);
            block(diaryListArr,error);
        }else{
            NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"] ;
            NSString *errorStr = [[ NSString alloc ] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"origialerror is %@\n error is==========+%@",error,errorStr);
             block(data,error);
        }
    }];
}

-(void)request_DetailDiary_WithPath:(NSString *)path Params:(id)params andBlock:(void(^)(id data, NSError *error))block
{
    HYOCoding_NetAPIClient *manager = [HYOCoding_NetAPIClient sharedManager];

    [manager request_DetailDiary_WithPath:path Params:params methord:GET andBlock:^(id  _Nonnull data, NSError * _Nonnull error) {
        if (data && !error) {
            DiaryDetailModel *diaryDetailM  = [HYOJson objectWithModelClass:@"DiaryDetailModel" withJsonString:data];
            NSLog(@"DetailDiarydata ===========%@",data);
            block(diaryDetailM,error);
        }else{
            NSLog(@"DetailDiarydata error==========+%@",error);
            block(data,error);
        }
    }];
}

-(void)request_SearchDiray_WithPath:(NSString *)path Params:(id)params andBlock:(void(^)(id data, NSError *error))block
{
    HYOCoding_NetAPIClient *manager = [HYOCoding_NetAPIClient sharedManager];
    
    [manager request_SearchDiary_WithPath:path Params:params methord:GET andBlock:^(id  _Nonnull data, NSError * _Nonnull error) {
        if (data && !error) {
            NSArray *diaryListArr = [HYOJson objectWithModelClass:@"DiaryListModel" withJsonString:data];
            NSLog(@"ListDiary data ===========%@",data);
            block(diaryListArr,error);
        }else{
            NSLog(@"error is==========+%@",error);
            block(data,error);
        }
    }];
}

-(void)request_PicturesList_WithPath:(NSString *)path Params:(id)params andBlock:(void(^)(id data, NSError *error))block
{
    HYOCoding_NetAPIClient *manager = [HYOCoding_NetAPIClient sharedManager];
    [manager request_PicturesList_WithPath:path Params:params methord:GET andBlock:^(id  _Nonnull data, NSError * _Nonnull error) {
        if (data && !error) {
            PicturesListModel *picturesListM  = [HYOJson objectWithModelClass:@"PicturesListModel" withJsonString:data];
            NSLog(@"data ===========%@",data);
            block(picturesListM,error);
        }else{
            NSLog(@"error is==========+%@",error);
            block(data,error);
        }
    }];
}

@end
