//
//  MakeDiaryViewController.m
//  DailyDiary
//
//  Created by mob on 2019/9/3.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import "MakeDiaryViewController.h"
#import "MakeDiaryView.h"

@interface MakeDiaryViewController ()

@end

@implementation MakeDiaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupViewInfo];
    
}

-(void)setupViewInfo
{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
//    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] init];
//    backButtonItem.title = @"返回";
//    self.navigationItem.backBarButtonItem = backButtonItem;
    self.navigationItem.titleView = [[titleDateView alloc] init];
}

@end
