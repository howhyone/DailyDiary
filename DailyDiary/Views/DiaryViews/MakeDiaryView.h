//
//  MakeDiaryView.h
//  DailyDiary
//
//  Created by mob on 2019/9/3.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MakeDiaryView : UIView

@property(nonatomic, strong)UITextView *diaryTextView;

@end

//导航控制器title：日历选择器

@protocol clickDateSelectorProtocol <NSObject>

-(void)showCalendar;
-(void)hideCalendar;
@end
@interface TitleDateView : UIView

@property(nonatomic, weak) id<clickDateSelectorProtocol> dateDelegate;

@property(nonatomic, strong)UIButton *dateBtn;
@property(nonatomic, strong)UILabel *titleLabel;
@end

NS_ASSUME_NONNULL_END
