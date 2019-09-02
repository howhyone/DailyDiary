//
//  MBADNativeAd.h
//  MobAD
//
//  Created by Max on 2019/8/5.
//  Copyright © 2019 掌淘科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MADTypeDefines.h"
@class MBADMaterialMeta;
@class MBADRelatedView;

NS_ASSUME_NONNULL_BEGIN

@interface MBADNativeAd : NSObject

/**
 设置以监听广告回调
 */
@property (nonatomic, copy) MBADStateCallback stateChanged;


/**
 设置以监听用户点击关闭广告后选择理由
 */
@property (nonatomic, copy) MBADDislikeCallback dislikeCallback;

/**
 广告源数据
 */
@property (nonatomic, strong, readonly, nullable) MBADMaterialMeta *data;

/**
 广告相关视图
 */
@property (strong, nonatomic) MBADRelatedView *relatedView;

/**
 必须设置，广告跳转控制器
 */
@property (nonatomic, weak, readwrite) UIViewController *rootViewController;

/**
 绑定广告点击事件
 */
- (void)registerContainer:(__kindof UIView *)containerView
       withClickableViews:(NSArray<__kindof UIView *> *_Nullable)clickableViews;

@end

NS_ASSUME_NONNULL_END
