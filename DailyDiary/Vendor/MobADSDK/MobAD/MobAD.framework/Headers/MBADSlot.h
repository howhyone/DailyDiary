//
//  MBADSlot.h
//  MobAD
//
//  Created by Max on 2019/8/5.
//  Copyright © 2019 掌淘科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MADTypeDefines.h"
@class MBADSlot;
@class MBADSize;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MBADSlotAdType) {
    MBADSlotAdType_Unknown       = 0,
    MBADSlotAdType_Banner        = 1,       // 横幅
    MBADSlotAdType_Interstitial  = 2,       // 插屏
    MBADSlotAdType_Splash        = 3,       // 开屏
    MBADSlotAdType_Splash_Cache  = 4,       // 缓存开屏
    MBADSlotAdType_Feed          = 5,       // 信息流
    MBADSlotAdType_Paster        = 6,       // 贴纸
    MBADSlotAdType_RewardVideo   = 7,       // 激励视频
    MBADSlotAdType_FullscreenVideo = 8,     // 全屏视频
    MBADSlotAdType_DrawVideo     = 9,       // 沉浸式视频
};

typedef NS_ENUM(NSInteger, MBADSlotPosition) {
    MBADSlotPosition_Top = 1,
    MBADSlotPosition_Bottom = 2,
    MBADSlotPosition_Feed = 3,
    MBADSlotPosition_Middle = 4, // for interstitial ad only
    MBADSlotPosition_Fullscreen = 5,
};

@interface MBADSlot : NSObject

/// required. Ad type.
@property (nonatomic, assign) MBADSlotAdType AdType;

/// required. Ad display location.
@property (nonatomic, assign) MBADSlotPosition position;

/// Accept a set of image sizes, please pass in the MBADSize object.
@property (nonatomic, strong) NSMutableArray <MBADSize *>*imgSizeArray;

/// required. Image size.
@property (nonatomic, strong) MBADSize *imgSize;

/// Icon size.
@property (nonatomic, strong) MBADSize *iconSize;

/// Maximum length of the title.
@property (nonatomic, assign) NSInteger titleLengthLimit;

/// Maximum length of description.
@property (nonatomic, assign) NSInteger descLengthLimit;

/// Whether to support deeplink.
@property (nonatomic, assign) BOOL isSupportDeepLink;

/// Native banner ads and native interstitial ads are set to 1, other ad types are 0, the default is 0.
@property (nonatomic, assign) BOOL isOriginAd;

@end

NS_ASSUME_NONNULL_END
