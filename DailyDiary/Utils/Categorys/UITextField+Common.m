//
//  UITextField+Common.m
//  DailyDiary
//
//  Created by mob on 2019/8/21.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import "UITextField+Common.h"

@implementation UITextField (Common)

+(UITextFieldInherit *)textFieldWithFont:(CGFloat)fontSize withTextColor:(UInt32)textColor withBackgroundColor:(UInt32)backgroundColor
{
    UITextFieldInherit *textFieldCommon = [[UITextFieldInherit alloc] init];
    textFieldCommon.font = [UIFont systemFontOfSize:fontSize];
    textFieldCommon.textColor = [UIColor colorWithRGBHex:textColor];
    [textFieldCommon setBackgroundColor:[UIColor colorWithRGBHex:backgroundColor]];
    return textFieldCommon;
}

+(UITextField *)textFieldWithFont:(CGFloat)fontSize withTextColor:(UInt32)textColor withBackgroundColor:(UInt32)backgroundColor withLeftImageName:(NSString *)leftImageName withLeftViewFrame:(CGRect)leftViewFrame withPlaceholder:(NSString *)placeholderStr withPlaceholderColor:(UInt32)placeholderColor withCornerRadius:(float)cornerRadius
{
    UITextField *phoneTextField = [UITextFieldInherit textFieldWithFont:fontSize withTextColor:textColor withBackgroundColor:backgroundColor];
    
    UIImageView *phoneImageView = [UIImageView imageViewWithImageName:leftImageName];
    phoneImageView.frame = leftViewFrame;
    phoneTextField.leftView = phoneImageView;
    phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    [phoneTextField leftViewRectForBounds:phoneImageView.bounds];
    [phoneTextField textRectForBounds:phoneTextField.bounds];
    [phoneTextField editingRectForBounds:phoneTextField.bounds];
    if (cornerRadius != 0) {
        phoneTextField.layer.cornerRadius = 23;
        phoneTextField.layer.masksToBounds = YES;
    }

    NSMutableDictionary *attributedMutableDic = [[NSMutableDictionary alloc] init];
    attributedMutableDic[NSForegroundColorAttributeName] = [UIColor colorWithRGBHex:placeholderColor];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:placeholderStr attributes:attributedMutableDic];
    phoneTextField.attributedPlaceholder = attributedString;
    return phoneTextField;
}

@end
