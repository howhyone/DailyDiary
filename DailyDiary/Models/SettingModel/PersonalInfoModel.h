//
//  PersonalInfoModel.h
//  DailyDiary
//
//  Created by mob on 2019/9/29.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PersonalInfoModel : NSObject
@property(nonatomic, strong)NSString *name;
@property(nonatomic, strong)NSString *img;
@property(nonatomic, copy)NSString *phone;
@end

NS_ASSUME_NONNULL_END
