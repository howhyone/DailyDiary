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


@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    BOOL loginValue = [[NSUserDefaults standardUserDefaults] boolForKey:kActivekey];
    if (!loginValue) {
        [self showOpenScreenAD];
    }
    [self secVerify];
}

-(void)secVerify
{
    [SecVerify preLogin:^(NSDictionary * _Nullable resultDic, NSError * _Nullable error) {
        if (!error)
        {
            NSLog(@"预取号成功");
            // 自定义配置Model，currentViewController必传.
            SecVerifyCustomModel *model = [[SecVerifyCustomModel alloc] init];
            model.currentViewController = self;
            [SecVerify loginWithModel:model completion:^(NSDictionary *resultDic, NSError *error) {
                if (!error)
                {
                    
                }
                else
                {
                    
                }
            }];
        }
        else
        {
            NSLog(@"预取号失败%@", error);
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
