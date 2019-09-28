//
//  UITextFieldInherit.m
//  DailyDiary
//
//  Created by mob on 2019/8/21.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import "UITextFieldInherit.h"

@implementation UITextFieldInherit

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect leftRect = [super leftViewRectForBounds:bounds];
    leftRect.origin.x += 10 * kScale_Width;
    return leftRect;
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds;
{
    CGRect rightRect = [super rightViewRectForBounds:bounds];
    rightRect.origin.x -= 13.0 * kScale_Width;
    return rightRect;
}

-(CGRect)textRectForBounds:(CGRect)bounds
{
    // 调用[super textRectForBounds:bounds] 就是添加 leftview 后的bounds
    CGRect textRect = [super textRectForBounds:bounds];
    textRect.origin.x += 18.0 * kScale_Width;
    return textRect;
}

-(CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect textRect = [super editingRectForBounds:bounds];
    textRect.origin.x += 18.0 * kScale_Width;
    return textRect;
}

@end



