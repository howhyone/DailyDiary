//
//  PhotoWallCollectionViewCell.m
//  DailyDiary
//
//  Created by mob on 2019/9/11.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import "PhotoWallCollectionViewCell.h"

@implementation PhotoWallCollectionViewCell

-(id)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self setupViewInfo];
    }
    return self;
}

-(void)setupViewInfo
{
    [self setBackgroundColor:[UIColor colorWithRGBHex:0xf5f6f8]];
    __weak typeof(self) weakSelf = self;
    _photoImageView = [[UIImageView alloc] init];
    _photoImageView.image = [UIImage imageNamed:@"jjy2.jpg"];
    [self addSubview:_photoImageView];
    [_photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.width);
        make.height.equalTo(self.height);
        make.top.equalTo(self.top);
        make.left.equalTo(self.left);
    }];
    
    _numberLabel = [UILabel labelWithFont:14.0 WithText:@"24张" WithColor:0xffffff WithTextAlignment:NSTextAlignmentRight];
    [self addSubview:_numberLabel];
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.photoImageView.right).offset(-7 * kScale_Width);
        make.top.equalTo(weakSelf.photoImageView.top).offset(125 * kScale_Height);
        make.width.equalTo(40 * kScale_Width);
        make.height.equalTo(20 * kScale_Height);
    }];
    
    _dateLabel = [UILabel labelWithFont:14.0 WithText:@"8月12日 2019" WithColor:0xffffff WithTextAlignment:NSTextAlignmentRight];
    [self addSubview:_dateLabel];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.numberLabel.bottom).offset(2);
        make.right.equalTo(weakSelf.numberLabel.right).offset(0);
        make.height.equalTo(weakSelf.numberLabel.height).offset(0);
        make.width.equalTo(90 * kScale_Width);
    }];
}

-(void)setPicturesListM:(id)object
{
    PicturesListModel *pictureListM = (PicturesListModel *)object;
    [_photoImageView sd_setImageWithURL:[NSURL URLWithString:pictureListM.src]];
    _numberLabel.text = [NSString stringWithFormat:@"%@",pictureListM.num];
    
    NSString *dateStr = pictureListM.date;
    NSDateComponents *pictureDateComponents = [NSObject getDateComponentsDate:dateStr];
    NSInteger dayInt = pictureDateComponents.day;
    NSInteger monthInt = pictureDateComponents.month;
    NSInteger yearInt = pictureDateComponents.year;
    NSString *dateText = [NSString stringWithFormat:@"%ld月%ld日 %ld",monthInt,dayInt,yearInt];
    _dateLabel.text = dateText;
}

@end
