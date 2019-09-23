//
//  NSObject+Common.h
//  DailyDiary
//
//  Created by mob on 2019/9/18.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Common)

-(NSString *)getBaseUrl;

+(NSString *)getcarrierName;

+(NSString *)currentItmeStr;

+(NSString *)getCurrentDateYearMonth;

+ (UIImage *)imageWithColor:(UIColor *)color;
/**
 日期字符串转周几
 **/
+(NSString*)getWeekDay:(NSString*)currentStr;

/**
 日期字符串转单独的年、月、日、时、
 **/
+(NSDateComponents *)getDateComponentsDate:(NSString *)dateStr;
@end

NS_ASSUME_NONNULL_END
