//
//  UIButton+Common.m
//  DailyDiary
//
//  Created by mob on 2019/8/20.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import "UIButton+Common.h"

@implementation UIButton (Common)

+(UIButton *)buttonWithTitle:(NSString *)title withTitleColor:(UInt32)titleColor
{
    UIButton *buttonCommon = [UIButton buttonWithType:UIButtonTypeSystem];
    [buttonCommon setTitle:title forState:UIControlStateNormal];
    [buttonCommon setTitleColor:[UIColor colorWithRGBHex:titleColor] forState:UIControlStateNormal];
    return buttonCommon;
}

+(UIButton *)buttonWithImage:(NSString *)imageNameStr
{
    UIButton *buttonCommon = [UIButton buttonWithType:UIButtonTypeSystem];
    [buttonCommon setBackgroundImage:[UIImage imageNamed:imageNameStr] forState:UIControlStateNormal];
    return buttonCommon;
}

+(UIButton *)buttonWithTitle:(NSString *)title withTitleColor:(UInt32)titleColor withImage:(NSString *)imageName
{
    UIButton *buttonCommon = [self buttonWithTitle:title withTitleColor:titleColor];
    [buttonCommon setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    return buttonCommon;
}

+(UIButton *)buttonWithTitle:(NSString *)title withTitleColor:(UInt32)titleColor withBackgroundColor:(UInt32)backgroundColor
{
    UIButton *buttonCommon = [self buttonWithTitle:title withTitleColor:titleColor];
    [buttonCommon setBackgroundColor:[UIColor colorWithRGBHex:backgroundColor]];
    return buttonCommon;
}



@end
