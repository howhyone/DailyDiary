//
//  HomeViewController.m
//  DailyDiary
//
//  Created by mob on 2019/8/28.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *homeTableView;
@end

@implementation HomeViewController

-(UITableView *)homeTableView
{
    if (!_homeTableView) {
        _homeTableView = [[UITableView alloc] initWithFrame:CGRectMake(15, kStateNavigationHeight, 345 * kScale_Width, kScreen_Height) style:UITableViewStylePlain];
        _homeTableView.delegate = self;
        _homeTableView.dataSource = self;
        [_homeTableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"HomeTableViewCell"];
        [_homeTableView registerClass:[ImageTextTableViewCell class] forCellReuseIdentifier:@"ImageTextTableViewCell"];
        _homeTableView.showsVerticalScrollIndicator = NO;
    }
    return _homeTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewInfo];
}

-(void)setupViewInfo
{
    [self.view setBackgroundColor:[UIColor colorWithRed:245 green:246 blue:248 alpha:1.0]];
    UILabel *titleLabel = [UILabel labelWithFont:15.0 WithText:@"DAYDAY日记" WithColor:0x151718];
    self.navigationItem.titleView = titleLabel;
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"设置"] style:UIBarButtonItemStylePlain target:self action:@selector(clickSetting)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    
    [self.view addSubview:self.homeTableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80 * kScale_Height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 37 * kScale_Height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (true) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"ImageTextTableViewCell"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
#pragma mark -----------按钮点击时间
-(void)clickSetting
{
    
}

@end
