//
//  SettingViewController.m
//  DailyDiary
//
//  Created by mob on 2019/9/9.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTableViewCell.h"
#import "PhotoWallViewController.h"
#import "LoginViewController.h"
#import "PersonalInfoViewController.h"
#import "FontViewController.h"
#import <MobLinkPro/MLSDKScene.h>
#import <MobLinkPro/MobLink.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDKUI.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

static const NSInteger cellNum = 5;
static NSString *const pathStr = @"/demo/a";

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource,clickLogoutDelegate>
@property(nonatomic, strong)SettingTableViewCell *settingCell;
@property(nonatomic, strong)UITableView *settingTableView;
@property(nonatomic, strong)SettingHeaderView *settingHeaderView;
@property(nonatomic,strong) NSMutableDictionary *shareParams;
@property(nonatomic,strong) NSString *domain;
@property(nonatomic, strong) NSString *urlStr;
@property(nonatomic, strong) NSString *mobid;

@end

@implementation SettingViewController

-(UITableView *)settingTableView
{
    if (!_settingTableView) {
        _settingTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 397 * kScale_Height) style:UITableViewStylePlain];
        [_settingTableView registerClass:[PhotoWallSettingTableViewCell class] forCellReuseIdentifier:@"PhotoWallSettingTableViewCell"];
         [_settingTableView registerClass:[FontSettingTableViewCell class] forCellReuseIdentifier:@"FontSettingTableViewCell"];
         [_settingTableView registerClass:[FontSizeSettingTableViewCell class] forCellReuseIdentifier:@"FontSizeSettingTableViewCell"];
         [_settingTableView registerClass:[WarnSettingTableViewCell class] forCellReuseIdentifier:@"WarnSettingTableViewCell"];
       [_settingTableView registerClass:[ShareSettingTableViewCell class] forCellReuseIdentifier:@"ShareSettingTableViewCell"];
        _settingTableView.delegate = self;
        _settingTableView.dataSource = self;
        _settingTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [_settingTableView setBackgroundColor:[UIColor colorWithRGBHex:0xf5f5f5]];
        
        
    }
    return _settingTableView;
}

-(void)httpRequestInquiry
{
    WeakSelf(weakSelf);
    NSString *phoneStr = [[NSUserDefaults standardUserDefaults] objectForKey:kPhoneKey];
    NSMutableDictionary *paramsMutableDic = [NSMutableDictionary dictionaryWithCapacity:1];
    [paramsMutableDic setObject:phoneStr forKey:@"phone"];
    NSString *pathStr = @"/mob_diary/user/info";
    [[HYOCoding_NetAPIManager sharedManager] request_UserInquiry_WithPath:pathStr Params:paramsMutableDic andBlock:^(id  _Nonnull data, NSError * _Nonnull error) {
        if (data && !error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.settingHeaderView.personalInfoModel = data;
            });
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [NSObject printAllFonts];
    [self setupViewInfo];
}

-(void)setupViewInfo
{
    __weak typeof(self) weakSelf = self;
    [self.view setBackgroundColor:[UIColor colorWithRGBHex:0xf5f6f8]];
    _settingHeaderView = [[SettingHeaderView alloc] initWithFrame:CGRectMake(0, kStateNavigationHeight, kScreen_Width, 219 * kScale_Height)];
    [_settingHeaderView setBackgroundColor:[UIColor colorWithRGBHex:0xf4f4f4]];
    _settingHeaderView.delegate = self;
    [self.view addSubview:_settingHeaderView];
    
    [self.view addSubview:self.settingTableView];
    [_settingTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.settingHeaderView.bottom).offset(10 * kScale_Height);
        make.left.equalTo(weakSelf.settingHeaderView.left).offset(0);
        make.right.equalTo(weakSelf.settingHeaderView.right).offset(0);
        make.height.equalTo(397 * kScale_Height);
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return cellNum;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *settingCell = nil;
    
    switch (indexPath.row) {
        case 0:
            settingCell = [tableView dequeueReusableCellWithIdentifier:@"PhotoWallSettingTableViewCell" forIndexPath:indexPath];
            break;
        case 1:
            settingCell = [tableView dequeueReusableCellWithIdentifier:@"FontSettingTableViewCell" forIndexPath:indexPath];
            break;
        case 2:
            settingCell = [tableView  dequeueReusableCellWithIdentifier:@"FontSizeSettingTableViewCell" forIndexPath:indexPath];
            break;
        case 3:
            settingCell = [tableView dequeueReusableCellWithIdentifier:@"WarnSettingTableViewCell" forIndexPath:indexPath];
            break;
        case 4:
        settingCell = [tableView dequeueReusableCellWithIdentifier:@"ShareSettingTableViewCell" forIndexPath:indexPath];
        break;
            
        default:
            break;
    }
    settingCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return settingCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[[PhotoWallViewController alloc] init] animated:YES];
        break;
        case 1:
            [self.navigationController pushViewController:[[FontViewController alloc] init] animated:YES];
        break;
        case 4:
            [self shareDailyDiary];
        break;
        default:
            break;
    }
}

#pragma mark ---------点击事件代理

-(void)clickchangeIntroduce
{
    [self.navigationController pushViewController:[[PersonalInfoViewController alloc] init] animated:NO];
}

-(void)clickLogout
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                   message:@"确定退出登录？"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              //响应事件
                                                              NSLog(@"action = %@", action);
                                                              [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kLoginKey];
                                                              [self.navigationController pushViewController:[[LoginViewController alloc] init] animated:NO];
                                                          }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             //响应事件
                                                             NSLog(@"action = %@", action);
                                                         }];
    
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)shareDailyDiary
{
    NSMutableDictionary *customParams = [NSMutableDictionary dictionary];
        MLSDKScene *scene = [MLSDKScene sceneForPath:pathStr params:customParams];
        __weak typeof (self) weakSelf = self;
        [MobLink getMobId:scene result:^(NSString *mobId, NSString *domain, NSError *error) {
            if (error || !mobId || !domain) {
                NSLog(@"error =========+%@",error);
                return ;
            }
            weakSelf.mobid = mobId;
            weakSelf.domain = domain;
            NSMutableDictionary *shareParams = [NSMutableDictionary dictionaryWithCapacity:1];
            weakSelf.shareParams = shareParams;
            weakSelf.urlStr = [domain stringByAppendingString:mobId];
            [shareParams SSDKSetupShareParamsByText:@"text" images:@"http://ww4.sinaimg.cn/bmiddle/005Q8xv4gw1evlkov50xuj30go0a6mz3.jpg" url:[NSURL URLWithString:weakSelf.urlStr] title:@"游戏中国" type:SSDKContentTypeWebPage];
            
            [ShareSDK showShareActionSheet:nil customItems:nil shareParams:shareParams sheetConfiguration:nil onStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                UIAlertController *shareAlertC = nil;
                if (state == SSDKResponseStateSuccess) {
                   shareAlertC = [NSObject setAlerControlelrWithControllerTitle:nil controllerMessage:@"分享成功" actionTitle:@"确定"];
                }else if (state == SSDKResponseStateCancel){
                    shareAlertC = [NSObject setAlerControlelrWithControllerTitle:nil controllerMessage:@"分享取消" actionTitle:@"确定"];
                }else if (state == SSDKResponseStateCancel){
                    shareAlertC = [NSObject setAlerControlelrWithControllerTitle:nil controllerMessage:@"分享失败" actionTitle:@"确定"];
                }
             
                [self presentViewController:shareAlertC animated:nil completion:nil];
            }];
        }];
}


-(void)viewWillAppear:(BOOL)animated
{
    [self httpRequestInquiry];
}

@end
