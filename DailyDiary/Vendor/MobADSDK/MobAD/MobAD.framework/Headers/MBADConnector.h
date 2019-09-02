//
//  MBADConnector.h
//  MobAD
//
//  Created by Max on 2019/7/30.
//  Copyright © 2019 掌淘科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MADTypeDefines.h"
@class MBADSize;
@class MBADSlot;

@interface MBADConnector : NSObject

/**
 默认广告管理类

 @return 单例对象
 */
+ (instancetype)defaultConnector;

/**
 展示开屏广告

 @param view 开屏广告的载体视图，可以传window
 @param viewController 用于跳转的控制器
 @param frame 广告尺寸
 @param hideSkipButton 是否隐藏跳过按钮
 @param tolerateTimeout 加载超时时间
 @param stateChanged 广告状态回调
 */
- (void)showSplashAdOnView:(UIView *)view
            viewController:(UIViewController *)viewController
                     frame:(CGRect)frame
            hideSkipButton:(BOOL)hideSkipButton
           tolerateTimeout:(NSTimeInterval)tolerateTimeout
              stateChanged:(MBADStateCallback)stateChanged;


/**
 展示插屏广告

 @param viewController 用于跳转的控制器
 @param size 广告尺寸
 @param stateChanged 状态回调
 */
- (void)showInterstitialAdWithViewController:(UIViewController *)viewController
                                        size:(MBADSize *)size
                                stateChanged:(MBADStateCallback)stateChanged;


/**
 展示横幅广告

 @param view 广告的载体视图
 @param viewController 用于跳转的控制器
 @param size 广告尺寸
 @param frame 广告视图frame
 @param interval 轮播间隔 有效时间 30-120s
 @param stateChanged 广告状态回调
 @param dislikeCallback 用户选择关闭理由回调
 */
- (void)showBannerOnView:(UIView *)view
          viewController:(UIViewController *)viewController
                    size:(MBADSize *)size
                   frame:(CGRect)frame
                interval:(NSInteger)interval
            stateChanged:(MBADStateCallback)stateChanged
         dislikeCallback:(MBADDislikeCallback)dislikeCallback;


/**
 原生信息流视图

 @param slot 广告配置项
 @param count 广告条数
 @param callback 加载回调
 */
- (void)nativeAdWithSlot:(MBADSlot *)slot
                 adCount:(NSInteger)count
                callback:(MBADNativeAdCallback)callback;

@end

