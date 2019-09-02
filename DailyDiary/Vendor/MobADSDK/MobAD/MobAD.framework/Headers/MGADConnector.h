//
//  MGADConnector.h
//  MobAD
//
//  Created by Max on 2019/7/30.
//  Copyright © 2019 掌淘科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MADTypeDefines.h"

@interface MGADConnector : NSObject

/**
 默认广告管理类
 
 @return 单例对象
 */
+ (instancetype)defaultConnector;


/**
 展示开屏广告

 @param window 用于展示的window
 @param color 广告背景色
 @param image 背景图片
 @param delay 超时时间
 @param bottomView 自定义底部视图
 @param skipView 自定义跳过视图
 @param position 跳过视图位置
 @param adLifeTime 广告显示周期回调
 @param stateCallback 广告显示状态变化回调
 */
- (void)showSplashAdInWindow:(UIWindow *)window
             backgroundColor:(UIColor *)color
             backgroundImage:(UIImage *)image
                  fetchDelay:(NSTimeInterval)delay
                  bottomView:(UIView *)bottomView
                    skipView:(UIView *)skipView
              skipViewCenter:(CGPoint)position
                  adLifeTime:(MGADLifeTimeCallback)adLifeTime
                stateChanged:(MGADStateCallback)stateCallback;


/**
 展示横幅2.0广告

 @param frame 广告视图frame
 @param viewController 用于跳转控制器
 @param interval 广告刷新间隔，范围 [30, 120] 秒
 @param isAnimationOn 展现和轮播时的动画效果开关，默认打开
 @param configComplete 广告View配置完成后回调
 @param stateCallback 广告状态变化回调
 */
- (void)unifiedBannerViewWithFrame:(CGRect)frame
                    viewController:(UIViewController *)viewController
                          interval:(NSTimeInterval)interval
                     isAnimationOn:(BOOL)isAnimationOn
                    configComplete:(MGADViewCallback)configComplete
                      stateChanged:(MGADStateCallback)stateCallback;


/**
 展示横幅广告

 @param frame 广告视图frame
 @param viewController 用于跳转控制器
 @param interval 广告刷新间隔，范围 [30, 120] 秒
 @param isGpsOn GPS精准广告定位模式开关,默认Gps关闭
 @param isAnimationOn 展现和轮播时的动画效果开关
 @param showCloseBtn 是否显示关闭按钮
 @param configComplete 广告View配置完成后回调
 @param stateCallback 广告状态变化回调
 @param memoryWarning 内存警告回调
 */
- (void)bannerViewWithFrame:(CGRect)frame
             viewController:(UIViewController *)viewController
                   interval:(NSTimeInterval)interval
                    isGpsOn:(BOOL)isGpsOn
              isAnimationOn:(BOOL)isAnimationOn
               showCloseBtn:(BOOL)showCloseBtn
             configComplete:(MGADViewCallback)configComplete
               stateChanged:(MGADStateCallback)stateCallback
              memoryWarning:(MGADMemoryWarning)memoryWarning;


/**
 显示插屏广告

 @param viewController 用于跳转的控制器
 @param isGpsOn GPS精准广告定位模式开关,默认Gps关闭
 @param stateCallback 广告状态变化回调
 */
- (void)showInterstitialAdWithViewController:(UIViewController *)viewController
                                     isGpsOn:(BOOL)isGpsOn
                                stateChanged:(MGADStateCallback)stateCallback;


/**
 显示插屏广告2.0

 @param viewController 用于跳转的控制器
 @param eCPMCallback 用于获取广告eCPM
 @param stateCallback 广告状态回调
 */
- (void)showUnifiedInterstitialAdWithViewController:(UIViewController *)viewController
                                               eCPM:(MGADeCPMCallback)eCPMCallback
                                       stateChanged:(MGADStateCallback)stateCallback;

/**
 原生信息流广告

 @param size 广告尺寸
 @param count 请求的广告条数
 @param autoPlay 非 WiFi 网络，是否自动播放。默认 NO。loadAd 前设置。
 @param videoMuted 自动播放时，是否静音。默认 YES
 @param maxVideoDuration 请求的视频时长上限，有效值范围为[5,60]
 @param nativeAdCallback 原生广告回调
 */
- (void)nativeExpressAdWithSize:(CGSize)size
                        adCount:(NSInteger)count
                 autoPlayOnWWAN:(BOOL)autoPlay
                     videoMuted:(BOOL)videoMuted
               maxVideoDuration:(NSInteger)maxVideoDuration
          adViewsConfigComplete:(MGADNativeAdCallback)nativeAdCallback;

@end

