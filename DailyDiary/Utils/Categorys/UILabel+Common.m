//
//  UILabel+Common.m
//  DailyDiary
//
//  Created by mob on 2019/8/17.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import "UILabel+Common.h"
#import <objc/runtime.h>

NSString *const FONT_NAME_KEY = @"fontnamekey";

@implementation UILabel (Common)

+ (void)load {
    //方法交换应该被保证，在程序中只会执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //获得viewController的生命周期方法的selector
        SEL systemSel = @selector(willMoveToSuperview:);
        //自己实现的将要被交换的方法的selector
        SEL swizzSel = @selector(myWillMoveToSuperview:);
        //两个方法的Method
        Method systemMethod = class_getInstanceMethod([self class], systemSel);
        Method swizzMethod = class_getInstanceMethod([self class], swizzSel);
        
        //首先动态添加方法，实现是被交换的方法，返回值表示添加成功还是失败
        BOOL isAdd = class_addMethod(self, systemSel, method_getImplementation(swizzMethod), method_getTypeEncoding(swizzMethod));
        if (isAdd) {
            //如果成功，说明类中不存在这个方法的实现
            //将被交换方法的实现替换到这个并不存在的实现
            class_replaceMethod(self, swizzSel, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
        } else {
            //否则，交换两个方法的实现
            method_exchangeImplementations(systemMethod, swizzMethod);
        }
        
    });
}
- (void)myWillMoveToSuperview:(UIView *)newSuperview {
    
    [self myWillMoveToSuperview:newSuperview];
    [self changeFont];
//    NSString *currentFontName = [[NSUserDefaults standardUserDefaults] objectForKey:kFontNameKey];
//    CGFloat currentFontSizeStr = [[[NSUserDefaults standardUserDefaults] objectForKey:kFontSizeKey] floatValue];
//    NSString *xkFontName = [NSObject currentFontName:@"华文行楷" withFileType:@"ttf"];
//    if ([currentFontName isEqualToString:@"STXingkai-SC-Light"]) {
//        currentFontName = xkFontName;
//    }
////    [NSObject downloadFont:currentFontName];
//    if ([self isKindOfClass:NSClassFromString(@"UIButtonLabel")]) {
//        return;
//    }
//    if (self) {
//         self.font = [UIFont fontWithName:currentFontName size:currentFontSizeStr];
//    }
}

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
    [self changeFont];
}

-(void)changeFont
{
    if ([self isKindOfClass:NSClassFromString(@"UIButtonLabel")]) {
         return;
     }
    NSString *currentFontName = [[NSUserDefaults standardUserDefaults] objectForKey:kFontNameKey];
    CGFloat currentFontSizeStr = [[[NSUserDefaults standardUserDefaults] objectForKey:kFontSizeKey] floatValue];
    NSString *xkFontName = [NSObject currentFontName:@"华文行楷" withFileType:@"ttf"];
    if ([currentFontName isEqualToString:@"STXingkai-SC-Light"]) {
        currentFontName = xkFontName;
    }
    NSString *ytFontName = [NSObject currentFontName:@"方正兰亭圆简体" withFileType:@"ttf"];
    if ([currentFontName isEqualToString:@"STYuanti-SC-Regular"]) {
        currentFontName = ytFontName;
    }
    
    if (!currentFontName && !currentFontSizeStr) {
        currentFontName = @"PingFangSC-Regular";
        currentFontSizeStr = 12.0;
    }else if (!currentFontName && currentFontSizeStr){
        currentFontName = @"PingFangSC-Regular";
    }else if (currentFontName && !currentFontSizeStr){
        currentFontSizeStr = 12.0;

    }
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
