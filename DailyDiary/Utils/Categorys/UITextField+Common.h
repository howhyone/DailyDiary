//
//  UITextField+Common.h
//  DailyDiary
//
//  Created by mob on 2019/8/21.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITextFieldInherit.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (Common)

+(UITextFieldInherit *)textFieldWithFont:(CGFloat)fontSize withTextColor:(UInt32)textColor;

+(UITextFieldInherit *)textFieldWithFont:(CGFloat)fontSize withTextColor:(UInt32)textColor withBackgroundColor:(UInt32)backgroundColor;

+(UITextField *)textFieldWithFont:(CGFloat)fontSize withTextColor:(UInt32)textColor withBackgroundColor:(UInt32)backgroundColor withLeftImageName:(NSString *)leftImageName withLeftViewFrame:(CGRect)leftViewFrame withPlaceholder:(NSString *)placeholderStr withPlaceholderColor:(UInt32)placeholderColor withCornerRadius:(float)cornerRadius;

@end

NS_ASSUME_NONNULL_END
