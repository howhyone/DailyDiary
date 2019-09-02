//
//  ThirdLoginFunction.m
//  DailyDiary
//
//  Created by mob on 2019/8/24.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import "ThirdLoginFunction.h"

@implementation ThirdLoginFunction

+(void)thirdLoginPlatfromType:(SSDKPlatformType)platformType withBlock:(void(^)(SSDKResponseState responseState, SSDKUser *user,NSError *error))block
{
    [ShareSDK authorize:platformType settings:nil onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        if (!error) {
            NSLog(@"------success");
            block(state,user,error);
        }else{
            NSLog(@"====== failed %@",error);
            block(state,user,error);
        }
    }];
}

@end
