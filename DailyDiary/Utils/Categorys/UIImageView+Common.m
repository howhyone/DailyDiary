//
//  UIImageView+Common.m
//  DailyDiary
//
//  Created by mob on 2019/8/22.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import "UIImageView+Common.h"

@implementation UIImageView (Common)

+(UIImageView *)imageViewWithImageName:(NSString *)imageNameStr
{
    UIImageView *imageViewCommon = [UIImageView new];
    if (imageNameStr) {
        imageViewCommon.image = [UIImage imageNamed:imageNameStr];
    }
    return imageViewCommon;
}

@end
