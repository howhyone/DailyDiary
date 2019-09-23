//
//  NSObject+Common.m
//  DailyDiary
//
//  Created by mob on 2019/9/18.
//  Copyright © 2019 howhyone. All rights reserved.
//https://www.jianshu.com/p/4e2d575bb3e0

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

+(NSString *)currentItmeStr
{
    NSDate *currentDate = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval TimeInterval = [currentDate timeIntervalSince1970] * 1000;
    NSString *TimeStr = [NSString stringWithFormat:@"%f",TimeInterval];
    return TimeStr;
}

+(NSString *)getCurrentDateYearMonth
{
    NSDate *currentDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:currentDate];
    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    NSString *currentDateStr = @"";
    if (month < 10) {
        currentDateStr = [NSString stringWithFormat:@"%ld0%ld",year,month];
    }else{
        currentDateStr = [NSString stringWithFormat:@"%ld%ld",year,month];
    }
    return currentDateStr;
}

//  颜色转换为背景图片
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(NSString*)getWeekDay:(NSString*)currentStr

{
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc]init];//实例化一个NSDateFormatter对象
    
    [dateFormat setDateFormat:@"yyyyMMdd"];//设定时间格式,要注意跟下面的dateString匹配，否则日起将无效
    
    NSDate*date =[dateFormat dateFromString:currentStr];
    
    NSArray*weekdays = [NSArray arrayWithObjects: [NSNull null],@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",nil];
    
    NSCalendar*calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone*timeZone = [[NSTimeZone alloc]initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit =NSCalendarUnitWeekday;
    
    NSDateComponents*theComponents = [calendar components:calendarUnit fromDate:date];
    
    return[weekdays objectAtIndex:theComponents.weekday];
    
}

+(NSDateComponents *)getDateComponentsDate:(NSString *)dateStr
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSDate *currentDate = [dateFormatter dateFromString:dateStr];
    comps = [calendar components:unitFlags fromDate:currentDate];
    return comps;
}

@end
