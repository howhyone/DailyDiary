//
//  PersonalInfoView.h
//  DailyDiary
//
//  Created by mob on 2019/8/20.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ClickButtonDelegate <NSObject>

@required
-(void)clickButton:(NSInteger)buttonTag;

@end
@interface PersonalInfoView : UIView
@property(nonatomic, weak)id <ClickButtonDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
