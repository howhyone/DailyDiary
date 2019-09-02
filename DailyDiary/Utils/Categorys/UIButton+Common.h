//
//  UIButton+Common.h
//  DailyDiary
//
//  Created by mob on 2019/8/20.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Common)
+(UIButton *)buttonWithTitle:(NSString *)title  withTitleColor:(UInt32)titleColor;

+(UIButton *)buttonWithImage:(NSString *)imageNameStr;

+(UIButton *)buttonWithTitle:(NSString *)title withTitleColor:(UInt32)titleColor withImage:(NSString *)imageName;

+(UIButton *)buttonWithTitle:(NSString *)title withTitleColor:(UInt32)titleColor withBackgroundColor:(UInt32)backgroundColor;
@end

NS_ASSUME_NONNULL_END
