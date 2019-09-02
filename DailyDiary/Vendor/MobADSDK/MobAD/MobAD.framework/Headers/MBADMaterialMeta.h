//
//  MBADMaterialMeta.h
//  MobAD
//
//  Created by Max on 2019/8/6.
//  Copyright © 2019 掌淘科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MADTypeDefines.h"
@class MBADImage;

typedef NS_ENUM(NSInteger, MBADFeedADMode) {
    MBADFeedADMode_SmallImage = 2,
    MBADFeedADMode_LargeImage = 3,
    MBADFeedADMode_GroupImage = 4,
    MBADFeedADMode_VideoAdImage = 5, // video ad || rewarded video ad horizontal screen
    MBADFeedADMode_VideoAdPortrait = 15, // rewarded video ad vertical screen
    MBADFeedADMode_ImagePortrait = 16
};

NS_ASSUME_NONNULL_BEGIN

@interface MBADMaterialMeta : NSObject

/// interaction types supported by ads.
@property (nonatomic, assign) MBADInteractionType interactionType;

/// material pictures.
@property (nonatomic, strong) NSArray<MBADImage *> *imageAry;

/// ad logo icon.
@property (nonatomic, strong) MBADImage *icon;

/// ad headline.
@property (nonatomic, copy) NSString *AdTitle;

/// ad description.
@property (nonatomic, copy) NSString *AdDescription;

/// ad source.
@property (nonatomic, copy) NSString *source;

/// text displayed on the creative button.
@property (nonatomic, copy) NSString *buttonText;

/// display format of the in-feed ad, other ads ignores it.
@property (nonatomic, assign) MBADFeedADMode imageMode;

/// Star rating, range from 1 to 5.
@property (nonatomic, assign) NSInteger score;

/// Number of comments.
@property (nonatomic, assign) NSInteger commentNum;

/// ad installation package size, unit byte.
@property (nonatomic, assign) NSInteger appSize;

/// media configuration parameters.
@property (nonatomic, strong) NSDictionary *mediaExt;

@end

NS_ASSUME_NONNULL_END
