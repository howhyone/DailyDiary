//
//  FontTableViewCell.m
//  DailyDiary
//
//  Created by mob on 2019/9/17.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import "FontTableViewCell.h"



@implementation FontTableViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViewInfo];
    }
    return self;
}

-(void)setupViewInfo
{
    UILabel *fontName = [UILabel labelWithFont:14.0 WithText:@"" WithColor:0x151718];
    [self addSubview:fontName];
    self.fontName = fontName;
    [fontName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(12 * kScale_Height);
        make.left.equalTo(self.left).offset(15 * kScale_Width);
        make.width.equalTo(160 * kScale_Width);
        make.centerY.equalTo(self.centerY).offset(0);
    }];
    
    _selectedImageView = [UIImageView imageViewWithImageName:@"选择"];
   
    [self addSubview:_selectedImageView];
    [_selectedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(fontName.top).offset(0);
        make.right.equalTo(self.right).offset(-15 * kScale_Width);
        make.width.equalTo(20 * kScale_Width);
        make.height.equalTo(20 * kScale_Width);
    }];
}

- (void)setFontNameStr:(NSString *)fontNameStr
{
    self.fontName.text = fontNameStr;
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


@implementation FontTableViewHeaderView

-(id)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self setupViewInfo];
    }
    return self;
}

-(void)setupViewInfo
{
    UILabel *headerLabel = [UILabel labelWithFont:12 WithText:@"请使用WiFi下载字体" WithColor:0xb4b5b6];
    [self addSubview:headerLabel];
    [headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(8 * kScale_Height);
        make.left.equalTo(self.left).offset(5 * kScale_Width);
        make.centerY.equalTo(self.centerY).offset(0);
        make.width.equalTo(200 * kScale_Width);
    }];
    
}

@end
