//
//  PersonalInfoViewController.m
//  DailyDiary
//
//  Created by mob on 2019/8/20.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import "PersonalInfoViewController.h"
#import "PersonalInfoView.h"
#import <ShareSDK/ShareSDK.h>
#import <TZImagePickerController.h>

@interface PersonalInfoViewController ()<ClickButtonDelegate,TZImagePickerControllerDelegate>
@property(nonatomic, strong)PersonalInfoView *personalInfoView;
@property(nonatomic, strong)UIImage *selectionHeaderImage;
@end

@implementation PersonalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    _personalInfoView = [[PersonalInfoView alloc] initWithFrame:CGRectMake(0,kStateNavigationHeight,kScreen_Width,kScreen_Height)];
    _personalInfoView.delegate = self;
    
    [self httpRequestInquiry];
    [self.view addSubview:_personalInfoView];
}

-(void)httpRequestInquiry
{
    WeakSelf(weakSelf);
    NSString *phoneStr = [[NSUserDefaults standardUserDefaults] objectForKey:kPhoneKey];
    NSMutableDictionary *paramsMutableDic = [NSMutableDictionary dictionaryWithCapacity:1];
    [paramsMutableDic setObject:phoneStr forKey:@"phone"];
    NSString *pathStr = @"/mob_diary/user/info";
    [[HYOCoding_NetAPIManager sharedManager] request_UserInquiry_WithPath:pathStr Params:paramsMutableDic andBlock:^(id  _Nonnull data, NSError * _Nonnull error) {
        if (data && !error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.personalInfoView.personalInfoModel = data;
            });
        }
    }];
}
-(void)httpRequestUserEdit
{
    NSString *phoneStr = [[NSUserDefaults standardUserDefaults] objectForKey:kPhoneKey];
    NSMutableDictionary *paramsMutableDic = [NSMutableDictionary dictionaryWithCapacity:1];
    [paramsMutableDic setObject:phoneStr forKey:@"phone"];
    NSString *nameStr = _personalInfoView.nameTextField.text;
    [paramsMutableDic setObject:nameStr forKey:@"name"];
    UIImage *headerImage = _personalInfoView.headerImageView.image;
    [paramsMutableDic setObject:headerImage forKey:@"file"];
    NSString *pathStr = @"/mob_diary/user/edit";
    [[HYOCoding_NetAPIManager sharedManager] request_UserEdit_WithPath:pathStr Params:paramsMutableDic andBlock:^(id  _Nonnull data, NSError * _Nonnull error) {
        if (data && !error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:NO];
            });
        }
    }];
}

-(void)clickButton:(NSInteger)buttonTag
{
    switch (buttonTag) {
        case 1001: // 上传头像
        {
            NSLog(@"1001------");
            __weak typeof(self) weakSelf= self;
            NSInteger Count =  1;//剩余可选图片数量
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:Count delegate:self];
            imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photo, NSArray * assets, BOOL isSelectOriginalPhoto) {
                for (NSInteger i = 0; i<photo.count; i++) {
                    UIImage *img = photo[i];//压缩图片
                    weakSelf.selectionHeaderImage = img;
                    weakSelf.personalInfoView.headerImageView.image = img;
                }
            }];
            
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kRequestDiaryDetailBoolKRey];
            [self presentViewController:imagePickerVc animated:YES completion:nil];
        }
            break;
        case 1002: // 随机昵称
            NSLog(@"1002=====");
            break;
        case 1003: //提交个人资料
            NSLog(@"1003 =====");
            [self httpRequestUserEdit];
            break;
        case 1004: // 微信授权
            NSLog(@"1004------");
            [ShareSDK authorize:SSDKPlatformTypeWechat settings:nil onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
                if (!error) {
                    NSLog(@"------success");
                }else{
                    NSLog(@"====== failed %@",error);
                }
            }];
            break;
        case 1005: // 微博授权
            NSLog(@"1005 ======");
            [ShareSDK authorize:SSDKPlatformTypeSinaWeibo settings:nil onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
                if (!error) {
                    NSLog(@"------success");
                }else{
                    NSLog(@"====== failed %@",error);
                }
            }];
            break;
        default:
            break;
    }
}

@end
