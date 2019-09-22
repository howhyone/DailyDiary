//
//  UILabel+Common.m
//  DailyDiary
//
//  Created by mob on 2019/8/17.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import "UILabel+Common.h"

NSString *const FONT_NAME_KEY = @"fontnamekey";

@implementation UILabel (Common)

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

+(UILabel *)labelWithFont:(CGFloat)fontSize WithText:(NSString *)textStr WithColor:(UInt32)colorValue
{
    UILabel *labelCommon = [[UILabel alloc] init];
    labelCommon.text = textStr;
    labelCommon.textColor = [UIColor colorWithRGBHex:colorValue];
    labelCommon.font = [UIFont systemFontOfSize:fontSize];
    labelCommon.textAlignment = NSTextAlignmentLeft;
    return labelCommon;
}

+(UILabel *)labelWithFont:(CGFloat)fontSize WithText:(NSString *)textStr WithColor:(UInt32)colorValue WithTextAlignment:(NSTextAlignment )textAlignment
{
    UILabel *labelCommon = [[UILabel alloc] init];
    labelCommon.text = textStr;
    labelCommon.textColor = [UIColor colorWithRGBHex:colorValue];
    labelCommon.font = [UIFont systemFontOfSize:fontSize];
    labelCommon.textAlignment = textAlignment;
    return labelCommon;
}
@end
