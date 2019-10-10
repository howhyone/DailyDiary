//
//  FontViewController.m
//  DailyDiary
//
//  Created by mob on 2019/9/17.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import "FontViewController.h"
#import "FontTableViewCell.h"
#import <CoreText/CoreText.h>

static NSInteger tagNum = -1;
static NSInteger selectedNum = 1;

@interface FontViewController ()<UITableViewDelegate,UITableViewDataSource,DownloadFontDelegate>
@property(nonatomic, strong)UITableView *fontTableView;
@property(nonatomic, strong)NSString *errorMessage;
@property(nonatomic, strong)UIImageView *currentImageView;
@end

@implementation FontViewController

-(UITableView *)fontTableView
{
    if (!_fontTableView) {
        _fontTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kStateNavigationHeight, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
        _fontTableView.delegate = self;
        _fontTableView.dataSource = self;
        [_fontTableView registerClass:[FontTableViewCell class] forCellReuseIdentifier:@"FontTableViewCell"];
        [_fontTableView setTableFooterView:[[UIView alloc] init]];
        _fontTableView.scrollEnabled = NO;
    }
    return _fontTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.fontTableView.tableHeaderView = [[FontTableViewHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 30 * kScale_Height)];
    [self.view addSubview:self.fontTableView];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30 * kScale_Height;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45 * kScale_Height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FontTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FontTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *fontNameArr = @[@"苹方字体",@"圆体",@"行楷"];
    cell.fontNameStr = fontNameArr[indexPath.row];
    selectedNum = [[NSUserDefaults standardUserDefaults] integerForKey:kSelectedCellKey];
   if (tagNum >= 3) {
       tagNum = 1;
   }else{
       tagNum += 1;
   }
   if (tagNum != selectedNum) {
       cell.selectedImageView.hidden = YES;
   }else{
       _currentImageView = cell.selectedImageView;
   }
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger rowInt = indexPath.row;
    FontTableViewCell *fontCell = [tableView cellForRowAtIndexPath:indexPath];
    _currentImageView.hidden = YES;
    fontCell.selectedImageView.hidden = NO;
    _currentImageView = fontCell.selectedImageView;
    switch (indexPath.row) {
        case 0:
            [self downloadFont:@"PingFangSC-Regular"];
            
        break;
        case 1:
            [self downloadFont:@"STYuanti-SC-Regular"];
            
        break;
        case 2:
            [self downloadFont:@"STXingkai-SC-Light"];
        break;
        default:
            break;
    }
    [[NSUserDefaults standardUserDefaults] setInteger:rowInt forKey:kSelectedCellKey];
}

-(BOOL)isFontDownloaded:(NSString *)fontName
{
    UIFont *afont = [UIFont fontWithName:fontName size:12.0];
    if (afont && ([afont.fontName compare:fontName] == NSOrderedSame || [afont.familyName compare:fontName] == NSOrderedSame)) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark ------------- 按钮的点击代理

-(void)downloadFont:(NSString *)fontStr
{
    NSString *xkFontName = [NSObject currentFontName:@"华文行楷" withFileType:@"ttf"];
    if ([fontStr isEqualToString:@"STXingkai-SC-Light"]) {
        fontStr = xkFontName;
        [[NSUserDefaults standardUserDefaults] setObject:fontStr forKey:kFontNameKey];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationFontName object:self];
        return;
    }
    NSString *ytFontName = [NSObject currentFontName:@"方正兰亭圆简体" withFileType:@"ttf"];
   if ([fontStr isEqualToString:@"STYuanti-SC-Regular"]) {
       fontStr = ytFontName;
       [[NSUserDefaults standardUserDefaults] setObject:fontStr forKey:kFontNameKey];
       [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationFontName object:self];
       return;
   }
    if ([self isFontDownloaded:fontStr]) {
        [[NSUserDefaults standardUserDefaults] setObject:fontStr forKey:kFontNameKey];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationFontName object:self];
        return;
    }
    NSMutableDictionary *attrs = [NSMutableDictionary dictionaryWithObjectsAndKeys:fontStr,kCTFontNameAttribute, nil];
    
    CTFontDescriptorRef desc = CTFontDescriptorCreateWithAttributes((__bridge CFDictionaryRef)attrs);
    NSMutableArray *descs = [NSMutableArray arrayWithCapacity:0];
    [descs addObject:(__bridge id)desc];
    CFRelease(desc);
    
    __block BOOL errorDuringDownload = NO;
    
    CTFontDescriptorMatchFontDescriptorsWithProgressHandler( (__bridge CFArrayRef)descs, NULL,  ^bool(CTFontDescriptorMatchingState state, CFDictionaryRef _Nonnull progressParameter) {
        
        double progressValue = [[(__bridge NSDictionary *)progressParameter objectForKey:(id)kCTFontDescriptorMatchingPercentage] doubleValue];
        
        if (state == kCTFontDescriptorMatchingDidBegin) {
            NSLog(@"字体已经匹配 ");
        } else if (state == kCTFontDescriptorMatchingDidFinish) {
            if (!errorDuringDownload) {
                NSLog(@"字体匹配完成%@", fontStr);
                dispatch_async( dispatch_get_main_queue(), ^ {
                     // 可以在这里修改 UI 控件的字体
                     [[NSUserDefaults standardUserDefaults] setObject:fontStr forKey:kFontNameKey];
                     [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationFontName object:self];
                         });
            }
        } else if (state == kCTFontDescriptorMatchingWillBeginDownloading) {
            NSLog(@" 字体开始下载 ");
        } else if (state == kCTFontDescriptorMatchingDidFinishDownloading) {
            NSLog(@" 字体下载完成 ");
            dispatch_async( dispatch_get_main_queue(), ^ {
                // 可以在这里修改 UI 控件的字体
                [[NSUserDefaults standardUserDefaults] setObject:fontStr forKey:kFontNameKey];
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationFontName object:self];                
            });
        } else if (state == kCTFontDescriptorMatchingDownloading) {
            NSLog(@" 下载进度 %.0f%% ", progressValue);
        } else if (state == kCTFontDescriptorMatchingDidFailWithError) {
            NSError *error = [(__bridge NSDictionary *)progressParameter objectForKey:(id)kCTFontDescriptorMatchingError];
            if (error != nil) {
                self->_errorMessage = [error description];
            } else {
                self->_errorMessage = @"ERROR MESSAGE IS NOT AVAILABLE!";
            }
            // 设置标志
            errorDuringDownload = YES;
            NSLog(@" 下载错误: %@", self->_errorMessage);
        }
        
        return (BOOL)YES;
    });
}

@end
