//
//  HYOJson.m
//  DailyDiary
//
//  Created by mob on 2019/9/19.
//  Copyright © 2019 howhyone. All rights reserved.
//

/****
 {
 code = 200;
 data =     {
 error = "<null>";
 res =         {
 isValid = 1;
 phone = 17521317395;
 valid = 1;
 };
 status = 200;
 };
 message = success;
 }
 *****/

#import "HYOJson.h"
#import <objc/runtime.h>
@implementation HYOJson
+(id)objectWithModelClass:(NSString *)modelClass withJsonString:(NSString *)jsonStr
{
    if (!modelClass || !jsonStr ) {
        return nil;
    }
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    id jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    if (![jsonDic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    id dataDic = [jsonDic objectForKey:@"data"];
    if (![dataDic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    id resDic = [dataDic objectForKey:@"res"];
    if (![resDic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSMutableArray *modelArr = [NSMutableArray arrayWithCapacity:1];
    u_int count;
    objc_property_t *propertyList = class_copyPropertyList([modelClass class], &count);
    for (int i = 0; i < count; i++) {
        const char *propertyChar = property_getName(propertyList[i]);
        NSString *propertyName = [NSString stringWithUTF8String:propertyChar];
        NSString *propertyValue = [resDic objectForKey:propertyName];
        [modelArr addObject:propertyValue];
    }
    return modelArr;
}
@end
