//
//  MobAD.h
//  MobAD
//
//  Created by Max on 2019/7/30.
//  Copyright © 2019 掌淘科技. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MADTypeDefines.h"
#import "MADNativeAdData.h"
#import "MADDislikeReason.h"
#import "MADNativeExpressAdView.h"

NS_ASSUME_NONNULL_BEGIN

/**
 广告 SDK 入口,以工厂方法形式提供各种接口
 */
@interface MobAD : NSObject

/**
 获取SDK版本号

 @return SDK版本号
 */
+ (NSString *)version;

/**
 展示开屏广告
 
 @param pid 广告位id
 @param view 开屏广告的载体视图，建议传window
 @param viewController 用于跳转的控制器
 @param hideSkipButton 是否隐藏跳过按钮
 @param stateChanged 广告状态回调
 */
+ (void)showSplashAdWithPlacementId:(NSString *)pid
                             onView:(UIView *)view
                     viewController:(UIViewController *)viewController
                     hideSkipButton:(BOOL)hideSkipButton
                       stateChanged:(MADStateCallback)stateChanged;


/**
 展示横幅广告
 
 @param pid 广告位id
 @param onView 广告视图的载体View
 @param viewController 用于跳转的控制器
 @param frame 广告视图frame
 @param interval 广告刷新间隔,范围 [30, 120] 秒, 不想要刷新则该字段传 0 即可
 @param stateChanged 广告状态回调
 @param dislikeCallback 用户选择关闭理由回调
 */
+ (void)showBannerAdWithPlacementId:(NSString *)pid
                             onView:(UIView *)onView
                     viewController:(UIViewController *)viewController
                              frame:(CGRect)frame
                           interval:(NSInteger)interval
                       stateChanged:(MADStateCallback)stateChanged
                    dislikeCallback:(MADDislikeCallback)dislikeCallback;

/**
 关闭横幅广告

 @param adObject 横幅广告对象
 */
+ (void)dismissBannerAd:(id)adObject;

/**
 展示插屏广告
 
 @param pid 广告位id
 @param onView 广告视图的载体View
 @param viewController 用于跳转的控制器
 @param frame 广告视图frame
 @param eCPMCallback 用于获取广告eCPM, 部分广告不存在eCPM时回调值为 -1
 @param stateChanged 广告状态回调
 */
+ (void)showInterstitialAdWithPlacementId:(NSString *)pid
                                   onView:(UIView *)onView
                           viewController:(UIViewController *)viewController
                                    frame:(CGRect)frame
                             eCPMCallback:(MADeCPMCallback)eCPMCallback
                             stateChanged:(MADStateCallback)stateChanged;


/**
 原生模版信息流广告
 
 @param pid 广告配置项
 @param count 广告条数
 @param adViewsCallback 广告模版视图回调
 @param stateCallback 广告状态回调
 @param dislikeCallback 广告不喜欢原因回调
 */
+ (void)nativeExpressAdWithPlacementId:(NSString *)pid
                                adSize:(CGSize)size
                               adCount:(NSInteger)count
                       adViewsCallback:(MADNativeExpressAdViewCallback)adViewsCallback
                         stateCallback:(MADStateCallback)stateCallback
                       dislikeCallback:(MADDislikeCallback)dislikeCallback;



/**
 原生自渲染信息流广告
 
 @param pid 广告配置项
 @param count 广告条数
 @param adsCallback 广告数据回调
 @param stateCallback 广告状态回调
 @param dislikeCallback 广告不喜欢原因回调
 */
+ (void)nativeAdWithPlacementId:(NSString *)pid
                        adCount:(NSInteger)count
                    adsCallback:(MADNativeAdCallback)adsCallback
                  stateCallback:(MADStateCallback)stateCallback
                dislikeCallback:(MADDislikeCallback)dislikeCallback;


/**
 展示全屏视频广告
 
 @param pid 广告位id
 @param viewController 用于跳转的控制器
 @param sceneDescirbe 可选,场景描述信息
 @param stateChanged 广告状态回调
 */
+ (void)showFullScreenVideoAdWithPlacementId:(NSString *)pid
                              viewController:(UIViewController *)viewController
                            ritSceneDescribe:(NSString *_Nullable)sceneDescirbe
                                stateChanged:(MADStateCallback)stateChanged;

/**
 展示激励视频广告
 
 @param pid 广告位id
 @param viewController 用于 present 激励视频的 VC
 @param eCPMCallback 用于获取广告eCPM, 部分广告不存在eCPM时回调值为 -1
 @param stateCallback 激励视频广告状态回调
 */
+ (void)showRewardVideoAdWithPlacementId:(NSString *)pid
                          viewController:(UIViewController *)viewController
                                    eCPM:(MADeCPMCallback)eCPMCallback
                           stateCallback:(MADStateCallback)stateCallback;


/**
 获取Draw视频流

 @param pid 广告位id
 @param count 广告个数
 @param callback Draw视频流广告回调
 @param stateCallback 广告状态回调
 @param dislikeCallback 广告不喜欢原因回调
 */
+ (void)drawVideoFeedAdWithPlacementId:(NSString *)pid
                               adCount:(NSInteger)count
                            adCallback:(MADNativeAdCallback)callback
                         stateCallback:(MADStateCallback)stateCallback
                       dislikeCallback:(MADDislikeCallback)dislikeCallback;

#pragma mark - 广告日志

/**
 发送广告状态日志(主要用于自渲染等类型广告)

 @param state 广告状态
 @param data 广告数据
 @param error 错误信息,可以传nil
 */
+ (void)sendAdLogWithState:(MADState)state adObject:(MADNativeAdData *)data error:(NSError *_Nullable)error;

@end

NS_ASSUME_NONNULL_END
