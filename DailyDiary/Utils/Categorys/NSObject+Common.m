//
//  NSObject+Common.m
//  DailyDiary
//
//  Created by mob on 2019/9/18.
//  Copyright © 2019 howhyone. All rights reserved.
//https://www.jianshu.com/p/4e2d575bb3e0

#import "NSObject+Common.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <CommonCrypto/CommonRandom.h>
#import <CommonCrypto/CommonCrypto.h>
#import <CoreText/CoreText.h>

#define kBaseURLStr @"https://coding.net/"


@implementation NSObject (Common)

-(NSString *)getBaseUrl
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault objectForKey:@"kBaseURLStr"] ?:kBaseURLStr;
    
}

+(NSString *)getcarrierName{
    CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [telephonyInfo subscriberCellularProvider];
    NSString *currentCountry=[carrier carrierName];
    NSString *carrierNameStr = nil;
    if ([currentCountry isEqualToString:@"中国联通"]) {
        carrierNameStr = @"CUCC";
    }else if ([currentCountry isEqualToString:@"中国移动"]){
        carrierNameStr = @"CMCC";
    }else if ([currentCountry isEqualToString:@"中国电信"]){
        carrierNameStr = @"CTCC";
    }else{
        DebugLog(@"不是真机或未插手机卡");
    }
    return carrierNameStr;
}

+(NSString *)currentItmeStr
{
    NSDate *currentDate = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval TimeInterval = [currentDate timeIntervalSince1970] * 1000;
    NSString *TimeStr = [NSString stringWithFormat:@"%f",TimeInterval];
    return TimeStr;
}

+(NSString *)getCurrentDate
{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *currentDateFormatter = [[NSDateFormatter alloc] init];
    currentDateFormatter.dateFormat = @"yyyyMMdd";
    NSString *currentDateStr = [currentDateFormatter stringFromDate:currentDate];
    return currentDateStr;
}

+(NSString *)getCurrentDateYearMonth
{
    NSDate *currentDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:currentDate];
    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    NSString *currentDateStr = @"";
    if (month < 10) {
        currentDateStr = [NSString stringWithFormat:@"%ld0%ld",year,month];
    }else{
        currentDateStr = [NSString stringWithFormat:@"%ld%ld",year,month];
    }
    return currentDateStr;
}

//  颜色转换为背景图片
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(NSString*)getWeekDay:(NSString*)currentStr

{
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc]init];//实例化一个NSDateFormatter对象
    
    [dateFormat setDateFormat:@"yyyyMMdd"];//设定时间格式,要注意跟下面的dateString匹配，否则日起将无效
    
    NSDate*date =[dateFormat dateFromString:currentStr];
    
    NSArray*weekdays = [NSArray arrayWithObjects: [NSNull null],@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",nil];
    
    NSCalendar*calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone*timeZone = [[NSTimeZone alloc]initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit =NSCalendarUnitWeekday;
    
    NSDateComponents*theComponents = [calendar components:calendarUnit fromDate:date];
    
    return[weekdays objectAtIndex:theComponents.weekday];
    
}

+(NSDateComponents *)getDateComponentsDate:(NSString *)dateStr
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSDate *currentDate = [dateFormatter dateFromString:dateStr];
    comps = [calendar components:unitFlags fromDate:currentDate];
    return comps;
}


+(int)compareOneDay:(NSString *)oneDayStr withAnotherDay:(NSString *)anotherDayStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
 
    [dateFormatter setDateFormat:@"yyyyMM"];
 
//    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
//
//    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
 
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
 
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
 
    NSComparisonResult result = [dateA compare:dateB];
 
    if (result == NSOrderedDescending) {
        //NSLog(@"oneDay比 anotherDay时间晚");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"oneDay比 anotherDay时间早");
        return -1;
    }
    //NSLog(@"两者时间是同一个时间");
    return 0;
}

// 图片压缩
+ (NSData *)imageData:(UIImage *)myimage
{
    NSData *pngData = UIImagePNGRepresentation(myimage);
    
    NSData *data = UIImageJPEGRepresentation(myimage, 1.0);
    if (data.length > 100 * 1024) {
        if (data.length > 1024 * 1024) {// 1M以及以上
            data = UIImageJPEGRepresentation(myimage, 0.1);
        }else if (data.length > 512 * 1024) {// 0.5M-1M
            data = UIImageJPEGRepresentation(myimage, 0.5);
        }else if (data.length > 200 * 1024) {// 0.25M-0.5M
            data = UIImageJPEGRepresentation(myimage, 0.9);
        }
    }
    return data;
}
- (NSString *)randomString:(NSInteger)length
{
        length = length/2;
        unsigned char digest[length];
        CCRNGStatus status = CCRandomGenerateBytes(digest, length);
        NSString *s = nil;
        if (status == kCCSuccess) {
            s = [self stringFrom:digest length:length];
        } else {
            s = @"";
        }
        NSLog(@"randomLength---:%@",s);
        return s;
}
//将bytes转为字符串
- (NSString *)stringFrom:(unsigned char *)digest length:(NSInteger)leng {
    NSMutableString *string = [NSMutableString string];
    for (int i = 0; i < leng; i++) {
        [string appendFormat:@"%02x",digest[i]];
    }
    NSLog(@"final stringFrom:%@",string);
    return string;
}

-(NSString *)randomChineseName:(NSInteger )integer
{
    NSArray *surnameArr = @[@"沈",@"秦",@"云",@"唐",@"高",@"裴",@"萧",@"上官",@"慕容",@"司徒",@"南宫",@"百里",@"北宫",@"月",@"楚",@"言",@"琴",@"古",@"镜",@"龙",@"冷",@"叶",@"北冥",@"公孙",@"独孤",@"皇甫",@"尚",@"闻人",@"苍羽",@"轩辕",@"南风",@"即墨"];
    NSArray *nameArr = @[@"浩",@"凌风",@"绝尘",@"文昭",@"阳城",@"文",@"奇",@"华晨",@"鹤城",@"袁也",@"成飞",@"哲七",@"鸿远",@"正",@"心池",@"池",@"心",@"阅",@"光",@"水",@"翰",@"和",@"清",@"易",@"宣",@"德",@"茂",@"明",@"纬",@"寺",@"明",@"晖",@"飞语",@"文哲",@"真",@"嘉",@"一",@"",@"寒",@"亦凌",@"宇",@"莫离",@"陵",@"宇轩",@"晨浩",@"痕",@"渊",@"尚城",@"离",@"陌",@"渡",@"陌然"];
    NSInteger surnameInteger = arc4random()%surnameArr.count;
    NSInteger nameInteger = arc4random()%nameArr.count;
    NSString *randomNameStr = [NSString stringWithFormat:@"%@%@",surnameArr[surnameInteger],nameArr[nameInteger]];
    
    
//    NSStringEncoding ranEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//    NSInteger randomH = 0xA1 + arc4random()%(0xFE - 0xA1 + 1);
//    NSInteger randomL = 0xB0+arc4random()%(0xF7 - 0xB0+1);
//    NSInteger number = (randomH<<8)+randomL;
//    NSData *randomData = [NSData dataWithBytes:&number length:2];
//    NSString *randomNameStr = [[NSString alloc] initWithData:randomData encoding:ranEncoding];
    
    return randomNameStr;
}

+(UIAlertController *)setAlerControlelrWithControllerTitle:(nullable NSString *)controllerTitleStr controllerMessage:(nullable NSString *)controllerMessageStrStr cancelActionTitle:(nullable NSString *)cancelActionTitleStr okActionTitle:(nullable NSString *)okActionTitleStr handler:(void (^ __nullable)(UIAlertAction *action))handler
{
    UIAlertController *delectedActionC = [UIAlertController alertControllerWithTitle:controllerTitleStr message:controllerMessageStrStr preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelActionTitleStr style:UIAlertActionStyleCancel handler:nil];

     UIAlertAction *okAction = [UIAlertAction actionWithTitle:okActionTitleStr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         handler(action);
     }];
    [delectedActionC addAction:cancelAction];
     [delectedActionC addAction:okAction];
     return delectedActionC;
}


+(UIAlertController *)setAlerControlelrWithControllerTitle:(nullable NSString *)controllerTitleStr controllerMessage:(nullable NSString *)controllerMessageStrStr actionTitle:(nullable NSString *)actionTitleStr
{
    UIAlertController *shareAlertC = [UIAlertController alertControllerWithTitle:controllerTitleStr message:controllerMessageStrStr preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:actionTitleStr style:UIAlertActionStyleDefault handler:nil];
    [shareAlertC addAction:okAction];
    return shareAlertC;
}


+(UIActivityIndicatorView *)setActivityIndicator
{
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.frame = CGRectMake(kScreen_Width/2, kScreen_Height/2, 100, 100);
    activityIndicator.hidesWhenStopped = YES;
    return activityIndicator;
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
                
            } else {
            }
            // 设置标志
            errorDuringDownload = YES;
            
        }
        
        return (BOOL)YES;
    });
}

+ (void)printAllFonts
{
    NSArray *fontFamilies = [UIFont familyNames];
 
    for (NSString *fontFamily in fontFamilies)
    {
        NSArray *fontNames = [UIFont fontNamesForFamilyName:fontFamily];
        NSLog (@"fontFamily=====%@:fontNames====== %@", fontFamily, fontNames);
    }
}

+(NSString *)currentFontName:(NSString *)fileName withFileType:(NSString *)fileType
{
    NSString *fontFilePath = [[NSBundle mainBundle] pathForResource:fileName ofType:fileType];
    NSURL *fontFileUrl = [NSURL fileURLWithPath:fontFilePath];
    CGDataProviderRef fontDataProvider = CGDataProviderCreateWithURL((__bridge CFURLRef)fontFileUrl);
    CGFontRef fontRef = CGFontCreateWithDataProvider(fontDataProvider);
    CGDataProviderRelease(fontDataProvider);
    NSString *fontName = (__bridge NSString *)CGFontCopyFullName(fontRef);
    CGFontRelease(fontRef);
    return fontName;
}

@end
