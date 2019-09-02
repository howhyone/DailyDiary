//
//  UIColor+Comomn.h
//  DailyDiary
//
//  Created by mob on 2019/8/17.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Comomn)

//@property (nonatomic, readonly) CGColorSpaceModel colorSpaceModel;
//@property (nonatomic, readonly) BOOL canProvideRGBComponents;
//@property (nonatomic, readonly) CGFloat red; // Only valid if canProvideRGBComponents is YES
//@property (nonatomic, readonly) CGFloat green; // Only valid if canProvideRGBComponents is YES
//@property (nonatomic, readonly) CGFloat blue; // Only valid if canProvideRGBComponents is YES
//@property (nonatomic, readonly) CGFloat white; // Only valid if colorSpaceModel == kCGColorSpaceModelMonochrome
//@property (nonatomic, readonly) CGFloat alpha;
//@property (nonatomic, readonly) UInt32 rgbHex;
//- (BOOL)red:(CGFloat *)r green:(CGFloat *)g blue:(CGFloat *)b alpha:(CGFloat *)a;

+ (UIColor *)colorWithRGBHex:(UInt32)hex;
//+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
//+ (UIColor *)colorWithHexString:(NSString *)stringToConvert andAlpha:(CGFloat)alpha;
@end

NS_ASSUME_NONNULL_END
