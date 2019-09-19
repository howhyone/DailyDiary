//
//  HYOCoding_NetAPIManager.h
//  HYOCoding
//
//  Created by mob on 2019/5/21.
//  Copyright © 2019 mob. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "LoginModel.h"
//#import "User.h"
//#import "ProjectModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYOCoding_NetAPIManager : NSObject



+(instancetype)sharedManager;


#pragma mark ------------ login


-(void)request_VerifyLogin_WithPath:(NSString *)path Params:(id)params andBlock:(void(^)(id data, NSError *error))block;

-(void)request_SMSLogin_WithPath:(NSString *)path Params:(id)params andBlock:(void(^)(id data, NSError *error))block;

@end

NS_ASSUME_NONNULL_END
