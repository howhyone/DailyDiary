//
//  ThirdLoginFunction.h
//  DailyDiary
//
//  Created by mob on 2019/8/24.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShareSDK/ShareSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface ThirdLoginFunction : UIView

+(void)thirdLoginPlatfromType:(SSDKPlatformType)platformType withBlock:(void(^)(SSDKResponseState responseState, SSDKUser *userInfosss,NSError *error))block;

@end

NS_ASSUME_NONNULL_END
