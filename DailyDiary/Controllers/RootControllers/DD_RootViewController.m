//
//  DD_RootViewController.m
//  DailyDiary
//
//  Created by mob on 2019/8/17.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import "DD_RootViewController.h"
#import <MobAD/MobAD.h>
#import "ViewController.h"
#import <SecVerify/SecVerify.h>
#import "PersonalInfoViewController.h"
#import "HomeViewController.h"
#import "LoginViewController.h"

@interface DD_RootViewController ()

@end

@implementation DD_RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor greenColor]];
    [self showOpenScreenAD];
}


#pragma mark ---------- 开屏广告
- (void)showOpenScreenAD
{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 100 * kScale_Height)];
    bottomView.backgroundColor = [UIColor whiteColor];
    UILabel *bottomLabel = [UILabel labelWithFont:12.0 WithText:@"时光怎分好与坏，只有那点点滴滴" WithColor:0x191970];
    bottomLabel.frame = CGRectMake(0, 0,kScreen_Width, bottomView.frame.size.height);
    bottomLabel.textAlignment = NSTextAlignmentCenter;
    bottomLabel.font = [UIFont fontWithName:@"PingFang TC" size:15.0];
    [bottomView addSubview:bottomLabel];
    
    
}
-(void)_processGDTState:(MGADState)state  error:(NSError *)error
{
    if (error) {
        NSLog(@"error is  ====== %@",error);
    }
    switch (state) {
        case MGADStateDidClosed:
//            [self loginPushViewController];
            break;
        case MGADStateDidDismiss:
            [self loginPushViewController];

            break;
        case MGADStateDidClick:
            NSLog(@"--点击下载");
            break;
        case MGADStateAppWillEnterBackground:
            [self loginPushViewController];

            NSLog(@"--MGADStateAppWillEnterBackground");
            break;
        default:
            break;
    }
}

-(void)loginPushViewController
{
    BOOL loginBool = [[NSUserDefaults standardUserDefaults] boolForKey:kLoginKey];
    if (loginBool) {
        [self.navigationController pushViewController:[[HomeViewController alloc] init] animated:YES];
    }else{
        [self.navigationController pushViewController:[[LoginViewController alloc] init] animated:YES];
    }
}

//-(void)secVerify
//{
//    [SecVerify preLogin:^(NSDictionary * _Nullable resultDic, NSError * _Nullable error) {
//        if (!error)
//        {
//            NSLog(@"预取号成功");
//            // 自定义配置Model，currentViewController必传.
//            SecVerifyCustomModel *model = [[SecVerifyCustomModel alloc] init];
//            model.currentViewController = self;
//            model.switchAccHidden = NO;
//            [SecVerify loginWithModel:model completion:^(NSDictionary *resultDic, NSError *error) {
//                if (!error)
//                {
//                    NSLog(@"跳转个人信息也");
//                }
//                else
//                {
//                    switch (error.code) {
//                        case 170301:
//                            NSLog(@"切换登录方式");
//                            [self.navigationController pushViewController:[[PersonalInfoViewController alloc] init] animated:NO];
//                            break;
//
//                        default:
//                            break;
//                    }
//                }
//            }];
//        }
//        else
//        {
//            NSLog(@"预取号失败%@", error);
//        }
//    }];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
