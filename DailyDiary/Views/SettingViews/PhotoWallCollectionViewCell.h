//
//  PhotoWallCollectionViewCell.h
//  DailyDiary
//
//  Created by mob on 2019/9/11.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoWallCollectionViewCell : UICollectionViewCell

@property(nonatomic, strong)UIImageView *photoImageView;
@property(nonatomic, strong)UILabel *numberLabel;
@property(nonatomic, strong)UILabel *dateLabel;

@end

NS_ASSUME_NONNULL_END
