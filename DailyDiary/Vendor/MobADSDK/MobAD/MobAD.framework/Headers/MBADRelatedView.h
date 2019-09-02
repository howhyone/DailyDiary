//
//  MBADRelatedView.h
//  MobAD
//
//  Created by Max on 2019/8/7.
//  Copyright © 2019 掌淘科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBADRelatedView : NSObject

/**
 Need to actively add to the view in order to deal with the feedback and improve the accuracy of ad.
 */
@property (nonatomic, strong, readonly, nullable) UIButton *dislikeButton;

/**
 Promotion label.Need to actively add to the view.
 */
@property (nonatomic, strong, readonly, nullable) UILabel *adLabel;

/**
 Ad logo.Need to actively add to the view.
 */
@property (nonatomic, strong, readonly, nullable) UIImageView *logoImageView;
/**
 Ad logo + Promotion label.Need to actively add to the view.
 */
@property (nonatomic, strong, readonly, nullable) UIImageView *logoADImageView;

/**
 Video ad view. Need to actively add to the view.
 */
@property (nonatomic, strong, readonly, nullable) UIView *videoAdView;

@end

