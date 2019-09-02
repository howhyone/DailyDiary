//
//  ThirdLoginView.m
//  DailyDiary
//
//  Created by mob on 2019/8/24.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import "ThirdLoginView.h"
#import "ThirdLoginFunction.h"
@implementation ThirdLoginView

-(id)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self setupViewInfo];
    }
    return self;
}

-(void)setupViewInfo
{
    UIView *leftLineV = [self lineView];
    [self addSubview:leftLineV];
    [leftLineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(70*kScale_Width);
        make.height.equalTo(2 * kScale_Width);
        make.top.equalTo(self.top).offset(5 * kScale_Height);
    }];
    UILabel *thirdLoginL = [UILabel labelWithFont:12 WithText:@"第三方登录" WithColor:0xb4b5b6];
    [self addSubview:thirdLoginL];
    [thirdLoginL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(leftLineV.right).offset(26 * kScale_Width);
        
    }];
    
    UIView *rightLineV = [self lineView];
    [self addSubview:rightLineV];
    [rightLineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(thirdLoginL.right).offset(26 * kScale_Width);
        make.width.equalTo(70*kScale_Width);
        make.height.equalTo(2 * kScale_Width);
        make.top.equalTo(thirdLoginL.top).offset(5 * kScale_Height);
    }];
    
    UIButton *wechatBtn = [UIButton buttonWithImage:@"微信"];
    self.wechatBtn = wechatBtn;
    wechatBtn.tag = 1004;
    [self addSubview:wechatBtn];
    [wechatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(thirdLoginL.bottom).offset(20 * kScale_Height);
        make.left.equalTo(thirdLoginL.left).offset(-46 * kScale_Width);
        make.height.width.equalTo(46 * kScale_Width);
    }];
    UIButton *sinaBtn = [UIButton buttonWithImage:@"微博"];
    self.sinaBtn = sinaBtn;
    sinaBtn.tag = 1005;
    [self addSubview:sinaBtn];
    [sinaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wechatBtn.top).offset(0);
        make.left.equalTo(wechatBtn.right).offset(54 * kScale_Width);
        make.height.width.equalTo(46 * kScale_Width);
    }];
    
}

-(UIView *)lineView
{
    UIView *lineView = [[UIView alloc] init];
    [lineView setBackgroundColor:[UIColor colorWithRGBHex:0xa1a1a1]];
    return lineView;
}



@end
