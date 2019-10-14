//
//  PersonalInfoView.m
//  DailyDiary
//
//  Created by mob on 2019/8/20.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import "PersonalInfoView.h"
#import "UITextFieldInherit.h"
#import "ThirdLoginView.h"


@implementation PersonalInfoView

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

-(void)setupView
{
    UIImageView *headerImageView =({
    UIImageView *headerImageView =[[UIImageView alloc] init];
    headerImageView.layer.cornerRadius = 90 * kScale_Width/2;
    headerImageView.layer.masksToBounds = YES;
    self.headerImageView = headerImageView;
    [self addSubview:self.headerImageView];
    [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(47 * kScale_Height);
        make.centerX.equalTo(self.centerX).offset(0);
        make.width.height.equalTo(90 * kScale_Width);
    }];
        headerImageView;
    });
    
    UIButton *uploadHeaderBtn = [UIButton buttonWithTitle:@"上传头像" withTitleColor:0x26ad95];
    uploadHeaderBtn.layer.cornerRadius = 13;
    uploadHeaderBtn.layer.masksToBounds = YES;
    uploadHeaderBtn.tag = 1001;
    [uploadHeaderBtn addTarget:self action:@selector(uploadHeader:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:uploadHeaderBtn];
    [uploadHeaderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerImageView.bottom).offset(20 * kScale_Height);
        make.centerX.equalTo(headerImageView.centerX).offset(0);
        make.width.equalTo(76 * kScale_Width);
        make.height.equalTo(26 * kScale_Height);
    }];
    
    UITextFieldInherit *nameTextField = [UITextFieldInherit textFieldWithFont:14.0 withTextColor:0x151718 withBackgroundColor:0xF5F5F5];
    nameTextField.layer.cornerRadius = 23;
    nameTextField.layer.masksToBounds = YES;
    UIView *leftTextFieldV = ({
    leftTextFieldV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 54 * kScale_Width, 46 * kScale_Height)];
        self.nameLabel = [UILabel labelWithFont:14.0 WithText:@"昵称" WithColor:0xB4B5B6];
        self.nameLabel.frame = CGRectMake(0, 0, 53 * kScale_Width, 46 * kScale_Height);
        [leftTextFieldV addSubview:self.nameLabel];
        /***** 添加了masonry约束，textfield不可以编辑，UIFielEditor没有***/
//        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(leftTextFieldV.top).offset(0);
//            make.left.equalTo(leftTextFieldV.left).offset(0);
//            make.width.equalTo(54 * kScale_Width);
//            make.height.equalTo(46 * kScale_Height);
//        }];

        UIView *lineView = [[UIView alloc] init];
        [lineView setBackgroundColor:[UIColor colorWithRGBHex:0xFFFFFF]];
        lineView.frame = CGRectMake(53 * kScale_Width, 0, 1 * kScale_Width, 46 * kScale_Height);
        [leftTextFieldV addSubview:lineView];
//        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.nameLabel.right).offset(11 * kScale_Width);
//            make.width.equalTo(1);
//            make.height.equalTo(54 * kScale_Height);
//            make.top.equalTo(self.nameLabel.top).offset(0);
//        }];
        leftTextFieldV;
    });

    nameTextField.leftView = leftTextFieldV;
    nameTextField.leftViewMode = UITextFieldViewModeAlways;
    
    UIButton *randomBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    randomBtn.frame = CGRectMake(0, 0, 22 *kScale_Width, 15.7 * kScale_Height);
    [randomBtn setBackgroundImage:[UIImage imageNamed:@"icon--"] forState:UIControlStateNormal];
    randomBtn.tag = 1002;
    [randomBtn addTarget:self action:@selector(randomName:) forControlEvents:UIControlEventTouchUpInside];
    nameTextField.rightView = randomBtn;
    nameTextField.rightViewMode = UITextFieldViewModeAlways;
    
    nameTextField.textAlignment = NSTextAlignmentLeft;
    self.nameTextField = nameTextField;
    [self addSubview:nameTextField];
    [nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(uploadHeaderBtn.bottom).offset(50 * kScale_Height);
        make.centerX.equalTo(self.centerX).offset(0);
        make.width.equalTo(260 * kScale_Width);
        make.height.equalTo(46 * kScale_Height);
    }];
    
    UILabel *warnLabel = [UILabel labelWithFont:11.0 WithText:@"*不可超过15个字" WithColor:0xB4B5B6];
    [self addSubview:warnLabel];
    [warnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameTextField.bottom).offset(10);
        make.right.equalTo(nameTextField.right).offset(0);
        make.height.equalTo(12 * kScale_Height);
    }];
    
    UIButton *commmitBtn = [UIButton buttonWithTitle:@"提交" withTitleColor:0xFFFFFF  withBackgroundColor:0x151718];
    commmitBtn.layer.cornerRadius = 23.0;
    commmitBtn.layer.masksToBounds = YES;
    commmitBtn.tag = 1003;
    [commmitBtn addTarget:self action:@selector(commitPersonalInfo:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:commmitBtn];
    [commmitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(warnLabel.bottom).offset(55 * kScale_Height);
        make.centerX.equalTo(self.centerX).offset(0);
        make.width.equalTo(260 * kScale_Width);
        make.height.equalTo(46 * kScale_Height);
    }];

}

#pragma mark -------- 点击事件
-(void)uploadHeader:(UIButton *)button
{
    NSLog(@"-----------");
    if ([self.delegate respondsToSelector:@selector(clickButton:)]) {
        [self.delegate clickButton:button.tag];
    }
}
-(void)randomName:(UIButton *)button
{
    NSLog(@"=======");
    NSString *randomStr = [NSObject randomChineseName:1];
    _nameTextField.text = randomStr;
//    if ([self.delegate respondsToSelector:@selector(clickButton:)]) {
//        [self.delegate clickButton:button.tag];
//    }
}
-(void)commitPersonalInfo:(UIButton *)button
{
    NSLog(@"2222221111");
    if ([self.delegate respondsToSelector:@selector(clickButton:)]) {
        [self.delegate clickButton:button.tag];
    }
}

-(void)setPersonalInfoModel:(id)object
{
    PersonalInfoModel *model = (PersonalInfoModel *)object;
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:model.img]];
    _nameTextField.text = model.name;
}

@end
