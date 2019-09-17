//
//  FontTableViewCell.h
//  DailyDiary
//
//  Created by mob on 2019/9/17.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DownloadFontDelegate <NSObject>

-(void)downloadFont:(NSString *)fontStr;

@end

@interface FontTableViewCell : UITableViewCell
@property(nonatomic, strong)UIButton *downloadBtn;
@property(nonatomic, weak)id<DownloadFontDelegate> delegate;
@end


@interface FontTableViewHeaderView : UIView

@end

NS_ASSUME_NONNULL_END
