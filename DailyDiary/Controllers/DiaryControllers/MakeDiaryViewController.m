//
//  MakeDiaryViewController.m
//  DailyDiary
//
//  Created by mob on 2019/9/3.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import "MakeDiaryViewController.h"
#import "MakeDiaryView.h"
#import "HomeViewController.h"
#import "LXCalender.h"

@interface MakeDiaryViewController ()<clickDateSelectorProtocol>
@property(nonatomic, strong)TitleDateView *titleDateView;
@property(nonatomic, strong)LXCalendarView *calendarView;
@property(nonatomic, strong)MakeDiaryView *makeDiaryView;
@end

@implementation MakeDiaryViewController
{
    UITapGestureRecognizer *tapGestureR;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupViewInfo];
    
}

-(void)setupViewInfo
{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(popHomeController)];
    _titleDateView = [[TitleDateView alloc] initWithFrame:CGRectMake(0, 0, 130 * kScale_Width, 21 * kScale_Height)];
    [self.navigationItem setTitleView:_titleDateView];
     _titleDateView.dateDelegate = self;
    
    _makeDiaryView = [[MakeDiaryView alloc] initWithFrame:CGRectMake(0, kStateNavigationHeight, kScreen_Width, kScreen_Height)];
    [self.view addSubview:_makeDiaryView];
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShowzx:) name:UIKeyboardDidShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHidden) name:UIKeyboardDidHideNotification object:nil];
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
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

@end
