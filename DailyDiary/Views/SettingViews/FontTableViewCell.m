//
//  FontTableViewCell.m
//  DailyDiary
//
//  Created by mob on 2019/9/17.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import "FontTableViewCell.h"



@implementation FontTableViewCell

int tagNum = 0;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViewInfo];
    }
    return self;
}

-(void)setupViewInfo
{
    UILabel *fontName = [UILabel labelWithFont:14.0 WithText:@"平方字体" WithColor:0x151718];
    [self addSubview:fontName];
    [fontName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(12 * kScale_Height);
        make.left.equalTo(self.left).offset(15 * kScale_Width);
        make.width.equalTo(60 * kScale_Width);
        make.centerY.equalTo(self.centerY).offset(0);
    }];
    _downloadBtn = [UIButton buttonWithImage:@"下载"];
    [_downloadBtn setImage:[UIImage imageNamed:@"选择"] forState:UIControlStateSelected];
    [_downloadBtn addTarget:self action:@selector(clickDonwnload:) forControlEvents:UIControlEventTouchUpInside];
    if (tagNum >= 3) {
        tagNum = 0;
    }else{
        tagNum += 1;
    }
    _downloadBtn.tag = 10000 + tagNum;
    [self addSubview:_downloadBtn];
    [_downloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(fontName.top).offset(0);
        make.right.equalTo(self.right).offset(-15 * kScale_Width);
        make.width.equalTo(20 * kScale_Width);
        make.height.equalTo(20 * kScale_Width);
    }];
}


#pragma mark -----------按钮点击事件
-(void)clickDonwnload:(id)object
{
    _downloadBtn = (UIButton *)object;
    switch (_downloadBtn.tag) {
        case 10001:
            if ([self.delegate respondsToSelector:@selector(downloadFont:)]) {
                [self.delegate downloadFont:@"PingFangSC-Regular"];
            }
        break;
        case 10002:
            if ([self.delegate respondsToSelector:@selector(downloadFont:)]) {
                [self.delegate downloadFont:@"STYuanti-SC-Regular"];
            }
        break;
        case 10003:
            if ([self.delegate respondsToSelector:@selector(downloadFont:)]) {
                [self.delegate downloadFont:@"KaiTi"];
            }
        break;
        default:
            break;
    }

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
        make.centerX.equalTo(self.centerX).offset(0);
        make.width.equalTo(200 * kScale_Width);
    }];
    
}

@end
