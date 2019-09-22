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


#pragma mark ---------创建一个model类中的属性 setter方法
//-(SEL)createSetterWithPropertyName:(NSString *)propertyName
//{
//    propertyName = [propertyName capitalizedString]; //首字母大写
//    NSString *setterMethod = [NSString stringWithFormat:@"set%@",propertyName];
//    SEL setterSel = NSSelectorFromString(setterMethod);
//    return NSSelectorFromString(setterMethod);
//}

+(id)objectWithModelClass:(NSString *)modelClass withJsonString:(id)jsonDic
{
    if (!modelClass || !jsonDic ) {
        return nil;
    }
    
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
    u_int count;
    id modelObject = [[NSClassFromString(modelClass) alloc] init];
    objc_property_t *propertyList = class_copyPropertyList([NSClassFromString(modelClass) class], &count);
    for (int i = 0; i < count; i++) {
        const char *propertyChar = property_getName(propertyList[i]);
        NSString *propertyName = [NSString stringWithUTF8String:propertyChar];
        NSString *propertyValue = [resDic objectForKey:propertyName];
        propertyName = [propertyName capitalizedString]; //首字母大写
        NSString *setterMethod = [NSString stringWithFormat:@"set%@:",propertyName];
        SEL setterSel = NSSelectorFromString(setterMethod);
       
        if ([modelObject respondsToSelector:setterSel]) {
            [modelObject performSelectorOnMainThread:setterSel withObject:propertyValue waitUntilDone:[NSThread isMainThread]];
        }
    }
    return modelObject;
}



@end
