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
    WeakSelf(weakSelf);
    UIView *headerView = [[UIView alloc] init];
    [headerView setBackgroundColor:[UIColor colorWithRGBHex:0xf5f6f8]];
    _headerLabel = [UILabel labelWithFont:12.0 WithText:@"- 2019年7月 -" WithColor:0xb4b5b6];
    [headerView addSubview:_headerLabel];
    [_headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    _dayLabel = [UILabel labelWithFont:24.0 WithText:@"14" WithColor:0x151718];
    _dayLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_dayLabel];
    [_dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.bottom).offset(10 * kScale_Height);
        make.left.equalTo(headerView.left).offset(23 * kScale_Width);
        make.width.equalTo(50 * kScale_Width);
        make.height.equalTo(28 * kScale_Height);
    }];
    
    _weekLabel = [UILabel labelWithFont:13.0 WithText:@"周三" WithColor:0x151718];
    _weekLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_weekLabel];
    [_weekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.dayLabel.bottom).offset(10 * kScale_Height);
        make.left.equalTo(weakSelf.dayLabel.left).offset(0);
        make.right.equalTo(weakSelf.dayLabel.right).offset(0);
        make.bottom.equalTo(self.bottom).offset(-14 * kScale_Height);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    [lineView setBackgroundColor:[UIColor colorWithRGBHex:0xf5f6f8]];
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

-(void)setDiaryListM:(id)object
{
    DiaryListModel *diaryListM = (DiaryListModel *)object;
    NSString *headerStr = [diaryListM.date substringToIndex:6];
    _headerLabel.text = headerStr;
    NSDateComponents *diaryDateCmponents = [NSObject getDateComponentsDate:diaryListM.date];
    _dayLabel.text = [NSString stringWithFormat:@"%ld",diaryDateCmponents.day];
    _weekLabel.text = [NSObject getWeekDay:diaryListM.date];
    _diaryTextLabel.text = diaryListM.title;
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




@implementation ImageTextTableViewCell

-(void)setupViewInfo
{
    [super setupViewInfo];
    _diaryImageView = [UIImageView imageViewWithImageName:@"jjy2.jpg"];
    [self addSubview:_diaryImageView];
    [_diaryImageView sizeToFit];
    [_diaryImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(47 * kScale_Height);
        make.width.equalTo(60 * kScale_Width);
        make.bottom.equalTo(self.bottom).offset(-10 * kScale_Height);
        make.right.equalTo(self.right).offset(-10 * kScale_Width);
    }];
    
}

-(void)setDiaryListM:(id)object
{
    [super setDiaryListM:object];
    DiaryListModel *diaryListM = (DiaryListModel *)object;
    [_diaryImageView sd_setImageWithURL:[NSURL URLWithString:diaryListM.img]];
}
@end
