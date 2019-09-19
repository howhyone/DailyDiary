//
//  NSObject+Common.m
//  DailyDiary
//
//  Created by mob on 2019/9/18.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import "NSObject+Common.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

#define kBaseURLStr @"https://coding.net/"

@implementation NSObject (Common)

-(NSString *)getBaseUrl
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault objectForKey:@"kBaseURLStr"] ?:kBaseURLStr;
    
}

+(NSString *)getcarrierName{
    CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [telephonyInfo subscriberCellularProvider];
    NSString *currentCountry=[carrier carrierName];
    NSString *carrierNameStr = nil;
    if ([currentCountry isEqualToString:@"中国联通"]) {
        carrierNameStr = @"CUCC";
    }else if ([currentCountry isEqualToString:@"中国移动"]){
        carrierNameStr = @"CMCC";
    }else if ([currentCountry isEqualToString:@"中国电信"]){
        carrierNameStr = @"CTCC";
    }else{
        DebugLog(@"不是真机或未插手机卡");
    }
    return carrierNameStr;
}

@end
