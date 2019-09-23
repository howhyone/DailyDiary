//
//  HYOJson.h
//  DailyDiary
//
//  Created by mob on 2019/9/19.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYOJson : NSObject
//-(SEL)createSetterWithPropertyName:(NSString *)propertyName;

+(id)objectWithModelClass:(NSString *)modelClass withJsonString:(id)jsonDic;

+(id)objectArrarWithModelClass:(NSString *)modelClass withJsonString:(id)jsonDic;


@end

NS_ASSUME_NONNULL_END
