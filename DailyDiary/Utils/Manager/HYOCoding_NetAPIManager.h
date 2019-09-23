//
//  HYOCoding_NetAPIManager.h
//  HYOCoding
//
//  Created by mob on 2019/5/21.
//  Copyright © 2019 mob. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYOCoding_NetAPIManager : NSObject

+(instancetype)sharedManager;

#pragma mark ------------ login


-(void)request_VerifyLogin_WithPath:(NSString *)path Params:(id)params andBlock:(void(^)(id data, NSError *error))block;

-(void)request_SMSLogin_WithPath:(NSString *)path Params:(id)params andBlock:(void(^)(id data, NSError *error))block;

#pragma mark -------- 用户信息

-(void)request_UserInquiry_WithPath:(NSString *)path Params:(id)params andBlock:(void(^)(id data, NSError *error))block;

-(void)request_UserEdit_WithPath:(NSString *)path Params:(id)params andBlock:(void(^)(id data, NSError *error))block;

#pragma mark ----------- 日记首页

-(void)request_EditDiray_WithPath:(NSString *)path Params:(id)params andBlock:(void(^)(id data, NSError *error))block;

-(void)request_ListDiary_WithPath:(NSString *)path Params:(id)params andBlock:(void(^)(id data, NSError *error))block;

-(void)request_DetailDiary_WithPath:(NSString *)path Params:(id)params andBlock:(void(^)(id data, NSError *error))block;

#pragma mark ----------- 搜索日记

-(void)request_SearchDiray_WithPath:(NSString *)path Params:(id)params andBlock:(void(^)(id data, NSError *error))block;


@end

NS_ASSUME_NONNULL_END
