//
//  MBADDislikeReason.h
//  MobAD
//
//  Created by Max on 2019/8/6.
//  Copyright © 2019 掌淘科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MBADDislikeReason : NSObject

/**
 reason index
 */
@property (nonatomic, copy, readonly) NSString *dislikeID;

/**
 reason text
 */
@property (nonatomic, copy, readonly) NSString *name;

@end

NS_ASSUME_NONNULL_END
