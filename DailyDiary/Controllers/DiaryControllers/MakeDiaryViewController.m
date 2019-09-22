//
//  MakeDiaryViewController.m
//  DailyDiary
//
//  Created by mob on 2019/9/3.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import "MakeDiaryViewController.h"
#import "HomeViewController.h"
#import "LXCalender.h"
#import "PackageView.h"
#import <TZImagePickerController.h>
#import "PhotoInfoViewController.h"


@interface MakeDiaryViewController ()<clickDateSelectorProtocol,clickKeyboardToolBarItemDelegate,TZImagePickerControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic, strong)TitleDateView *titleDateView;
@property(nonatomic, strong)LXCalendarView *calendarView;
@property(nonatomic,strong) NSMutableArray *selectionPhotoArray;
@property(nonatomic, strong)UICollectionView *diaryCollectionView;
@property(nonatomic, assign)NSUInteger imageCont;
@end

@implementation MakeDiaryViewController
{
    UITapGestureRecognizer *tapGestureR;
}

-(NSMutableArray *)selectionPhotoArray
{
    if (!_selectionPhotoArray) {
        _selectionPhotoArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _selectionPhotoArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupViewInfo];
    
}
#pragma mark --------网络请求
-(void)httpRequestEditDiary
{
    NSString *phoneStr = [[NSUserDefaults standardUserDefaults] objectForKey:kPhoneKey];
    NSMutableDictionary *paramsMutableDic = [NSMutableDictionary dictionaryWithCapacity:1];
    [paramsMutableDic setObject:@"1" forKey:@"title"];
    [paramsMutableDic setObject:@"20190916" forKey:@"date"];
    [paramsMutableDic setObject:@"3" forKey:@"context"];
    [paramsMutableDic setObject:phoneStr forKey:@"userId"];
    NSMutableArray *mutableArr = [NSMutableArray arrayWithCapacity:1];
    [paramsMutableDic setObject:mutableArr forKey:@"files"];
    NSString *pathStr = @"/mob_diary/diary/edit";
    [[HYOCoding_NetAPIManager sharedManager] request_EditDiray_WithPath:pathStr Params:paramsMutableDic andBlock:^(id  _Nonnull data, NSError * _Nonnull error) {
        
    }];
}

-(void)setupViewInfo
{
    __weak typeof(self) weakSelf = self;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(popHomeController)];
    _titleDateView = [[TitleDateView alloc] initWithFrame:CGRectMake(0, 0, 130 * kScale_Width, 21 * kScale_Height)];
    [self.navigationItem setTitleView:_titleDateView];
     _titleDateView.dateDelegate = self;
    
    [self setupDiaryCollectionView];
    
    _makeDiaryView = [[MakeDiaryView alloc] init];
    _makeDiaryView.keyboardToolBarView.delegate = self;
    [self.view addSubview:_makeDiaryView];
    [_makeDiaryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(kStateNavigationHeight + 10 * kScale_Height);
        make.left.equalTo(self.view.left).offset(15 * kScale_Width);
        make.right.equalTo(self.view.right).offset(15 * kScale_Width);
        make.bottom.equalTo(weakSelf.diaryCollectionView.top).offset(10 * kScale_Height);
    }];
}


-(void)setupDiaryCollectionView
{
    if (!_diaryCollectionView) {
        CGRect collectionViewFrame = CGRectMake(0, 400, kScreen_Width, 77 * kScale_Height);
        UICollectionViewFlowLayout *diaryFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        diaryFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        diaryFlowLayout.itemSize = CGSizeMake(105 * kScale_Width, 77 * kScale_Height);
//        diaryFlowLayout.minimumInteritemSpacing =  15;
//        diaryFlowLayout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
        _diaryCollectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame collectionViewLayout:diaryFlowLayout];
        _diaryCollectionView.delegate = self;
        _diaryCollectionView.dataSource = self;
        _diaryCollectionView.showsHorizontalScrollIndicator = NO;
        _diaryCollectionView.bounces = NO;
        [_diaryCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"diaryImageCollectionViewCell"];
    }
    [self.view addSubview:_diaryCollectionView];
    [_diaryCollectionView setBackgroundColor:[UIColor whiteColor]];
    [_diaryCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(15 * kScale_Width);
        make.right.equalTo(self.view.right).offset(-15 * kScale_Width);
        make.bottom.equalTo(self.view.bottom).offset(-10 * kScale_Height);
        make.height.equalTo(77 * kScale_Height);
    }];
    return ;
}

#pragma mark -------- UICollectionView代理事件
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_selectionPhotoArray.count) {
        _imageCont = _selectionPhotoArray.count + _imageCont;
        return _imageCont;
    }else{
        return 1;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"diaryImageCollectionViewCell" forIndexPath:indexPath];
    UIImageView *diaryImageView = [[UIImageView alloc] initWithImage:_selectionPhotoArray[indexPath.row]];
    diaryImageView.frame = CGRectMake(0, 0, 105 * kScale_Width, 77 * kScale_Height);
    diaryImageView.contentMode = UIViewContentModeScaleAspectFill;
    [cell addSubview:diaryImageView];
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf(weakSelf);
    PhotoInfoViewController *photoInfoVC = [[PhotoInfoViewController alloc] init];
    [photoInfoVC setDeletedPhotoBlock:^(UIImage * _Nonnull deletedPhotoImage) {
        [weakSelf.selectionPhotoArray removeObject:deletedPhotoImage];
    }];
    photoInfoVC.photoImage = _selectionPhotoArray[indexPath.row];
    [self.navigationController pushViewController:photoInfoVC animated:NO];
}

#pragma mark ----------按钮点击事件

-(void)popHomeController
{
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark ---------- 按钮点击事件的代理
-(void)showCalendar
{
    
    if ([self.calendarView isDescendantOfView:self.view]) {
        [_calendarView removeFromSuperview];
        return;
    }
    
    LXCalendarView *calendarView = [[LXCalendarView alloc] initWithFrame:CGRectMake(0, kStateNavigationHeight, kScreen_Width, 334 * kScale_Height)];
    calendarView.currentMonthTitleColor = [UIColor colorWithRGBHex:0x333333];
    calendarView.lastMonthTitleColor = [UIColor colorWithRGBHex:0x333333];
    calendarView.nextMonthTitleColor = [UIColor colorWithRGBHex:0x333333];
    calendarView.isHaveAnimation = YES;
    calendarView.isCanScroll = YES;
    calendarView.isShowLastAndNextBtn = YES;
    calendarView.todayTitleColor = [UIColor colorWithRGBHex:0x1aa48a];
    calendarView.selectBackColor = [UIColor yellowColor];
    calendarView.isShowLastAndNextDate = NO;
    [calendarView dealData];
    calendarView.backgroundColor = [UIColor whiteColor];
    __weak typeof(self) weakSelf = self;
    calendarView.selectBlock = ^(NSInteger year, NSInteger month, NSInteger day) {
        NSLog(@"%ld年 - %ld月 - %ld日",year,month,day);
        weakSelf.titleDateView.titleLabel.text = [NSString stringWithFormat:@"%ld年 %ld月%ld日",year,month,day];
        
    };
    self.calendarView = calendarView;
    [self.view addSubview:calendarView];
    
    
}
-(void)hideCalendar
{
    [_calendarView removeFromSuperview];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_calendarView removeFromSuperview];
}

-(void)viewWillAppear:(BOOL)animated
{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShowzx:) name:UIKeyboardDidShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHidden) name:UIKeyboardDidHideNotification object:nil];
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated
{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
}

-(void)keyboardDidShowzx:(NSNotification *)notification
{
    tapGestureR =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureR.cancelsTouchesInView = NO;
    [_makeDiaryView.diaryTextView addGestureRecognizer:tapGestureR];
}

-(void)keyboardHide:(UITapGestureRecognizer *)tapGR
{
    [_makeDiaryView.diaryTextView resignFirstResponder];
    [_makeDiaryView.diaryTextView removeGestureRecognizer:tapGestureR];
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return true;
}

//添加相册图片
-(void)clickKeyboardToolBarAlbumItem
{
    __weak typeof(self) weakSelf= self;
    NSInteger Count =  9;//剩余可选图片数量
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:Count delegate:self];
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photo, NSArray * assets, BOOL isSelectOriginalPhoto) {
        for (NSInteger i = 0; i<photo.count; i++) {
            UIImage *img = photo[i];//压缩图片
            [weakSelf.selectionPhotoArray addObject:img];
        }
        [weakSelf.diaryCollectionView reloadData];
        
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

-(void)clickKeyboardToolBarDoneItem
{
    [self httpRequestEditDiary];
    [self.navigationController popViewControllerAnimated:NO];
}

@end
