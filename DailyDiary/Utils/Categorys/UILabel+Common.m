//
//  UILabel+Common.m
//  DailyDiary
//
//  Created by mob on 2019/8/17.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import "UILabel+Common.h"

@implementation UILabel (Common)

+(UILabel *)labelWithFont:(CGFloat)fontSize WithText:(NSString *)textStr WithColor:(UInt32)colorValue
{
    UILabel *labelCommon = [[UILabel alloc] init];
    labelCommon.text = textStr;
    labelCommon.textColor = [UIColor colorWithRGBHex:colorValue];
    labelCommon.font = [UIFont systemFontOfSize:fontSize];
    labelCommon.textAlignment = NSTextAlignmentLeft;
    return labelCommon;
}

@end
