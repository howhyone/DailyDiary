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

+(id)objectWithModelClass:(NSString *)modelClass withJsonString:(NSString *)jsonStr;
@end

NS_ASSUME_NONNULL_END
