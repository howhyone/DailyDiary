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
#import "DiaryListModel.h"

#import <MobAD/MobAD.h>
#import "FLAnimatedImage.h"

static NSString *dataStr = nil;

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *homeTableView;
@property(nonatomic, strong)NSArray *diaryModelArr;
@property(nonatomic, strong)DiaryListModel *diaryListM;
@property(nonatomic, strong) UIActivityIndicatorView *homeActivityIV;
@property(nonatomic, strong) MJRefreshBackNormalFooter *refreshFooter;

@end

@implementation HomeViewController

static NSString * const kJJMainVCReuseIdentify = @"kJJMainVCReuseIdentify";


-(UITableView *)homeTableView
{
    if (!_homeTableView) {
        CGFloat stateNavigationHeight = kStateNavigationHeight;
        _homeTableView = [[UITableView alloc] initWithFrame:CGRectMake(15, kStateNavigationHeight, 345 * kScale_Width, kScreen_Height - stateNavigationHeight) style:UITableViewStylePlain];
        _homeTableView.delegate = self;
        _homeTableView.dataSource = self;
        [_homeTableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"HomeTableViewCell"];
        [_homeTableView registerClass:[ImageTextTableViewCell class] forCellReuseIdentifier:@"ImageTextTableViewCell"];
        _homeTableView.showsVerticalScrollIndicator = NO;
        _homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        UILabel *footLabel = [UILabel labelWithFont:13.0 WithText:@"~到底啦~" WithColor:0x151718];
        footLabel.frame = CGRectMake(0, 0, kScreen_Width, 26);
        footLabel.textAlignment = NSTextAlignmentCenter;
        _homeTableView.tableFooterView =footLabel;
    }
    return _homeTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRGBHex:0xf5f6f8]];
    _homeActivityIV = [NSObject setActivityIndicator];
    [self.view addSubview:_homeActivityIV];
    [self setupViewInfo];


}

-(void)httpRequest:(NSString *)httpDateStr withRefreshTag:(NSString *)refreshTag
{
    [_homeActivityIV startAnimating];
    WeakSelf(weakSelf);
    NSString *phoneStr = [[NSUserDefaults standardUserDefaults] objectForKey:kPhoneKey];
    NSMutableDictionary *netMutableDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [netMutableDic setObject:httpDateStr forKey:@"time"];
    [netMutableDic setObject:phoneStr forKey:@"phone"];
    NSString *pathStr = @"/mob_diary/diary/list";
    [[HYOCoding_NetAPIManager sharedManager] request_ListDiary_WithPath:pathStr Params:netMutableDic andBlock:^(id  _Nonnull data, NSError * _Nonnull error) {
        if (data && !error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.homeActivityIV stopAnimating];
                weakSelf.diaryModelArr = (NSArray *)data;
                [weakSelf.homeTableView reloadData];
                if ([refreshTag isEqualToString:@"downFresh"]) {
                    [weakSelf.homeTableView.mj_header endRefreshing];
                }else if ([refreshTag isEqualToString:@"upFresh"]){
                    [weakSelf.homeTableView.mj_footer endRefreshing];
                }
            });
        }
    }];
}

-(void)setupViewInfo
{
    UILabel *titleLabel = [UILabel labelWithFont:15.0 WithText:@"DAYDAY日记" WithColor:0x151718];
    self.navigationItem.titleView = titleLabel;
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"设置"] style:UIBarButtonItemStylePlain target:self action:@selector(clickSetting)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    [self.view addSubview:self.homeTableView];
    
    _homeTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downFreshloadData)];

    _refreshFooter = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upFreshLoadMoreData)];
    _homeTableView.mj_footer = _refreshFooter;
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
    return _diaryModelArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 117 * kScale_Height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 26.0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    _diaryListM = _diaryModelArr[indexPath.row];
    if (!_diaryListM.img) { //
        HomeTableViewCell *homeCell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableViewCell"];
        homeCell.selectionStyle = UITableViewCellSelectionStyleNone;
        homeCell.diaryListM = _diaryListM;
        return homeCell;
    }else{
        ImageTextTableViewCell *imageTextCell = [tableView dequeueReusableCellWithIdentifier:@"ImageTextTableViewCell"];
        imageTextCell.selectionStyle = UITableViewCellSelectionStyleNone;
        imageTextCell.diaryListM = _diaryListM;
        return imageTextCell;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    MakeDiaryViewController *makeDiaryVC = [[MakeDiaryViewController alloc] init];
    _diaryListM = _diaryModelArr[indexPath.row];
    makeDiaryVC.dateStr = _diaryListM.date;
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kRequestDiaryDetailBoolKRey];
    [self.navigationController pushViewController:makeDiaryVC  animated:YES];
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
    makeDiaryVC.dateStr = [NSObject getCurrentDate];
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
    NSLog(@"我在下拉刷新");
    NSString *yearStr = [dataStr substringToIndex:4];
    NSString *monthStr = [dataStr substringFromIndex:4];
    uint yearInt = [yearStr intValue];
    uint monthInt = [monthStr intValue];
    if (monthInt <= 12 && monthInt > 0) {
        monthInt --;
    }else{
        monthInt = 12;
        yearInt --;
    }
    if (monthInt < 10) {
        monthStr = [NSString stringWithFormat:@"0%d",monthInt];
    }else{
        monthStr = [NSString stringWithFormat:@"%d",monthInt];
    }
    self.homeTableView.tableFooterView.hidden = YES;
    self.homeTableView.scrollsToTop = YES;
    dataStr = [NSString stringWithFormat:@"%d%@",yearInt,monthStr];
    [self httpRequest:dataStr withRefreshTag:@"downFresh"];
}
//上拉加载更多
- (void)upFreshLoadMoreData
{
    NSString *currentDataStr = [NSObject getCurrentDateYearMonth];
    int dateInt = [NSObject compareOneDay:dataStr withAnotherDay:currentDataStr];
    self.homeTableView.scrollsToTop = YES;

    if (dateInt == 0) {
        [_homeTableView.mj_footer endRefreshing];
        _refreshFooter.stateLabel.hidden = YES;
        _homeTableView.tableFooterView.hidden = NO;
        return;
    }
    NSString *yearStr = [dataStr substringToIndex:4];
    NSString *monthStr = [dataStr substringFromIndex:4];
    uint yearInt = [yearStr intValue];
    uint monthInt = [monthStr intValue];
    if (monthInt < 12) {
        monthInt ++;
    }else{
        monthInt = 1;
        yearInt ++;
    }
    if (monthInt < 10) {
        monthStr = [NSString stringWithFormat:@"0%d",monthInt];
    }else{
        monthStr = [NSString stringWithFormat:@"%d",monthInt];
    }
    dataStr = [NSString stringWithFormat:@"%d%@",yearInt,monthStr];
    [self httpRequest:dataStr withRefreshTag:@"upFresh"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!dataStr) {
        dataStr = [NSObject getCurrentDateYearMonth];
    }
    [self httpRequest:dataStr withRefreshTag:@""];
}

@end
