//
//  SearchDiaryViewController.m
//  DailyDiary
//
//  Created by mob on 2019/9/6.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import "SearchDiaryViewController.h"
#import "HomeTableViewCell.h"

@interface SearchDiaryViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *homeTableView;

@end

@implementation SearchDiaryViewController

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
    // Do any additional setup after loading the view.
    [self setupViewInfo];
}


-(void)setupViewInfo
{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UISearchBar *searchDiaryBar = [[UISearchBar alloc] init];
    searchDiaryBar.placeholder = @"搜索";
    [searchDiaryBar setImage:[UIImage imageNamed:@"搜索栏_搜索"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [searchDiaryBar setImage:[UIImage imageNamed:@"搜索栏_取消"] forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
    searchDiaryBar.frame = CGRectMake(0, 0, 300 * kScale_Width, 30 * kScale_Height);
    searchDiaryBar.delegate = self;
    [searchDiaryBar sizeToFit];
    [searchDiaryBar setInputAccessoryView:[[UIView alloc] init]];
    self.navigationItem.titleView = searchDiaryBar;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(clickBack)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self.view addSubview:self.homeTableView];

}

-(void)searchDiaryHttpRequestWithTitle:(NSString *)titleStr
{
    NSString *pathStr = @"/mob_diary/diary/listByTitle";
    NSMutableDictionary *netMutableDic = [NSMutableDictionary dictionaryWithCapacity:1];
    NSString *phoneStr = [[NSUserDefaults standardUserDefaults] objectForKey:kPhoneKey];
    [netMutableDic setObject:phoneStr forKey:@"phone"];
    [netMutableDic setObject:titleStr forKey:@"title"];
    [[HYOCoding_NetAPIManager sharedManager] request_SearchDiray_WithPath:pathStr Params:netMutableDic andBlock:^(id  _Nonnull data, NSError * _Nonnull error) {
        if (data && !error) {
            NSLog(@"-------");
        }
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


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.row % 2 == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"ImageTextTableViewCell"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark --------- searchBar text改变回调
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"textDidChange--------");
    [self searchDiaryHttpRequestWithTitle:searchText];
}

-(void)clickBack
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.hidesBackButton = YES;
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
