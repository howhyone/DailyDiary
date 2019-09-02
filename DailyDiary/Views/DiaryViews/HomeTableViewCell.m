//
//  HomeTableViewCell.m
//  DailyDiary
//
//  Created by mob on 2019/8/28.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import "HomeTableViewCell.h"

@implementation HomeTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViewInfo];
    }
    return self;
}

-(void)setupViewInfo
{
    
    
    UIView *headerView = [[UIView alloc] init];
    UILabel *headerLabel = [UILabel labelWithFont:12.0 WithText:@"- 2019年7月 -" WithColor:0xb4b5b6];
    [headerView addSubview:headerLabel];
    [headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.top).offset(10);
        make.centerX.equalTo(headerView.centerX).offset(0);
        make.height.equalTo(17 * kScale_Height);
        make.width.equalTo(84 * kScale_Width);
    }];
    [self addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.right.left.equalTo(self).offset(0);
        make.height.equalTo(37 * kScale_Height);
    }];
    __weak typeof(self) weakSelf = self;
    _dayLabel = [UILabel labelWithFont:24.0 WithText:@"14" WithColor:0x151718];
    _dayLabel.font = [UIFont fontWithName:@"DINAlternate-Bold" size:24.0];
    [self addSubview:_dayLabel];
    [_dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.top).offset(10 * kScale_Height);
        make.left.equalTo(headerView.left).offset(23 * kScale_Width);
        make.width.equalTo(24 * kScale_Width);
        make.height.equalTo(28 * kScale_Height);
    }];
    
    _weekLabel = [UILabel labelWithFont:24.0 WithText:@"周三" WithColor:0x151718];
    [self addSubview:_weekLabel];
    [_weekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.weekLabel.bottom).offset(10 * kScale_Height);
        make.left.equalTo(weakSelf.weekLabel.left).offset(0);
        make.right.equalTo(weakSelf.weekLabel.right).offset(0);
        make.bottom.equalTo(self.bottom).offset(-14 * kScale_Height);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.dayLabel.top).offset(0);
        make.left.equalTo(weakSelf.dayLabel.right).offset(23 * kScale_Width);
        make.bottom.equalTo(weakSelf.weekLabel.bottom).offset(0);
        make.width.equalTo(1 * kScale_Width);
    }];
    
    _diaryTextLabel = [UILabel labelWithFont:13.0 WithText:@"哈哈哈哈哈哈哈" WithColor:0x151718];
    [self addSubview:_diaryTextLabel];
    [_diaryTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.top).offset(0);
        make.left.equalTo(lineView.right).offset(15 * kScale_Width);
        make.bottom.equalTo(lineView.bottom).offset(0);
        make.right.equalTo(self.right).offset(-9 * kScale_Width);
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

@implementation PlaintextTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViewInfo];
    }
    return self;
}

-(void)setupViewInfo
{
    
}

@end

@implementation ImageTextTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViewInfo];
    }
    return self;
}

-(void)setupViewInfo
{
    
    self.diaryTextLabel.frame = CGRectMake(self.diaryTextLabel.frame.origin.x, self.diaryTextLabel.frame.origin.y, self.diaryTextLabel.frame.size.width - 100 * kScale_Width, self.diaryTextLabel.frame.size.height);
    _diaryImageView = [UIImageView imageViewWithImageName:@""];
    [_diaryImageView setBackgroundColor:[UIColor greenColor]];
    [self addSubview:_diaryImageView];
    [_diaryImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.diaryTextLabel.top).offset(0);
        make.left.equalTo(self.diaryTextLabel.right).offset(10 * kScale_Width);
        make.bottom.equalTo(self.diaryTextLabel.bottom).offset(0);
        make.right.equalTo(self.right).offset(10 * kScale_Width);
    }];
    
}
@end
