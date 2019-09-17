//
//  LoginViewController.m
//  DailyDiary
//
//  Created by mob on 2019/8/20.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import "LoginViewController.h"
#import <SecVerify/SecVerify.h>
#import "PersonalInfoViewController.h"
#import "HomeViewController.h"
#import "OtherLoginViewController.h"


@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
//    [self secVerify];
    
    [self setupViewInfo];
}

-(void)setupViewInfo
{
    UIImageView *logoImageView = [UIImageView imageViewWithImageName:@"logo"];
    [self.view addSubview:logoImageView];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(134 * kScale_Height);
        make.centerX.equalTo(self.view.centerX);
        make.width.equalTo(90 * kScale_Width);
        make.height.equalTo(90 * kScale_Width);
    }];
    
    UILabel *welcomeLabel = [UILabel labelWithFont:20.0 WithText:@"Hi, 欢迎使用天天日记" WithColor:0x151718 WithTextAlignment:NSTextAlignmentCenter];
    
    [self.view addSubview:welcomeLabel];
    [welcomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoImageView.bottom).offset( 30 * kScale_Height);
        make.centerX.equalTo(logoImageView.centerX).offset(0);
        make.width.equalTo(300 * kScale_Width);
        
    }];
    
    UIButton *oneKeyLoginBtn = [UIButton buttonWithTitle:@"本机号码一键登录" withTitleColor:0xffffff withBackgroundColor:0x151718];
    oneKeyLoginBtn.layer.cornerRadius = 23;
    oneKeyLoginBtn.layer.masksToBounds = YES;
    [oneKeyLoginBtn addTarget:self action:@selector(clickOneKeyLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:oneKeyLoginBtn];
    [oneKeyLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(welcomeLabel.bottom).offset(116 * kScale_Height);
        make.centerX.equalTo(welcomeLabel.centerX);
        make.width.equalTo(260 * kScale_Width);
        make.height.equalTo(46 * kScale_Height);
    }];
    
    UIButton *phoneLogin = [UIButton buttonWithTitle:@"使用其他手机号登录" withTitleColor:0x1aa48a];
    [phoneLogin addTarget:self action:@selector(clickPhoneLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:phoneLogin];
    [phoneLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oneKeyLoginBtn.bottom).offset(46 * kScale_Height);
        make.centerX.equalTo(oneKeyLoginBtn.centerX).offset(0);
        make.width.equalTo(150 * kScale_Width);
        make.height.equalTo(24 * kScale_Height);
    }];
}

#pragma mark -------- 按钮点击事件

-(void)clickOneKeyLogin
{
    [self secVerify];
}

-(void)clickPhoneLogin
{
    
    OtherLoginViewController *otherLoginVC = [[OtherLoginViewController alloc] init];
    [self.navigationController pushViewController:otherLoginVC animated:NO];
}

//秒验
-(void)secVerify
{
    [SecVerify preLogin:^(NSDictionary * _Nullable resultDic, NSError * _Nullable error) {
        if (!error)
        {
            NSLog(@"预取号成功");
            // 自定义配置Model，currentViewController必传.
            SecVerifyCustomModel *model = [[SecVerifyCustomModel alloc] init];
            model.switchAccHidden = YES;
            model.currentViewController = self;
            [SecVerify loginWithModel:model completion:^(NSDictionary *resultDic, NSError *error) {
                if (!error)
                {
                    HomeViewController *homeVC = [[HomeViewController alloc] init];
                    [self.navigationController pushViewController:homeVC animated:NO];
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kLoginKey];
                }
                else
                {
                    OtherLoginViewController *otherLoginVC = [[OtherLoginViewController alloc] init];
                    [self.navigationController pushViewController:otherLoginVC animated:YES];
                }
            }];
        }
        else
        {
            NSLog(@"预取号失败%@", error);
            OtherLoginViewController *otherLoginVC = [[OtherLoginViewController alloc] init];
            [self.navigationController pushViewController:otherLoginVC animated:YES];
        }
    }];
}



@end
