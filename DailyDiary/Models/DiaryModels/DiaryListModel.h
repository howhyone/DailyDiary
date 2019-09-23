//
//  diaryListModel.h
//  DailyDiary
//
//  Created by mob on 2019/9/23.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DiaryListModel : NSObject

@property(nonatomic, strong)NSString *flag;

@property(nonatomic, strong)NSString *context;
@property(nonatomic, strong)NSString *date;
@property(nonatomic, strong)NSString *DiaryId;
@property(nonatomic, strong)NSString *photo;
@property(nonatomic, strong)NSString *title;
@property(nonatomic, strong)NSString *userId;

@end

NS_ASSUME_NONNULL_END
