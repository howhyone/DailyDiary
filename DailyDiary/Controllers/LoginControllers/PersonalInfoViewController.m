//
//  PersonalInfoViewController.m
//  DailyDiary
//
//  Created by mob on 2019/8/20.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import "PersonalInfoViewController.h"
#import "PersonalInfoView.h"
#import <ShareSDK/ShareSDK.h>

@interface PersonalInfoViewController ()<ClickButtonDelegate>

@end

@implementation PersonalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    PersonalInfoView *personalInfoView = [[PersonalInfoView alloc] initWithFrame:CGRectMake(0,kStateNavigationHeight,kScreen_Width,kScreen_Height)];
    personalInfoView.delegate = self;
    
    [self httpRequestInquiry];
    [self.view addSubview:personalInfoView];
}

-(void)httpRequestInquiry
{
    NSString *phoneStr = [[NSUserDefaults standardUserDefaults] objectForKey:kPhoneKey];
    NSMutableDictionary *paramsMutableDic = [NSMutableDictionary dictionaryWithCapacity:1];
    [paramsMutableDic setObject:phoneStr forKey:@"phone"];
    NSString *pathStr = @"/mob_diary/user/info";
    [[HYOCoding_NetAPIManager sharedManager] request_UserInquiry_WithPath:pathStr Params:paramsMutableDic andBlock:^(id  _Nonnull data, NSError * _Nonnull error) {
        
    }];
}
-(void)httpRequestUserEdit
{
    NSString *phoneStr = [[NSUserDefaults standardUserDefaults] objectForKey:kPhoneKey];
    NSMutableDictionary *paramsMutableDic = [NSMutableDictionary dictionaryWithCapacity:1];
    [paramsMutableDic setObject:phoneStr forKey:@"phone"];
    [paramsMutableDic setObject:@"zx" forKey:@"name"];
    
//    [paramsMutableDic setObject:@"" forKey:@"file"];
    NSString *pathStr = @"/mob_diary/user/edit";
    [[HYOCoding_NetAPIManager sharedManager] request_UserEdit_WithPath:pathStr Params:paramsMutableDic andBlock:^(id  _Nonnull data, NSError * _Nonnull error) {
        
    }];
}

-(void)clickButton:(NSInteger)buttonTag
{
    switch (buttonTag) {
        case 1001: // 上传头像
            NSLog(@"1001------");
            break;
        case 1002: // 随机昵称
            NSLog(@"1002=====");
            break;
        case 1003: //提交个人资料
            NSLog(@"1003 =====");
            [self httpRequestUserEdit];
            break;
        case 1004: // 微信授权
            NSLog(@"1004------");
            [ShareSDK authorize:SSDKPlatformTypeWechat settings:nil onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
                if (!error) {
                    NSLog(@"------success");
                }else{
                    NSLog(@"====== failed %@",error);
                }
            }];
            break;
        case 1005: // 微博授权
            NSLog(@"1005 ======");
            [ShareSDK authorize:SSDKPlatformTypeSinaWeibo settings:nil onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
                if (!error) {
                    NSLog(@"------success");
                }else{
                    NSLog(@"====== failed %@",error);
                }
            }];
            break;
        default:
            break;
    }
}

@end
