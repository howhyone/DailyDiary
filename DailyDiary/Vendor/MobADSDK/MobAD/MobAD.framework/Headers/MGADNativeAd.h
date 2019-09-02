//
//  MGADNativeAd.h
//  MobAD
//
//  Created by Max on 2019/8/1.
//  Copyright © 2019 掌淘科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MADTypeDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MGADNativeAd : NSObject

/**
 广告视图
 */
@property (strong, nonatomic, readonly) UIView *adView;

/**
 设置已监听广告状态回调
 */
@property (nonatomic, copy) MGADStateCallback stateCallback;

/**
 设置以监听视频广告状态回调
 */
@property (nonatomic, copy) MGADMediaAdStateCallback mediaStateCallback;

/**
 获取广告eCPM
 */
@property (assign, nonatomic, readonly) NSInteger eCPM;


/**
 原生模板广告渲染

 @param viewController 用于跳转的控制器
 */
- (void)renderWithViewController:(UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
