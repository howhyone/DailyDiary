//
//  PhotoInfoCollectionViewCell.h
//  DailyDiary
//
//  Created by mob on 2019/10/12.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoInfoCollectionViewCell : UICollectionViewCell
@property(nonatomic, assign)NSInteger currentCellInt;
@property(nonatomic, strong)UIImageView *photoImageView;
@end

NS_ASSUME_NONNULL_END
