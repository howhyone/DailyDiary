//
//  DiaryDetailModel.h
//  DailyDiary
//
//  Created by mob on 2019/9/24.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DiaryDetailModel : NSObject

@property (nonatomic , copy) NSString  * photo;
@property (nonatomic , copy) NSString  * DiaryId;
@property (nonatomic , copy) NSString  * title;
@property (nonatomic , copy) NSString  * userId;
@property (nonatomic , copy) NSString  * context;
@property (nonatomic , copy) NSString  * date;

@end

NS_ASSUME_NONNULL_END
