//
//  PhotoWallViewController.m
//  DailyDiary
//
//  Created by mob on 2019/9/11.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import "PhotoWallViewController.h"
#import "PhotoWallCollectionViewCell.h"
#import "MakeDiaryViewController.h"

@interface PhotoWallViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic, strong)UICollectionView *photoWallCollectionView;

@end

@implementation PhotoWallViewController

-(UICollectionView *)photoWallCollectionView
{
    if (!_photoWallCollectionView) {
        UICollectionViewFlowLayout *photoWallLayout = [[UICollectionViewFlowLayout alloc] init];
        photoWallLayout.itemSize = CGSizeMake(170 * kScale_Width, 170 * kScale_Width);
        photoWallLayout.sectionInset = UIEdgeInsetsMake(17, 10, 10, 10);
        
        _photoWallCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kStateNavigationHeight, kScreen_Width, kScreen_Height) collectionViewLayout:photoWallLayout];
        [_photoWallCollectionView registerClass:[PhotoWallCollectionViewCell class] forCellWithReuseIdentifier:@"PhotoWallCollectionViewCell"];
        _photoWallCollectionView.delegate = self;
        _photoWallCollectionView.dataSource = self;
        
    }
    return _photoWallCollectionView;
}

-(void)httpRequestDetail
{
    NSString *currentTimeStr = [NSObject getCurrentDateYearMonth];
    NSString *phoneStr = [[NSUserDefaults standardUserDefaults] objectForKey:kPhoneKey];
    NSMutableDictionary *netMutableDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [netMutableDic setObject:@"20190918" forKey:@"time"];
    [netMutableDic setObject:phoneStr forKey:@"phone"];
    NSString *pathStr = @"/mob_diary/diary/detail";
    [[HYOCoding_NetAPIManager sharedManager] request_DetailDiary_WithPath:pathStr Params:netMutableDic andBlock:^(id  _Nonnull data, NSError * _Nonnull error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRGBHex:0xf5f6f8]];
    [self.view addSubview:self.photoWallCollectionView];
    [_photoWallCollectionView setBackgroundColor:[UIColor colorWithRGBHex:0xf5f6f8]];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoWallCollectionViewCell" forIndexPath:indexPath];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self httpRequestDetail];
    
    MakeDiaryViewController *makeDiaryVC = [[MakeDiaryViewController alloc] init];
    [self.navigationController pushViewController:makeDiaryVC animated:YES];
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
