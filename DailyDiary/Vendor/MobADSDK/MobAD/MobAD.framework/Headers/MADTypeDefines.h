//
//  MADTypeDefines.h
//  MobAD
//
//  Created by Max on 2019/7/31.
//  Copyright © 2019 掌淘科技. All rights reserved.
//

#ifndef MADTypeDefines_h
#define MADTypeDefines_h

/**
 MGAD广告状态变化回调

 - MGADStateDidReceived: 请求广告条数据成功
 - MGADStateFailReceived: 请求广告条数据失败
 - MGADStateDidSuccessPresent: 开屏广告成功展示
 - MGADStateDidFailPresent: 开屏广告展示失败
 - MGADStateAppWillEnterBackground: 当点击应用下载或者广告调用系统程序打开时
 - MGADStateWillExposured: 广告曝光回调
 - MGADStateDidClick: 广告点击回调
 - MGADStateWillClosed: 广告有关闭按钮被用户关闭时调用
 - MGADStateDidClosed: 广告已经被关闭
 - MGADStateWillPresent: 插屏2.0广告将要展示回调
 - MGADStateDidPresent: 插屏2.0广告视图展示成功回调
 - MGADStateWillDismiss: 全屏广告页将要展示结束
 - MGADStateDidDismiss: 全屏广告页展示结束回调
 - MGADStateWillPresentFullScreenModal: 广告点击以后即将弹出全屏广告页
 - MGADStateDidPresentFullScreenModal: 广告点击以后弹出全屏广告页
 - MGADStateWillDismissFullScreenModal: 全屏广告页即将被关闭
 - MGADStateDidDismissFullScreenModal: 全屏广告页已经被关闭
 - MGADStateAdViewRenderSuccess: 原生模板广告渲染成功
 - MGADStateAdViewRenderFail: 原生模板广告渲染失败
 */
typedef NS_ENUM(NSUInteger, MGADState) {
    
    MGADStateDidReceived = 0,
    MGADStateFailReceived,
    MGADStateDidSuccessPresent,
    MGADStateDidFailPresent,
    MGADStateAppWillEnterBackground,
    MGADStateWillExposured,
    MGADStateDidClick,
    MGADStateWillClosed,
    MGADStateDidClosed,
    MGADStateWillPresent,
    MGADStateDidPresent,
    MGADStateWillDismiss,
    MGADStateDidDismiss,
    MGADStateWillPresentFullScreenModal,
    MGADStateDidPresentFullScreenModal,
    MGADStateWillDismissFullScreenModal,
    MGADStateDidDismissFullScreenModal,
    MGADStateAdViewRenderSuccess,
    MGADStateAdViewRenderFail,
    
};

typedef NS_ENUM(NSUInteger, MGADMediaAdState) {
    MGADMediaAdStateWillPresentVideoVC=0,//原生视频模板详情页将要弹出
    MGADMediaAdStateDidPresentVideoVC,//原生视频模板详情页弹出后
    MGADMediaAdStateInitial,         // 初始状态
    MGADMediaAdStateLoading,         // 加载中
    MGADMediaAdStateStarted,         // 开始播放
    MGADMediaAdStatePaused,          // 用户行为导致暂停
    MGADMediaAdStateStoped,          // 播放停止
    MGADMediaAdStateError,           // 播放出错
    MGADMediaAdStateWillDismissVideoVC, //原生视频模板详情页将要关闭
    MGADMediaAdStateDidDismissVideoVC //原生视频模板详情页已经关闭
};

/**
 内存警告
 */
typedef void(^MGADMemoryWarning)(void);

/**
 广告状态回调
 */
typedef void(^MGADStateCallback)(MGADState state,NSError *error);

/**
 视频广告状态回调
 */
typedef void(^MGADMediaAdStateCallback)(MGADMediaAdState state);

/**
 广告生命周期
 */
typedef void(^MGADLifeTimeCallback)(NSUInteger time);

/**
 广告视图回调
 */
typedef void(^MGADViewCallback)(UIView *view);


/**
 广告eCPM回调
 */
typedef void(^MGADeCPMCallback)(NSInteger eCPM);

/**
 原生模板广告回调
 */
typedef void(^MGADNativeAdCallback)(NSArray *nativeAds, NSError *error);


/**
 MBAD广告状态变化

 - MBADStateDidLoad: 广告元数据加载成功
 - MBADStateDidLoadFailed: 广告元数据加载失败
 - MBADStateWillVisible: 广告即将展示
 - MBADStateDidVisible: 广告即将展示
 - MBADStateDidClick: 广告被点击
 - MBADStateWillClose: 广告即将关闭
 - MBADStateDidClose: 广告已经被关闭
 - MBADStateDidCloseOtherController: 将要关闭另一个控制器
 */
typedef NS_ENUM(NSUInteger, MBADState) {
    MBADStateDidLoad,
    MBADStateDidLoadFailed,
    MBADStateWillVisible,
    MBADStateDidVisible,
    MBADStateDidClick,
    MBADStateWillClose,
    MBADStateDidClose,
    MBADStateDidCloseOtherController,
};

//广告交互类型
typedef NS_ENUM(NSInteger, MBADInteractionType) {
    MBADInteractionTypeCustorm = 0,
    MBADInteractionTypeNO_INTERACTION = 1,  // pure ad display
    MBADInteractionTypeURL = 2,             // open the webpage using a browser
    MBADInteractionTypePage = 3,            // open the webpage within the app
    MBADInteractionTypeDownload = 4,        // download the app
    MBADInteractionTypePhone = 5,           // make a call
    MBADInteractionTypeMessage = 6,         // send messages
    MBADInteractionTypeEmail = 7,           // send email
    MBADInteractionTypeVideoAdDetail = 8    // video ad details page
};


/**
 关闭广告选项回调
 */
typedef void(^MBADDislikeCallback)(NSArray *reasons);

/**
 广告状态回调
 */
typedef void(^MBADStateCallback)(MBADState state, MBADInteractionType interactionType,NSError *error);

/**
 原生广告回调
 */
typedef void(^MBADNativeAdCallback)(NSArray *nativeAds, NSError *error);

#endif /* MADTypeDefines_h */
