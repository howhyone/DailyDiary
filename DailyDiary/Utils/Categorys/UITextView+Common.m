//
//  UITextView+Common.m
//  DailyDiary
//
//  Created by mob on 2019/9/22.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import "UITextView+Common.h"

@implementation UITextView (Common)

//-(instancetype)init
//{
//
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeFont:) name:kNotificationFontSize object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeFont:) name:kNotificationFontName object:nil];
//    return self;
//}    

-(void)changeFont:(NSNotification *)object
{
    NSString *currentFontName = [[NSUserDefaults standardUserDefaults] objectForKey:kFontNameKey];
    CGFloat currentFontSize = [[[NSUserDefaults standardUserDefaults] objectForKey:kFontSizeKey] floatValue];
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//
//    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont fontWithName:currentFontName size:currentFontSize], NSParagraphStyleAttributeName:paragraphStyle};
    
    
    [self setFont:[UIFont fontWithName:currentFontName size:(CGFloat)currentFontSize]];
//    self.attributedText = [[NSAttributedString alloc]initWithString: self.text attributes:attributes];

}

+(UITextView *)textViewWithFontSize:(CGFloat)fontSize WithFontColor:(UInt32)fontColor
{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeFont:) name:kNotificationFontSize object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeFont:) name:kNotificationFontName object:nil];
    UITextView *textViewCommon = [[UITextView alloc] init];
    textViewCommon.font = [UIFont systemFontOfSize:fontSize];
    textViewCommon.textColor = [UIColor colorWithRGBHex:fontColor];
    return textViewCommon;
}

@end
