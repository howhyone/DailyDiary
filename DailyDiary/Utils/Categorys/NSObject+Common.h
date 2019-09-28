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

+(NSString *)getCurrentDate;

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

+ (NSData *)imageData:(UIImage *)myimage;

/**随机生成一个字符串*/
- (NSString *)randomString:(NSInteger)length;
/**随机生成一个中文名字*/
-(NSString *)randomChineseName:(NSInteger )integer;

@end

NS_ASSUME_NONNULL_END
