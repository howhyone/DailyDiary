//
//  MBADSize.h
//  MobAD
//
//  Created by Max on 2019/8/5.
//  Copyright © 2019 掌淘科技. All rights reserved.
//

#import <Foundation/Foundation.h>

// 广告期望尺寸
typedef NS_ENUM(NSInteger, MBADProposalSize) {
    MBADProposalSize_Banner600_90,
    MBADProposalSize_Banner600_100,
    MBADProposalSize_Banner600_150,
    MBADProposalSize_Banner600_260,
    MBADProposalSize_Banner600_286,
    MBADProposalSize_Banner600_300,
    MBADProposalSize_Banner600_388,
    MBADProposalSize_Banner600_400,
    MBADProposalSize_Banner600_500,
    MBADProposalSize_Feed228_150,
    MBADProposalSize_Feed690_388,
    MBADProposalSize_Interstitial600_400,
    MBADProposalSize_Interstitial600_600,
    MBADProposalSize_Interstitial600_900,
    MBADProposalSize_DrawFullScreen
};

@interface MBADSize : NSObject

// width unit pixel.
@property (nonatomic, assign) NSInteger width;

// height unit pixel.
@property (nonatomic, assign) NSInteger height;

+ (instancetype)sizeBy:(MBADProposalSize)proposalSize;

@end
