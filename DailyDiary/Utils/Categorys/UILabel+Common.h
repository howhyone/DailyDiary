//
//  UILabel+Common.h
//  DailyDiary
//
//  Created by mob on 2019/8/17.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Common)

+(UILabel *)labelWithFont:(CGFloat)fontSize WithText:(NSString *)textStr WithColor:(UInt32)colorValue;

+(UILabel *)labelWithFont:(CGFloat)fontSize WithText:(NSString *)textStr WithColor:(UInt32)colorValue WithTextAlignment:(NSTextAlignment)textAlignment;

@end

NS_ASSUME_NONNULL_END
