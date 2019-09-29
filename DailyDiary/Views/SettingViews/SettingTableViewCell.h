//
//  SettingTableViewCell.h
//  DailyDiary
//
//  Created by mob on 2019/9/9.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SettingTableViewCell : UITableViewCell

@property(nonatomic, strong)UILabel *leftLabel;

@end

@interface FontSettingTableViewCell : SettingTableViewCell

@end

@interface PhotoWallSettingTableViewCell : FontSettingTableViewCell

@end

@interface FontSizeSettingTableViewCell : SettingTableViewCell

@property(nonatomic, strong)UIButton *currentSelectedBtn;

@end

@interface WarnSettingTableViewCell : SettingTableViewCell

@end

@interface ShareSettingTableViewCell : SettingTableViewCell

@end

@protocol clickLogoutDelegate <NSObject>

@optional

-(void)clickLogout;
-(void)clickchangeIntroduce;
@end

@interface SettingHeaderView : UIView
@property(nonatomic, strong)UIImageView *headerImageView;
@property(nonatomic, strong)UILabel *nameLabel;
@property(nonatomic, strong)UIButton *changeIntroBtn;
@property(nonatomic, strong)UIButton *logoutBtn;
@property(nonatomic, weak)id<clickLogoutDelegate> delegate;
@property(nonatomic, strong)PersonalInfoModel *personalInfoModel;

@end

NS_ASSUME_NONNULL_END
