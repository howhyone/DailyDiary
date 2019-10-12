//
//  PhotoInfoViewController.m
//  DailyDiary
//
//  Created by mob on 2019/9/22.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import "PhotoInfoViewController.h"
#import "PhotoInfoCollectionViewCell.h"

@interface PhotoInfoViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic, strong)UICollectionView *photoCollectionView;
@property(nonatomic, assign)NSInteger currentRow;
@property(nonatomic, strong)UILabel *titleLabel;
@end
int currentNum =0;
int totalNum = 0;
@implementation PhotoInfoViewController

-(UICollectionView *)photoCollectionView
{
    if (!_photoCollectionView) {
        UICollectionViewFlowLayout *photoFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        photoFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        photoFlowLayout.itemSize = CGSizeMake(kScreen_Width, kScreen_Width);
        photoFlowLayout.minimumLineSpacing = 0.00000000001;
        _photoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kStateNavigationHeight, kScreen_Width, kScreen_Width) collectionViewLayout:photoFlowLayout];
        [_photoCollectionView registerClass:[PhotoInfoCollectionViewCell class] forCellWithReuseIdentifier:@"PhotoInfoCollectionViewCell"];
        _photoCollectionView.pagingEnabled = YES;
        _photoCollectionView.bounces = NO;
        _photoCollectionView.delegate = self;
        _photoCollectionView.dataSource = self;
        [self.view addSubview:_photoCollectionView];
        [_photoCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.view.centerY).offset(0);
            make.centerX.equalTo(self.view.centerX).offset(0);
            make.width.equalTo(kScreen_Width);
            make.height.equalTo(kScreen_Width);
        }];
    }
    return _photoCollectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(clickBackBtn)];
    NSString *titleStr = [NSString stringWithFormat:@"%ld/%lu",(long)_photoInteger + 1,(unsigned long)_photoImageArr.count];
    UILabel *titleLabel = [UILabel labelWithFont:15.0 WithText:titleStr WithColor:0xffffff];
    self.titleLabel = titleLabel;
    self.navigationItem.titleView = self.titleLabel;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(clickDeletedBtn)];
    
    [self photoCollectionView];
    NSIndexPath *photoIndexPath = [NSIndexPath indexPathForRow:_photoInteger inSection:0];
    [_photoCollectionView scrollToItemAtIndexPath:photoIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _photoImageArr.count;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger pageInt = scrollView.contentOffset.x / kScreen_Width + 1;
    self.titleLabel.text = [NSString stringWithFormat:@"%ld/%lu",(long)pageInt,(unsigned long)_photoImageArr.count];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger pageInt = scrollView.contentOffset.x / kScreen_Width + 1;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSInteger pageInt = scrollView.contentOffset.x / kScreen_Width + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoInfoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoInfoCollectionViewCell" forIndexPath:indexPath];
    _currentRow = indexPath.row;
    id photoImage = _photoImageArr[indexPath.row];
    
    if ([photoImage isKindOfClass:[NSString class]]) {
        [cell.photoImageView sd_setImageWithURL:[NSURL URLWithString:photoImage]];
    }else if ([photoImage isKindOfClass:[UIImage class]]){
        [cell.photoImageView setImage:photoImage];
    }
    return cell;
}

#pragma mark ------------- 按钮点击事件
-(void)clickBackBtn
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)clickDeletedBtn
{
    WeakSelf(weakSelf);
    UIAlertController *delectedAlertC = [NSObject setAlerControlelrWithControllerTitle:nil controllerMessage:@"确定删除该图标吗" cancelActionTitle:@"取消" okActionTitle:@"确定" handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf.photoImageArr removeObjectAtIndex:weakSelf.currentRow];
        weakSelf.titleLabel.text = [NSString stringWithFormat:@"%ld/%lu",(long)weakSelf.currentRow,(unsigned long)weakSelf.photoImageArr.count];
        [weakSelf.photoCollectionView reloadData];
        if (weakSelf.deletedPhotoBlock) {
            weakSelf.deletedPhotoBlock(weakSelf.photoImageArr );
        }
    }];
    
    [self presentViewController:delectedAlertC animated:NO completion:nil];
}

@end
