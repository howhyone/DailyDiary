//
//  PhotoInfoViewController.m
//  DailyDiary
//
//  Created by mob on 2019/9/22.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import "PhotoInfoViewController.h"

@interface PhotoInfoViewController ()

@end
int currentNum =0;
int totalNum = 0;
@implementation PhotoInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(clickBackBtn)];
    NSString *titleStr = [NSString stringWithFormat:@"%d/%d",currentNum,totalNum];
    UILabel *titleLabel = [UILabel labelWithFont:15.0 WithText:titleStr WithColor:0xffffff];
    self.navigationItem.titleView = titleLabel;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(clickDeletedBtn)];
    
    UIImageView *photoImageView = [[UIImageView alloc] initWithImage:_photoImage];
    [self.view addSubview:photoImageView];
    [photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(146 * kScale_Height);
        make.centerX.equalTo(self.view.centerX).offset(0);
        make.width.equalTo(374 * kScale_Width);
        make.height.equalTo(374 * kScale_Width);
    }];
}

-(void)clickBackBtn
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)clickDeletedBtn
{
    __weak typeof(self) weakSelf = self;
    if (weakSelf.deletedPhotoBlock) {
        weakSelf.deletedPhotoBlock(_photoImage);
    }
}

@end
