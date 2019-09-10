//
//  PackageView.m
//  DailyDiary
//
//  Created by mob on 2019/9/8.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import "PackageView.h"

@implementation PackageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end


@implementation KeyboardToolBarView

-(id)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self setupViewInfo];
    }
    return self;
}

-(void)setupViewInfo
{
    [self setBackgroundColor:[UIColor colorWithRGBHex:0xFFFFFF]];
     UIView *keyboardToolBar = [[UIView alloc] initWithFrame:CGRectMake(0 , 0, kScreen_Width, 42 * kScale_Height)];
    [self addSubview:keyboardToolBar];
    UIButton *albumBtn = [UIButton buttonWithImage:@"添加图片"];
    [albumBtn addTarget:self action:@selector(clickAlbumButton) forControlEvents:UIControlEventTouchUpInside];
    [keyboardToolBar addSubview:albumBtn];
    [albumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(keyboardToolBar.left).offset(15 * kScale_Width);
        make.top.equalTo(keyboardToolBar.top).offset(11 * kScale_Height);
        make.bottom.equalTo(keyboardToolBar.bottom).offset(-11 * kScale_Height);
        make.width.equalTo(23 * kScale_Width);
    }];
    UIButton *doneBtn = [UIButton buttonWithTitle:@"保存" withTitleColor:0x26AD95];
    [doneBtn addTarget:self action:@selector(clickDoneButton) forControlEvents:UIControlEventTouchUpInside];
    [keyboardToolBar addSubview:doneBtn];
    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(keyboardToolBar.right).offset(-15 * kScale_Width);
        make.top.equalTo(keyboardToolBar.top).offset(11 * kScale_Height);
        make.bottom.equalTo(keyboardToolBar.bottom).offset(-11 * kScale_Height);
        make.width.equalTo(50 * kScale_Width);
    }];
}

#pragma mark ------ 按钮点击事件
-(void)clickAlbumButton
{
    if ([self.delegate respondsToSelector:@selector(clickKeyboardToolBarAlbumItem)]) {
        [self.delegate clickKeyboardToolBarAlbumItem];
    }
}
-(void)clickDoneButton
{
    if ([self.delegate respondsToSelector:@selector(clickKeyboardToolBarDoneItem)]) {
        [self.delegate clickKeyboardToolBarDoneItem];
    }
}


@end
