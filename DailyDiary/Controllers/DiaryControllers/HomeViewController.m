//
//  HomeViewController.m
//  DailyDiary
//
//  Created by mob on 2019/8/28.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"
#import "MJRefresh.h"
#import "MakeDiaryViewController.h"
#import "SettingViewController.h"
#import "SearchDiaryViewController.h"


@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *homeTableView;
@end

@implementation HomeViewController

static NSString * const kJJMainVCReuseIdentify = @"kJJMainVCReuseIdentify";


-(UITableView *)homeTableView
{
    if (!_homeTableView) {
        _homeTableView = [[UITableView alloc] initWithFrame:CGRectMake(15, kStateNavigationHeight, 345 * kScale_Width, kScreen_Height) style:UITableViewStylePlain];
        _homeTableView.delegate = self;
        _homeTableView.dataSource = self;
        [_homeTableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"HomeTableViewCell"];
        [_homeTableView registerClass:[ImageTextTableViewCell class] forCellReuseIdentifier:@"ImageTextTableViewCell"];
        _homeTableView.showsVerticalScrollIndicator = NO;
        _homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _homeTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewInfo];
}

-(void)setupViewInfo
{
    [self.view setBackgroundColor:[UIColor colorWithRGBHex:0xf5f6f8]];
    UILabel *titleLabel = [UILabel labelWithFont:15.0 WithText:@"DAYDAY日记" WithColor:0x151718];
    self.navigationItem.titleView = titleLabel;
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"设置"] style:UIBarButtonItemStylePlain target:self action:@selector(clickSetting)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    [self.view addSubview:self.homeTableView];
    
//    _homeTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downFreshloadData)];
//    [_homeTableView.mj_header beginRefreshing];
//
//    _homeTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upFreshLoadMoreData)];
//    [_homeTableView.mj_footer beginRefreshing];
    
    UIView *bottomView = [[UIView alloc] init];
    [bottomView setBackgroundColor:[UIColor colorWithRGBHex:0x151718]];
    bottomView.layer.cornerRadius = 25;
    bottomView.layer.masksToBounds = YES;
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.bottom).offset(-20 * kScale_Height);
        make.right.equalTo(self.view.right).offset(-20 * kScale_Height);
        make.width.equalTo(50 * kScale_Width);
        make.height.equalTo(100 * kScale_Height);
    }];
    UIButton *writeBtn = [UIButton buttonWithImage:@"写"];
    [writeBtn addTarget:self action:@selector(clickMakeDiary) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:writeBtn];
    [writeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.top).offset(14 * kScale_Height);
        make.left.equalTo(bottomView.left).offset(14 * kScale_Width);
        make.right.equalTo(bottomView.right).offset(-14 * kScale_Width);
        make.height.equalTo(23 * kScale_Width);
    }];
    UIView *lineView = [[UIView alloc] init];
    [lineView setBackgroundColor:[UIColor colorWithRGBHex:0xf5f6f8]];
    [bottomView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(writeBtn.bottom).offset(12 * kScale_Height);
        make.centerX.equalTo(writeBtn.centerX).offset(0);
        make.width.equalTo(34 * kScale_Width);
        make.height.equalTo(1 * kScale_Height);
    }];
    
    UIButton *searchBtn = [UIButton buttonWithImage:@"搜索"];
    [searchBtn addTarget:self action:@selector(clickSearchDiary) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:searchBtn];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.bottom).offset(12 * kScale_Height);
        make.centerX.equalTo(lineView.centerX).offset(0);
        make.width.equalTo(22 * kScale_Width);
        make.height.equalTo(22 * kScale_Width);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 117 * kScale_Height;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 37 * kScale_Height;
//}

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
#pragma mark -----------按钮点击事件
-(void)clickSetting
{
    SettingViewController *settingVC = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:NO];
}

-(void)clickMakeDiary
{
    MakeDiaryViewController *makeDiaryVC = [[MakeDiaryViewController alloc] init];
    [self.navigationController pushViewController:makeDiaryVC animated:NO];
}

-(void)clickSearchDiary
{
    SearchDiaryViewController * searchDiaryVC = [[SearchDiaryViewController alloc] init];
    [self.navigationController pushViewController:searchDiaryVC animated:YES];
}
//下拉刷新
- (void)downFreshloadData
{
    //这里加入的是网络请求，带上相关参数，利用网络工具进行请求。我这里没有网络就模拟一下数据吧。
    //网络不管请求成功还是失败都要结束更新。
    NSLog(@"我在下拉刷新");
    __weak typeof(self) weakSelf = self;
    //利用延时函数模拟网络加载
//    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC));
//    dispatch_after(time, dispatch_get_main_queue(), ^{
//        [weakSelf.homeTableView.mj_header endRefreshing];
//        [weakSelf.homeTableView reloadData];
//    });
}
//上拉加载更多
- (void)upFreshLoadMoreData
{
    //在这里上拉加载更多，将加载的数据拼接在数据源后面就可以了。
    //利用延时函数模拟网络加载
    __weak typeof(self) weakSelf = self;

    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC));
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [weakSelf.homeTableView.mj_footer endRefreshing];
        [weakSelf.homeTableView reloadData];
    });
}
@end
