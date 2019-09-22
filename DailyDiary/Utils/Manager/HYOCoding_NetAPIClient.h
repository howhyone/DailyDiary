//
//  HYOCoding_NetAPIClient.h
//  HYOCoding
//
//  Created by mob on 2019/7/3.
//  Copyright © 2019 mob. All rights reserved.
//

#import "AFHTTPSessionManager.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    GET,
    POST,
    PUT
}NetWorkMethord;


@interface HYOCoding_NetAPIClient : AFHTTPSessionManager

+(HYOCoding_NetAPIClient *)sharedManager;


-(void)request_Login_WithPath:(NSString *)path Params:(id)params methord:(NetWorkMethord )methord andBlock:(void(^)(id data, NSError *error))block;

-(void)request_UserInquiry_WithPath:(NSString *)path Params:(id)params methord:(NetWorkMethord )methord andBlock:(void(^)(id data, NSError *error))block;

-(void)request_UserEdit_WithPath:(NSString *)path Params:(id)params methord:(NetWorkMethord )methord andBlock:(void(^)(id data, NSError *error))block;


-(void)request_EditDiray_WithPath:(NSString *)path Params:(id)params methord:(NetWorkMethord )methord andBlock:(void(^)(id data, NSError *error))block;

-(void)request_ListDiary_WithPath:(NSString *)path Params:(id)params methord:(NetWorkMethord )methord andBlock:(void(^)(id data, NSError *error))block;

-(void)request_DetailDiary_WithPath:(NSString *)path Params:(id)params methord:(NetWorkMethord )methord andBlock:(void(^)(id data, NSError *error))block;


-(void)requestJsonDataWithPath:(NSString *)aPath
                    withParams:(NSDictionary *)params
                withMethodType:(NetWorkMethord)method
                      andBlock:(void(^)(id data,NSError *error))block;


-(void)requestJsonDataWithPath:(NSString *)aPath
                    withParams:(NSDictionary *)params
                withMethodType:(NetWorkMethord)method
                 autoShowError:(BOOL)autoShowError
                      andBlock:(void(^)(id data,NSError *error))block;
@end

NS_ASSUME_NONNULL_END
