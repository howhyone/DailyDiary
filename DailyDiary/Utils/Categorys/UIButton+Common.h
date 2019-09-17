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

+(UIButton *)buttonWithTitle:(NSString *)title withTitleColor:(UInt32)titleColor withFontSize:(CGFloat)fontSize;

+(UIButton *)buttonWithImage:(NSString *)imageNameStr;

+(UIButton *)buttonWithTitle:(NSString *)title withTitleColor:(UInt32)titleColor withImage:(NSString *)imageName;

+(UIButton *)buttonWithTitle:(NSString *)title withTitleColor:(UInt32)titleColor withBackgroundColor:(UInt32)backgroundColor;

//改变按钮htitle和image位置， title左image右
+(UIButton *)buttonWithLeftTitle:(NSString *)leftTitleText FontSize:(CGFloat)fontSize ColorName:(UInt32)colorName RightImageName:(NSString *)rightImageName;

@end

NS_ASSUME_NONNULL_END
