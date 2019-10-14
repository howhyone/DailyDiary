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
#import "DiaryDetailModel.h"


@interface MakeDiaryViewController ()<clickDateSelectorProtocol,clickKeyboardToolBarItemDelegate,TZImagePickerControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic, strong)TitleDateView *titleDateView;
@property(nonatomic, strong)LXCalendarView *calendarView;
@property(nonatomic,strong) NSMutableArray *selectionPhotoArray;
@property(nonatomic, strong)UICollectionView *diaryCollectionView;
@property(nonatomic, assign)NSUInteger imageCount;
@property(nonatomic, strong)DiaryDetailModel *diaryDetailM;
@property(nonatomic, assign)NSUInteger requestImageCount;
@property(nonatomic, strong)NSArray *requestImageArr;
@property(nonatomic, strong)NSMutableArray *totalImageMutableArr;
@property (nonatomic, strong) UIActivityIndicatorView * activityIndicator;

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
    _totalImageMutableArr = [[NSMutableArray alloc] initWithCapacity:1];
    [self setupViewInfo];
    
}
#pragma mark --------网络请求
-(void)httpRequestDetailWithDate:(NSString *)dateStr
{
    WeakSelf(weakSelf);
    NSString *phoneStr = [[NSUserDefaults standardUserDefaults] objectForKey:kPhoneKey];
    NSMutableDictionary *netMutableDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [netMutableDic setObject:dateStr forKey:@"time"];
    [netMutableDic setObject:phoneStr forKey:@"phone"];
    NSString *pathStr = @"/mob_diary/diary/detail";
    [_activityIndicator startAnimating];

    [[HYOCoding_NetAPIManager sharedManager] request_DetailDiary_WithPath:pathStr Params:netMutableDic andBlock:^(id  _Nonnull data, NSError * _Nonnull error) {
        if (data && !error) {
            NSLog(@"data ============ %@",data);
            [weakSelf.activityIndicator stopAnimating];

            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.makeDiaryView.diaryDetailM = data;
                NSString *photoTotal = weakSelf.makeDiaryView.diaryDetailM.img;
                if (photoTotal.length) {
                    weakSelf.httpRequestImageArr = [photoTotal componentsSeparatedByString:@";"];
                    weakSelf.requestImageCount = weakSelf.httpRequestImageArr.count;
                    if (weakSelf.totalImageMutableArr.count == 0) {
                        [weakSelf.totalImageMutableArr addObjectsFromArray:weakSelf.httpRequestImageArr];
                    }
                }
                [weakSelf.diaryCollectionView reloadData];
            });
        }
    }];
}

-(void)httpRequestEditDiaryWithTitle:(NSString *)titleStr WithDate:(NSString *)dateStr WithContext:(NSString *)contextStr WithFile:(NSArray *)fileArr
{
    WeakSelf(weakSelf);
    NSString *phoneStr = [[NSUserDefaults standardUserDefaults] objectForKey:kPhoneKey];
    NSMutableDictionary *paramsMutableDic = [NSMutableDictionary dictionaryWithCapacity:1];
    [paramsMutableDic setObject:titleStr forKey:@"title"];
    [paramsMutableDic setObject:dateStr forKey:@"date"];
    [paramsMutableDic setObject:contextStr forKey:@"context"];
    [paramsMutableDic setObject:phoneStr forKey:@"userId"];
    [paramsMutableDic setObject:fileArr forKey:@"file"];
    NSString *pathStr = @"/mob_diary/diary/edit";
    
    
    [_activityIndicator startAnimating];
    [[HYOCoding_NetAPIManager sharedManager] request_EditDiray_WithPath:pathStr Params:paramsMutableDic andBlock:^(id  _Nonnull data, NSError * _Nonnull error) {
        if (data && !error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"data ========%@",data);
//                weakSelf.diaryDetailM = [[DiaryDetailModel alloc] init];
//                weakSelf.diaryDetailM = data;
//                weakSelf.makeDiaryView.diaryDetailM = data;
                [weakSelf.activityIndicator stopAnimating];
                [weakSelf.navigationController popViewControllerAnimated:NO];
                
            });
        }
    }];
}

-(void)setupViewInfo
{
    __weak typeof(self) weakSelf = self;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(popHomeController)];
    _titleDateView = [[TitleDateView alloc] initWithFrame:CGRectMake(0, 0, 130 * kScale_Width, 21 * kScale_Height)];
    NSDateFormatter *titleDateFormatter = [[NSDateFormatter alloc] init];
    titleDateFormatter.dateFormat = @"yyyyMMdd";
    NSDate *titleDate = [titleDateFormatter dateFromString:_dateStr];
    titleDateFormatter.dateFormat = @"yyyy年 MM月dd日";
    NSString *titleStr = [titleDateFormatter stringFromDate:titleDate];
    _titleDateView.titleLabel.text = titleStr;
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
    
    _activityIndicator = [NSObject setActivityIndicator];
    [self.view addSubview:_activityIndicator];
}

-(void)setupDiaryCollectionView
{
    if (!_diaryCollectionView) {
        CGRect collectionViewFrame = CGRectMake(0, 400, kScreen_Width, 77 * kScale_Height);
        UICollectionViewFlowLayout *diaryFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        diaryFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        diaryFlowLayout.itemSize = CGSizeMake(105 * kScale_Width, 77 * kScale_Height);
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
    return _totalImageMutableArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"diaryImageCollectionViewCell" forIndexPath:indexPath];
    UIImageView *diaryImageView = [[UIImageView alloc] init];
    diaryImageView.frame = CGRectMake(0, 0, 105 * kScale_Width, 77 * kScale_Height);
    NSLog(@"row is %ld ---- _httpRequestImageArr.count is %ld------- _selectionPhotoArray.count is %ld",indexPath.row,_httpRequestImageArr.count,_selectionPhotoArray.count);
    
    id currentImageItem = [_totalImageMutableArr objectAtIndex:indexPath.row];
    if ([currentImageItem isKindOfClass:[NSString class]]) {
        [diaryImageView sd_setImageWithURL:[NSURL URLWithString:currentImageItem]];
    }else if ([currentImageItem isKindOfClass:[UIImage class]]){
        diaryImageView.image = currentImageItem;

    }
        
//    if (indexPath.row < _httpRequestImageArr.count && _httpRequestImageArr) {
//        [diaryImageView sd_setImageWithURL:[NSURL URLWithString:_httpRequestImageArr[indexPath.row]]];
//    }else if(_selectionPhotoArray){
//        diaryImageView.image = _selectionPhotoArray[indexPath.row - _httpRequestImageArr.count];
//    }
    
    diaryImageView.contentMode = UIViewContentModeScaleAspectFill;
    [cell addSubview:diaryImageView];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf(weakSelf);
    PhotoInfoViewController *photoInfoVC = [[PhotoInfoViewController alloc] init];
    [photoInfoVC setDeletedPhotoBlock:^(NSMutableArray *currentPhotoArr) {
        weakSelf.totalImageMutableArr = currentPhotoArr;
        [weakSelf.diaryCollectionView reloadData];
    }];
    
    photoInfoVC.photoInteger = indexPath.row;
//    [photoInfoVC.photoImageAr]
    photoInfoVC.photoImageArr = _totalImageMutableArr;
    [self.navigationController pushViewController:photoInfoVC animated:NO];
}

#pragma mark ----------按钮点击事件

-(void)popHomeController
{
    UIAlertController *makeDiaryAlterC = [[UIAlertController alloc] init];
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"保存并退出" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self clickKeyboardToolBarDoneItem];
    }];
    UIAlertAction *backAction = [UIAlertAction actionWithTitle:@"放弃保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:NO];

    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [makeDiaryAlterC addAction:saveAction];
    [makeDiaryAlterC addAction:backAction];
    [makeDiaryAlterC addAction:cancelAction];
    [self presentViewController:makeDiaryAlterC animated:YES completion:nil];
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
        NSString *monthStr = @"";
        NSString *dayStr = @"";
        if (month < 10 ) {
            monthStr = [NSString stringWithFormat:@"0%ld",month];
        }else{
            monthStr = [NSString stringWithFormat:@"%ld",month];
        }
        if (day < 10) {
            dayStr = [NSString stringWithFormat:@"0%ld",day];
        }else{
            dayStr = [NSString stringWithFormat:@"%ld",day];
        }
        NSString *dateStr = [NSString stringWithFormat:@"%ld%@%@",year,monthStr,dayStr];
        [self httpRequestDetailWithDate:dateStr];
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
    WeakSelf(weakSelf);
    BOOL requestDetailB = [[NSUserDefaults standardUserDefaults] boolForKey:kRequestDiaryDetailBoolKRey];
    if (requestDetailB) {
        [self httpRequestDetailWithDate:_dateStr];
//        [weakSelf.diaryCollectionView reloadData];

    }
    
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
    [_selectionPhotoArray removeAllObjects];
    __weak typeof(self) weakSelf= self;
    NSInteger Count =  9;//剩余可选图片数量
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:Count delegate:self];
    imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photo, NSArray * assets, BOOL isSelectOriginalPhoto) {
        for (NSInteger i = 0; i<photo.count; i++) {
            UIImage *img = photo[i];//压缩图片
            [weakSelf.selectionPhotoArray addObject:img];
        }
        [weakSelf.totalImageMutableArr addObjectsFromArray:weakSelf.selectionPhotoArray];
        [weakSelf.diaryCollectionView reloadData];
    }];
     [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kRequestDiaryDetailBoolKRey];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

-(void)clickKeyboardToolBarDoneItem
{
    NSString *titleStr = _makeDiaryView.titleTextField.text;
    if (titleStr.length < 1) {
        UIAlertController *alerController =  [NSObject setAlerControlelrWithControllerTitle:nil controllerMessage:@"标题不能为空" actionTitle:@"取消"];
        [self presentViewController:alerController animated:NO completion:nil];
        return;
    }
    
    NSString *contextStr = _makeDiaryView.diaryTextView.text;

    [self httpRequestEditDiaryWithTitle:titleStr WithDate:_dateStr WithContext:contextStr  WithFile:_totalImageMutableArr];
}

@end
