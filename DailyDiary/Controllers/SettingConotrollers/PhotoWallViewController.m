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
#import "PicturesListModel.h"

@interface PhotoWallViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic, strong)UICollectionView *photoWallCollectionView;
@property(nonatomic, strong)NSArray *pictureArr;
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

#pragma mark --------- 网络请求接口
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

-(void)httpRequestPicturesList
{
    WeakSelf(weakSelf);
    NSString *phoneStr = [[NSUserDefaults standardUserDefaults] objectForKey:kPhoneKey];
    NSMutableDictionary *netMutableDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [netMutableDic setObject:phoneStr forKey:@"phone"];
    NSString *pathStr = @"/mob_diary/diary/picturesList";
    [[HYOCoding_NetAPIManager sharedManager] request_PicturesList_WithPath:pathStr Params:netMutableDic andBlock:^(id  _Nonnull data, NSError * _Nonnull error) {
        if (data && !error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.pictureArr = data;
                [weakSelf.photoWallCollectionView reloadData];
            });
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRGBHex:0xf5f6f8]];
    [self.view addSubview:self.photoWallCollectionView];
    [_photoWallCollectionView setBackgroundColor:[UIColor colorWithRGBHex:0xf5f6f8]];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self httpRequestPicturesList];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _pictureArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoWallCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoWallCollectionViewCell" forIndexPath:indexPath];
    cell.picturesListM = _pictureArr[indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
//    [self httpRequestDetail];
    
    MakeDiaryViewController *makeDiaryVC = [[MakeDiaryViewController alloc] init];
    PhotoWallCollectionViewCell *cell = (PhotoWallCollectionViewCell *)[self collectionView:collectionView cellForItemAtIndexPath:indexPath];
    PicturesListModel *picturesListM = [[PicturesListModel alloc] init];
    picturesListM =  _pictureArr[indexPath.row];
    makeDiaryVC.dateStr = picturesListM.date;
    [self.navigationController pushViewController:makeDiaryVC animated:YES];
    
}

@end
