//
//  OtherLoginView.m
//  DailyDiary
//
//  Created by mob on 2019/8/22.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import "OtherLoginView.h"
#import "ThirdLoginView.h"

@interface OtherLoginView ()

@property(nonatomic, strong)UIButton *verBtn;
@property(nonatomic, assign)int timeNum;
@property(nonatomic, strong)NSTimer *verTimer;
@end

@implementation OtherLoginView

-(id)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        _timeNum = 60;
        [self setupViewInfo];
    }
    return self;
}

-(void)setupViewInfo
{
    UIImageView *logoImageView = [UIImageView imageViewWithImageName:@"logo"];
    [self addSubview:logoImageView];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(47 * kScale_Height);\
        make.centerX.equalTo(self.centerX).offset(0);
        make.width.equalTo(90 * kScale_Width);
    }];
    UITextField *phoneTextField = ({
        UITextField *phoneTextField = [UITextFieldInherit textFieldWithFont:14.0f withTextColor:0xb4b5b6 withBackgroundColor:0xf5f5f5];
        phoneTextField.inputAccessoryView = [[UIView alloc] init];
        UIImageView *phoneImageView = [UIImageView imageViewWithImageName:@"手机"];
        phoneImageView.frame = CGRectMake(0, 0, 12 * kScale_Width, 18 * kScale_Height);
        phoneTextField.leftView = phoneImageView;
        phoneTextField.leftViewMode = UITextFieldViewModeAlways;
        [phoneTextField leftViewRectForBounds:phoneImageView.bounds];
        [phoneTextField textRectForBounds:phoneTextField.bounds];
        [phoneTextField editingRectForBounds:phoneTextField.bounds];
        phoneTextField.layer.cornerRadius = 23;
        phoneTextField.layer.masksToBounds = YES;
        NSMutableDictionary *attributedMutableDic = [[NSMutableDictionary alloc] init];
        attributedMutableDic[NSForegroundColorAttributeName] = [UIColor colorWithRGBHex:0xb4b5b6];
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"请输入手机号码" attributes:attributedMutableDic];
        phoneTextField.attributedPlaceholder = attributedString;
        
        phoneTextField;
        });
    self.phoneTextField = phoneTextField;
    [self addSubview:phoneTextField];
    [phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoImageView.bottom).offset(56 * kScale_Height);
        make.centerX.equalTo(self.centerX).offset(0);
        make.width.equalTo(260 * kScale_Width);
        make.height.equalTo(46 * kScale_Height);
    }];
    
    UITextField *smsTextField = [UITextField textFieldWithFont:14.0 withTextColor:0xb4b5b6 withBackgroundColor:0xf5f5f5 withLeftImageName:@"验证码" withLeftViewFrame:CGRectMake(0, 0, 12 * kScale_Width, 15 * kScale_Height) withPlaceholder:@"请输入短信验证码" withPlaceholderColor:0xb4b5b6 withCornerRadius:23.0];
    [smsTextField setInputAccessoryView:[[UIView alloc] init]];
    self.verCodeTextField = smsTextField;
    [self addSubview:smsTextField];
    [smsTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneTextField.bottom).offset(33 *kScale_Height);
        make.centerX.equalTo(phoneTextField.centerX).offset(0);
        make.left.equalTo(phoneTextField.left).offset(0);
        make.height.equalTo(46 * kScale_Height);
    }];
    UIButton *smsBtn = [UIButton buttonWithTitle:@"发送验证码" withTitleColor:0x26ad95];
    self.verBtn = smsBtn;
    [smsBtn addTarget:self action:@selector(getVerificationcode:) forControlEvents:UIControlEventTouchUpInside];
    [smsBtn.layer setBorderColor:[UIColor colorWithRGBHex:0x26ad95].CGColor];
    [smsBtn.layer setBorderWidth:1.0];
    smsBtn.layer.cornerRadius = 13.0;
    smsBtn.layer.masksToBounds = YES;
    [smsTextField addSubview:smsBtn];
    [smsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(smsTextField.top).offset(10);
        make.right.equalTo(smsTextField.right).offset(-10);
        make.width.equalTo(76 * kScale_Width);
        make.height.equalTo(26 * kScale_Height);
    }];
    
    UILabel *warnLabel = [UILabel labelWithFont:11.0 WithText:@"*手机号不可用？联系我们 400-695-2216" WithColor:0xb4b5b6];
    [self addSubview:warnLabel];
    [warnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(smsTextField.bottom).offset(23 * kScale_Height);
        make.right.equalTo(smsTextField.right).offset(0);
        
    }];
    
    UIButton *loginBtn = [UIButton buttonWithTitle:@"登录" withTitleColor:0xFFFFFF withBackgroundColor:0x151718];
    loginBtn.layer.cornerRadius = 23.0;
    loginBtn.layer.masksToBounds = YES;
    [loginBtn addTarget:self action:@selector(phoneLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(warnLabel.bottom).offset(29 * kScale_Height);
        make.left.equalTo(smsTextField.left).offset(0);
        make.right.equalTo(smsTextField.right).offset(0);
        make.height.equalTo(46 * kScale_Height);
    }];
    
}

#pragma mark ---------点击事件
-(void)getVerificationcode:(UIButton *)button
{
    if (self.phoneTextField.text.length == 11 ) {
        self.verTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(regreshButton) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_verTimer forMode:NSRunLoopCommonModes];
        if ([self.delegate respondsToSelector:@selector(getVerCodeWithPhone:)]) {
            [self.delegate getVerCodeWithPhone:self.phoneTextField.text];
        }
    }else{
        NSLog(@"手机号格式错误");
    }

}
-(void)phoneLogin:(UIButton *)button
{
    [self releaseTimer];
    if (self.verCodeTextField.text.length == 4 || self.verCodeTextField.text.length == 6) {
        if ([self.delegate respondsToSelector:@selector(phoneLoginWithVerCode:)]) {
            [self.delegate phoneLoginWithVerCode:self.verCodeTextField.text];
        }
    }
}


-(void)regreshButton
{
    if (_timeNum > 0) {
        _timeNum = _timeNum - 1;
        [self.verBtn setTitle:[NSString stringWithFormat:@"%d",_timeNum] forState:UIControlStateNormal];
        self.verBtn.enabled = NO;
    }else{
        [self.verBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        self.verBtn.enabled = YES;
        [self releaseTimer];
    }
}
//释放timer
- (void)releaseTimer {
    if (self.verTimer) {
        [self.verTimer invalidate];
        self.verTimer = nil;
    }
}


@end
