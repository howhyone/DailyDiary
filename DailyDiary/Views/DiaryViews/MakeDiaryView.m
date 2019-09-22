//
//  MakeDiaryView.m
//  DailyDiary
//
//  Created by mob on 2019/9/3.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import "MakeDiaryView.h"

@interface MakeDiaryView()<UITextViewDelegate>

@end

@implementation MakeDiaryView

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
    _titleTextField = [UITextField textFieldWithFont:15 withTextColor:0x151718];
    _titleTextField.placeholder = @"标题";
    _titleTextField.backgroundColor = [UIColor colorWithRGBHex:0xf5f6f8];
    [self addSubview:_titleTextField];
    [_titleTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.left.equalTo(self.left).offset(0);
        make.right.equalTo(self.right).offset(0);
        make.height.equalTo(21 * kScale_Height);
    }];
    
    _diaryTextView = [UITextView textViewWithFontSize:15.0 WithFontColor:0x151718];
    [self addSubview:_diaryTextView];
    [_diaryTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleTextField.bottom).offset(10 * kScale_Height);
        make.left.equalTo(weakSelf.titleTextField.left).offset(0);
        make.right.equalTo(weakSelf.titleTextField.right).offset(0);
        make.bottom.equalTo(self.bottom).offset(0);
    }];

    
//    _diaryImageScrollView = [[UIScrollView alloc] init];
//    _diaryImageScrollView.hidden = YES;
//    [self addSubview:_diaryImageScrollView];
//    [_diaryImageScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.diaryTextView.bottom).offset(10 * kScale_Height);
//        make.left.equalTo(weakSelf.diaryTextView.left).offset(0);
//        make.height.equalTo(77 * kScale_Height);
//        make.right.equalTo(weakSelf.diaryTextView.right).offset(0);
//    }];
    
    _keyboardToolBarView = [[KeyboardToolBarView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 42 * kScale_Height)];
    _diaryTextView.inputAccessoryView = _keyboardToolBarView;
    
}




@end


@implementation TitleDateView

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
    _dateBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_dateBtn addTarget:self action:@selector(clickDateSelector) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_dateBtn];
    [_dateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.right.equalTo(self.right).offset(0);
        make.bottom.equalTo(self.bottom).offset(0);
    }];
    UIImageView *titleImageView = [UIImageView imageViewWithImageName:@"下拉"];
    [_dateBtn addSubview:titleImageView];
    [titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.dateBtn.right).offset(0);
        make.width.equalTo(10 * kScale_Width);
        make.height.equalTo(6 * kScale_Height);
        make.centerY.equalTo(weakSelf.dateBtn.centerY).offset(0);
    }];

    UILabel *titleLabel = [UILabel labelWithFont:15.0 WithText:@"2019年 7月6日" WithColor:0x151718];
    titleLabel.textAlignment = NSTextAlignmentRight;
    self.titleLabel = titleLabel;
    [_dateBtn addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(titleImageView.left).offset(-10);
        make.centerY.equalTo(titleImageView.centerY).offset(0);
        make.height.equalTo(21);
        make.left.equalTo(weakSelf.left).offset(0);
    }];
    
    UITapGestureRecognizer *titleTapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickDateSelector:)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:titleTapGes];
}


#pragma mark ----------- 按钮点击事件

-(void)clickDateSelector
{
    if ([self.dateDelegate respondsToSelector:@selector(showCalendar)]) {
        [self.dateDelegate showCalendar];
    }
}

@end
