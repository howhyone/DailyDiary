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

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource,clickLogoutDelegate>
@property(nonatomic, strong)SettingTableViewCell *settingCell;
@property(nonatomic, strong)UITableView *settingTableView;
@property(nonatomic, strong)SettingHeaderView *settingHeaderView;

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
        _settingTableView.delegate = self;
        _settingTableView.dataSource = self;
        _settingTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [_settingTableView setBackgroundColor:[UIColor colorWithRGBHex:0xf5f5f5]];
        
        
    }
    return _settingTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    return 4;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
