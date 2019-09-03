//
//  MakeDiaryView.m
//  DailyDiary
//
//  Created by mob on 2019/9/3.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import "MakeDiaryView.h"

@implementation MakeDiaryView

-(id)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self setupViewInfo];
    }
    return self;
}

-(void)setupViewInfo
{
    _diaryTextField = [UITextField textFieldWithFont:15 withTextColor:0x151718 withBackgroundColor:0xF5F6F8];
    [self addSubview:_diaryTextField];
}


@end


@implementation titleDateView

-(id)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self setupViewInfo];
    }
    return self;
}

-(void)setupViewInfo
{
    UIButton *dateBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    dateBtn.contentMode = UIViewContentModeLeft;
    [dateBtn setTitle:@"22" forState:UIControlStateNormal];
    [dateBtn setImage:[UIImage imageNamed:@"下拉"] forState:UIControlStateNormal];
    
    [self addSubview:dateBtn];
}

@end
