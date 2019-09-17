//
//  AppDelegate.m
//  DailyDiary
//
//  Created by mob on 2019/8/17.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import "AppDelegate.h"
#import "DDNavigationController.h"
#import "LoginViewController.h"
#import "PersonalInfoViewController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <ShareSDK/ShareSDK.h>
#import "OtherLoginViewController.h"
#import "HomeViewController.h"
#import <MobPush/MobPush.h>
#import "DD_RootViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    BOOL loginBool = [[NSUserDefaults standardUserDefaults] boolForKey:kLoginKey];
    if (loginBool) {
        self.window.rootViewController = [[DDNavigationController alloc] initWithRootViewController:[[HomeViewController alloc] init]];

    }else{
         self.window.rootViewController = [[DDNavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
    }
//        BOOL activeBool = [[NSUserDefaults standardUserDefaults] boolForKey:kActivekey];
//    if (!activeBool) {
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kActivekey];
//         self.window.rootViewController = [[DDNavigationController alloc] initWithRootViewController:[[DD_RootViewController alloc] init]];
//    }else{
//            self.window.rootViewController = [[DDNavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
//    }
    
    [self.window makeKeyAndVisible];
    [self setupKeyboard];
    [self registerShareSDK];
    [self setupMobPush];
    return YES;
}

-(void)setupKeyboard
{
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager];
    keyboardManager.enable = YES; // 控制整个功能是否启用
    keyboardManager.shouldResignOnTouchOutside = YES; // 点击背景是否收起键盘
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; //有多个输入框时，可以通过点击toobar上的"前一个""后一个" 按钮来实现移动到不同的输入框
    keyboardManager.previousNextDisplayMode = IQPreviousNextDisplayModeAlwaysShow;
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    keyboardManager.toolbarDoneBarButtonItemText = @"保存";
    keyboardManager.toolbarPreviousBarButtonItemImage = [UIImage imageNamed:@"添加图片"];
    keyboardManager.toolbarNextBarButtonItemText = @"";  //隐藏next按钮
    keyboardManager.shouldShowToolbarPlaceholder = YES; // 是否显示占位文字
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17];  //设置占位符
    keyboardManager.keyboardDistanceFromTextField = 10.0f; //输入框距离键盘的距离
}
-(void)registerShareSDK
{
    [ShareSDK registPlatforms:^(SSDKRegister *platformsRegister) {
        [platformsRegister setupWeChatWithAppId:@"wx617c77c82218ea2c" appSecret:@"c7253e5289986cf4c4c74d1ccc185fb1"];
        [platformsRegister setupSinaWeiboWithAppkey:@"568898243" appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3" redirectUrl:@"http://www.sharesdk.cn"];
    }];
}

-(void)setupMobPush
{
#ifdef DEBUG
    [MobPush setAPNsForProduction:NO];
#else
    [MobPush setAPNsForProduction:YES];
#endif
    //    配置信息
    MPushNotificationConfiguration *configuration = [[MPushNotificationConfiguration alloc] init];
    configuration.types = MPushAuthorizationOptionsSound | MPushAuthorizationOptionsAlert | MPushAuthorizationOptionsBadge;
    [MobPush setupNotification:configuration];
    NSLog(@"----isStop =======%d",MobPush.isPushStopped);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveMessage:) name:MobPushDidReceiveMessageNotification object:nil];
    //    定向推送必须添加注册ID的方法
    [MobPush getRegistrationID:^(NSString *registrationID, NSError *error) {
        if (!error) {
            NSLog(@"registrationID ========= %@",registrationID);
        }
        else
        {
            NSLog(@"error ========= %@",error);
        }
        
    }];
    //    添加别名
    [MobPush setAlias:@"zhangxu" result:^(NSError *error) {
        NSLog(@"setAlias ------- ");
    }];
    //    添加标签
    [MobPush addTags:@[@"tag1",@"tag2"] result:^(NSError *error) {
        NSLog(@"addTags ---------");
    }];
}

-(void)didReceiveMessage:(NSNotification *)notification
{
    MPushMessage *message = notification.object;
    
    switch (message.messageType) {
        case MPushMessageTypeUDPNotify:
            NSLog(@"hahhaah ------  UDP 通知");
        break;
        case MPushMessageTypeCustom:
            NSLog(@"lalalalal ------ 自定义通知");
        break;
        case MPushMessageTypeAPNs:
            NSLog(@"APNs 通知 apndDict is ----------- %@",message.msgInfo);
            if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
                
            }
        break;
        case MPushMessageTypeLocal:
            {
                NSLog(@"MPushMessageTypeLocal  apndDict is ----------- %@",message.msgInfo);
                
                NSString *body = message.notification.body;
                NSString *title = message.notification.title;
                NSString *subtitle = message.notification.subTitle;
                NSString *sound = message.notification.sound;
                NSInteger badge = message.notification.badge;
                NSString *urlStr = message.msgInfo[@"url"];
                NSURL *url = [NSURL URLWithString:urlStr];
                NSLog(@"收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%ld，\nsound：%@，\nurl: %@}",body, title, subtitle, badge, sound,url);
            }
        break;
        case MPushMessageTypeClicked:
            {
                NSLog(@"click the message!!!!!!!!!!!!");
            }
        break;
        default:
            break;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kActivekey];

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kActivekey];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    NSLog(@"------- applicationWillEnterForeground -----");
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kActivekey];
    NSLog(@"------- applicationDidBecomeActive -----");
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"DailyDiary"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
