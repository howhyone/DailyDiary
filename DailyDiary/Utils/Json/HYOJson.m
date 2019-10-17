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
-(SEL)createSetterWithPropertyName:(NSString *)propertyName
{
    propertyName = [propertyName capitalizedString]; //首字母大写
    NSString *setterMethod = [NSString stringWithFormat:@"set%@",propertyName];
    SEL setterSel = NSSelectorFromString(setterMethod);
    return setterSel;
}

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
    NSString *flagStr = nil;
    if ([[dataDic allKeys] containsObject:@"flag"]) {
        flagStr = [dataDic objectForKey:@"flag"];
    }
    id resDic = nil;
    if ([[dataDic allKeys] containsObject:@"res"]) {
        resDic = [dataDic objectForKey:@"res"];
        if (![resDic isKindOfClass:[NSDictionary class]]) {
            return nil;
        }
    }
    
    
    NSArray *listArr = nil;
    
    if ([modelClass isEqualToString:@"PicturesListModel"]) {
        id listTempArr = [dataDic objectForKey:@"list"];
        if (![listTempArr isKindOfClass:[NSArray class]]) {
            return nil;
        }else{
            listArr = listTempArr;
        }
    }
    
    if ([modelClass isEqualToString:@"DiaryListModel"]) {
        id listTempArr = [dataDic objectForKey:@"list"];
        if (![listTempArr isKindOfClass:[NSArray class]]) {
            return nil;
        }else{
            listArr = listTempArr;
        }
    }
    
    u_int propertyCount;
    id modelObject = [[NSClassFromString(modelClass) alloc] init];
    objc_property_t *propertyList = class_copyPropertyList([NSClassFromString(modelClass) class], &propertyCount);
    if (resDic) {
        for (int i = 0; i < propertyCount; i++) {
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
        free(propertyList);
        return modelObject;
    }
    if (listArr) {
        NSMutableArray *modelMutableArr = [NSMutableArray arrayWithCapacity:1];
        for (int i = 0; i < listArr.count;i++) {
            modelObject = [[NSClassFromString(modelClass) alloc] init];
            NSDictionary *listDiaryDic = listArr[i];
            for (int j = 0; j < propertyCount; j++) {
                const char *propertyChar = property_getName(propertyList[j]);
                NSString *propertyName = [NSString stringWithUTF8String:propertyChar];
                NSString *propertyValue = nil;
                if ([propertyName isEqualToString:@"DiaryId"]) {
                    propertyValue = [listDiaryDic objectForKey:@"id"];
                }else{
                    propertyValue = [listDiaryDic objectForKey:propertyName];
                }
                [modelObject setValue:propertyValue forKey:propertyName];
            }
            if ([modelClass isEqualToString:@"DiaryListModel"]) {
                [modelObject setValue:flagStr forKey:@"flag"];
            }
            [modelMutableArr addObject:modelObject];
        }
        free(propertyList);
        return modelMutableArr;
    }
    
    if (dataDic && !listArr && !resDic) {
        for (int i = 0; i < propertyCount; i++) {
            const char *propertyChar = property_getName(propertyList[i]);
            NSString *propertyName = [NSString stringWithUTF8String:propertyChar];
            NSString *propertyValue = [dataDic objectForKey:propertyName];
            if ([propertyName isEqualToString:@"DiaryId"]) {
                propertyValue = [dataDic objectForKey:@"id"];
            }else{
                propertyValue = [dataDic objectForKey:propertyName];
            }
            [modelObject setValue:propertyValue forKey:propertyName];
        
        }
        free(propertyList);
        return modelObject;
    }
    free(propertyList);
    return nil;
}



@end
