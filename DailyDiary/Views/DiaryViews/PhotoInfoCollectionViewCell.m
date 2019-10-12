//
//  PhotoInfoCollectionViewCell.m
//  DailyDiary
//
//  Created by mob on 2019/10/12.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import "PhotoInfoCollectionViewCell.h"

@implementation PhotoInfoCollectionViewCell

-(id)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        _photoImageView = [[UIImageView alloc] init];
        _photoImageView.frame = self.bounds;
        _photoImageView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_photoImageView];
    }
    return self;
}

@end
