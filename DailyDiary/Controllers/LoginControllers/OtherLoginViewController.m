//
//  OtherLoginViewController.m
//  DailyDiary
//
//  Created by mob on 2019/8/22.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import "OtherLoginViewController.h"
#import "OtherLoginView.h"
#import "ThirdLoginFunction.h"
#import <SMS_SDK/SMSSDK.h>
#import "HomeViewController.h"

@interface OtherLoginViewController ()<ThirdLoginDelegate>

@property(nonatomic, strong)NSString *phoneStr;

@end

@implementation OtherLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewInfo];
}

-(void)setupViewInfo
{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem.title = @"返回";
    OtherLoginView *otherLoginView = [[OtherLoginView alloc] initWithFrame:CGRectMake(0, kStateNavigationHeight, kScreen_Width, kScreen_Height)];
    otherLoginView.delegate = self;
    [self.view addSubview:otherLoginView];
}

#pragma mark ----------点击事件的代理回调
-(void)getVerCodeWithPhone:(NSString *)phoneStr
{
    _phoneStr = phoneStr;
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:phoneStr zone:@"86" template:nil result:^(NSError *error) {
        if (error) {
            NSLog(@"error is ========%@",error);
        }else{
            NSLog(@"success ---------- ");
        }
    }];
}

-(void)thirdLoginWithPlatfromType:(SSDKPlatformType)platformType
{
    [ThirdLoginFunction thirdLoginPlatfromType:platformType withBlock:^(SSDKResponseState responseState, SSDKUser * _Nonnull userInfosss, NSError * _Nonnull error) {
        
    }];

}

-(void)phoneLoginWithVerCode:(NSString *)codeStr
{
    NSLog(@"phoneLogin----");
    [SMSSDK commitVerificationCode:codeStr phoneNumber:_phoneStr zone:@"86" result:^(NSError *error) {
        if (!error) {
            NSLog(@"success is ===+++++");
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kLoginKey];
            HomeViewController *homeVC = [[HomeViewController alloc] init];
            [self.navigationController pushViewController:homeVC animated:NO];
        }else{
            NSLog(@"error is ===+++++%@",error);
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
