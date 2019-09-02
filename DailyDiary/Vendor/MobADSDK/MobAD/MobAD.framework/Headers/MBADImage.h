//
//  MBADImage.h
//  MobAD
//
//  Created by Max on 2019/8/6.
//  Copyright © 2019 掌淘科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBADImage : NSObject

// image address URL
@property (nonatomic, copy) NSString *imageURL;

// image width
@property (nonatomic, assign) float width;

// image height
@property (nonatomic, assign) float height;


@end

