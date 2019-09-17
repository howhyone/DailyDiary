//
//  HomeTableViewCell.h
//  DailyDiary
//
//  Created by mob on 2019/8/28.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeTableViewCell : UITableViewCell
@property(nonatomic, strong)UILabel *dayLabel;
@property(nonatomic, strong)UILabel *weekLabel;
@property(nonatomic, strong)UILabel *diaryTextLabel;

@end

@interface ImageTextTableViewCell : HomeTableViewCell
@property(nonatomic, strong)UIImageView *diaryImageView;

@end

NS_ASSUME_NONNULL_END
