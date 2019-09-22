//
//  UITextField+Common.m
//  DailyDiary
//
//  Created by mob on 2019/8/21.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import "UITextField+Common.h"

@implementation UITextField (Common)

-(instancetype)init
{
    if (self == [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeFont:) name:kNotificationFontSize object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeFont:) name:kNotificationFontName object:nil];
    }
    return self;
}

-(void)changeFont:(NSNotification *)object
{
    NSString *currentFontName = [[NSUserDefaults standardUserDefaults] objectForKey:kFontNameKey];
    CGFloat currentFontSizeStr = [[[NSUserDefaults standardUserDefaults] objectForKey:kFontSizeKey] floatValue];
    self.font = [UIFont fontWithName:currentFontName size:currentFontSizeStr];
}

+(UITextFieldInherit *)textFieldWithFont:(CGFloat)fontSize withTextColor:(UInt32)textColor
{
    UITextFieldInherit *textFieldCommon = [[UITextFieldInherit alloc] init];
    textFieldCommon.font = [UIFont systemFontOfSize:fontSize];
    textFieldCommon.textColor = [UIColor colorWithRGBHex:textColor];
    return textFieldCommon;
}


+(UITextFieldInherit *)textFieldWithFont:(CGFloat)fontSize withTextColor:(UInt32)textColor withBackgroundColor:(UInt32)backgroundColor
{
    UITextFieldInherit *textFieldCommon = [self textFieldWithFont:fontSize withTextColor:textColor];
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
