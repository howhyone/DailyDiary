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

+(UIButton *)buttonWithLeftTitle:(NSString *)leftTitleText FontSize:(CGFloat)fontSize ColorName:(UInt32)colorName RightImageName:(NSString *)rightImageName
{
    CGFloat intervalF = 10.0;
    UIButton *tempButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tempButton setTitle:leftTitleText forState:UIControlStateNormal];
    [tempButton setTitleColor:[UIColor colorWithRGBHex:colorName] forState:UIControlStateNormal];
    [tempButton setImage:[UIImage imageNamed:rightImageName] forState:UIControlStateNormal];
    CGFloat titleRight = tempButton.imageView.frame.size.width + intervalF;  // title需要左移的偏移量
    CGFloat imageLeft = 0.0;  //图片需要右移的偏移量
    //    使用frame获取titleLabel的width、height为nil，要使用intrinsicContentSize属性
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        imageLeft = tempButton.titleLabel.intrinsicContentSize.width;
    }else{
        imageLeft = tempButton.titleLabel.frame.size.width + intervalF;
    }
    [tempButton setImageEdgeInsets:UIEdgeInsetsMake(0, imageLeft, 0, -imageLeft)];
    [tempButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -titleRight, 0, titleRight)];
    [tempButton setNeedsLayout];
    return tempButton;
}

@end
