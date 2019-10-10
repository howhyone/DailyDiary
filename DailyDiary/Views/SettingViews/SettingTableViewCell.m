//
//  SettingTableViewCell.m
//  DailyDiary
//
//  Created by mob on 2019/9/9.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import "SettingTableViewCell.h"
#import <MobPush/MobPush.h>

@interface SettingTableViewCell ()
@property(nonatomic, assign) CGFloat *fontSize;
@end

@implementation SettingTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViewInfo];
    }
    return self;
}

-(void)setupViewInfo
{
    _leftLabel = [UILabel labelWithFont:14 WithText:@"照片墙" WithColor:0x151718];
    [self addSubview:_leftLabel];
    [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(12);
        make.bottom.equalTo(self.bottom).offset(-12);
        make.left.equalTo(self.left).offset(15);
        make.width.equalTo(200);
    }];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end


@interface FontSettingTableViewCell ()

@end

//字体设置
@implementation FontSettingTableViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupFontViewInfo];
    }
    return self;
}

-(void)setupFontViewInfo
{
    self.leftLabel.text = @"字体";
    UIImageView *rightImageView = [UIImageView imageViewWithImageName:@"rightArrow"];
    [self addSubview:rightImageView];
    [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(16 * kScale_Height);
        make.bottom.equalTo(self.bottom).offset(-16 * kScale_Height);
        make.right.equalTo(self.right).offset(-18 * kScale_Width);
        make.width.equalTo(7.9 * kScale_Width);
    }];
}

@end

@interface PhotoWallSettingTableViewCell()

@property(nonatomic, strong)UILabel *photoNumLabel;

@end

//照片墙
@implementation PhotoWallSettingTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupPhotoWallViewInfo];
    }
    return self;
}

-(void)setupPhotoWallViewInfo
{
    self.leftLabel.text = @"照片墙";
}

@end

static NSInteger selectedNum = 0;

@interface FontSizeSettingTableViewCell()

@end
//字体设置
@implementation FontSizeSettingTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupFontSizeViewInfo];
    }
    return self;
}

-(void)setupFontSizeViewInfo
{
    self.leftLabel.text = @"字体大小";
    NSArray *sizeFontArr = @[@"小",@"中",@"大"];
    for (int i = 2; i >= 0; i--) {
        UIButton *fontSizeBtn = [UIButton buttonWithTitle:sizeFontArr[i] withTitleColor:0xb4b5b6];
        fontSizeBtn.tag = 10000 + i;
        [fontSizeBtn addTarget:self action:@selector(switchFontSize:) forControlEvents:UIControlEventTouchUpInside];
        fontSizeBtn.layer.cornerRadius = 11;
        fontSizeBtn.layer.masksToBounds = YES;
        [fontSizeBtn setTitleColor:[UIColor colorWithRGBHex:0xfefefe] forState:UIControlStateSelected];
        [fontSizeBtn setBackgroundImage:[NSObject imageWithColor:[UIColor colorWithRGBHex:0x26ad95]] forState:UIControlStateSelected];
        selectedNum = [[NSUserDefaults standardUserDefaults] integerForKey:kSelectedfontSizeKey];
        if (i == selectedNum) {
            fontSizeBtn.selected = YES;
            self.currentSelectedBtn = fontSizeBtn;
        }
        [self addSubview:fontSizeBtn];
        [fontSizeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.right).offset(-(15 + i * 40) * kScale_Width);
            make.top.equalTo(self.top).offset(11 * kScale_Height);
            make.bottom.equalTo(self.bottom).offset(-11 * kScale_Height);
            make.width.equalTo(30 * kScale_Width);
        }];
    }
}


-(void)switchFontSize:(UIButton *)button
{
    selectedNum = button.tag - 10000;
    [[NSUserDefaults standardUserDefaults] setInteger:selectedNum forKey:kSelectedfontSizeKey];
    self.currentSelectedBtn.selected = NO;
    button.selected = YES;
    self.currentSelectedBtn = button;
    switch (button.tag) {
        case 10000:
            NSLog(@"tag ===== 10000");
            [[NSUserDefaults standardUserDefaults] setObject:@"12" forKey:kFontSizeKey];
            break;
        case 10001:
            NSLog(@"tag ===== 10000");
            [[NSUserDefaults standardUserDefaults] setObject:@"14" forKey:kFontSizeKey];
            break;
        case 10002:
            NSLog(@"tag ===== 10000");
            [[NSUserDefaults standardUserDefaults] setObject:@"16" forKey:kFontSizeKey];
            break;
        default:
            break;
    }

    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationFontSize object:nil];

}

@end

//提醒写日记
@implementation WarnSettingTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupWarnViewInfo];
    }
    return self;
}

-(void)setupWarnViewInfo
{
    self.leftLabel.text = @"提醒我写日记 (每天9:00PM)";
    [self.leftLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(12);
        make.bottom.equalTo(self.bottom).offset(-12);
        make.left.equalTo(self.left).offset(15);
        make.width.equalTo(300 * kScale_Width);
    }];
    
    UISwitch *switchWarnBtn = [[UISwitch alloc] init];
    switchWarnBtn.onTintColor =  [UIColor colorWithRGBHex:0x26ad95];
    switchWarnBtn.tintColor = [UIColor colorWithRGBHex:0xf4f5f8];
    switchWarnBtn.thumbTintColor = [UIColor colorWithRGBHex:0xFFFFFF];
    [switchWarnBtn addTarget:self action:@selector(switchhWarn:) forControlEvents:UIControlEventValueChanged];
    BOOL switchButtonState = [[NSUserDefaults standardUserDefaults] boolForKey:@"switchButtonState"];
    [switchWarnBtn setOn:switchButtonState];
    [self addSubview:switchWarnBtn];
    [switchWarnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.right).offset(-15 * kScale_Width);
        make.top.equalTo(self.top).offset(11 * kScale_Height);
        make.bottom.equalTo(self.bottom).offset(-11 * kScale_Height);
        make.width.equalTo(44 * kScale_Width);
    }];
}

-(void)switchhWarn:(id)sender
{
    UISwitch *switchBtn = (UISwitch *)sender;
    if (switchBtn.isOn) {
        NSLog(@"开启通知");
        [MobPush restartPush];
       [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"switchButtonState"];
    }else{
        NSLog(@"关闭推送");
        [MobPush stopPush];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"switchButtonState"];

    }
    NSLog(@"----isStop =======%d",MobPush.isPushStopped);

}

@end

@implementation ShareSettingTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViewInfo];
    }
    return self;
}

-(void)setupViewInfo
{
    [super setupViewInfo];
    self.leftLabel.text = @"把天天日记分享给好友";
}

@end

@implementation SettingHeaderView

-(id)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self setupViewInfo];
    }
    return self;
}

-(void)setupViewInfo
{
    __weak typeof(self) weakSelf = self;
    
    _headerImageView = [UIImageView imageViewWithImageName:@""];
    _headerImageView.layer.cornerRadius = 45 * kScale_Width;
    _headerImageView.layer.masksToBounds = YES;
    [self addSubview:_headerImageView];
    [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(15 * kScale_Height);
        make.centerX.equalTo(self.centerX).offset(0);
        make.width.equalTo(90 * kScale_Width);
        make.height.equalTo(90 * kScale_Height);
    }];
    
    _nameLabel = [UILabel labelWithFont:25.0 WithText:@"" WithColor:0x151718];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_headerImageView.bottom).offset(10);
        make.centerX.equalTo(self->_headerImageView.centerX).offset(0);
        make.width.equalTo(kScreen_Width);
        make.height.equalTo(36 * kScale_Height);
    }];
    _changeIntroBtn = [UIButton buttonWithTitle:@"修改资料" withTitleColor:0x26ad95];
    [_changeIntroBtn addTarget:self action:@selector(changeIntroduce) forControlEvents:UIControlEventTouchUpInside];
    _changeIntroBtn.layer.borderColor = [[UIColor colorWithRGBHex:0x26ad95] CGColor];
    _changeIntroBtn.layer.borderWidth = 1.0;
    _changeIntroBtn.layer.cornerRadius = 13;
    _changeIntroBtn.layer.masksToBounds = YES;
    [self addSubview:_changeIntroBtn];
    [_changeIntroBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameLabel.bottom).offset(20* kScale_Height);
        make.left.equalTo(self.left).offset(78 * kScale_Width);
        make.width.equalTo(80 * kScale_Width);
        make.height.equalTo(26 * kScale_Height);
    }];
    
    _logoutBtn = [UIButton buttonWithTitle:@"退出登录" withTitleColor:0x151718];
    _logoutBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    _logoutBtn.layer.borderWidth = 1.0;
    _logoutBtn.layer.borderColor = [[UIColor colorWithRGBHex:0x151718] CGColor];
    _logoutBtn.layer.cornerRadius = 13;
    _logoutBtn.layer.masksToBounds = YES;
    [_logoutBtn addTarget:self action:@selector(clickLogout) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_logoutBtn];
    [_logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.changeIntroBtn.top).offset(0);
        make.left.equalTo(weakSelf.changeIntroBtn.right).offset(60 * kScale_Width);
        make.bottom.equalTo(weakSelf.changeIntroBtn.bottom).offset(0);
        make.width.equalTo(80 * kScale_Width);
    }];
}


//按钮点击事件
-(void)changeIntroduce
{
    if ([self.delegate respondsToSelector:@selector(clickchangeIntroduce)]) {
        [self.delegate clickchangeIntroduce];
    }
}
-(void)clickLogout
{
    if ([self.delegate respondsToSelector:@selector(clickLogout)]) {
        [self.delegate clickLogout];
    }

}
-(void)setPersonalInfoModel:(id)object
{
    PersonalInfoModel *personalInfoModel = (PersonalInfoModel *)object;
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:personalInfoModel.photo]];
    _nameLabel.text = personalInfoModel.name;
}


@end
