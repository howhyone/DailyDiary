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

@end

NS_ASSUME_NONNULL_END
