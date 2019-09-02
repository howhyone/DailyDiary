//
//  UIColor+Comomn.m
//  DailyDiary
//
//  Created by mob on 2019/8/17.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import "UIColor+Comomn.h"

@implementation UIColor (Comomn)

+(UIColor *)colorWithRGBHex:(UInt32)hex
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex ) & 0xFF;
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f];
}


@end
