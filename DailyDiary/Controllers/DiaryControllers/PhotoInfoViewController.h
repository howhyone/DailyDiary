//
//  PhotoInfoViewController.h
//  DailyDiary
//
//  Created by mob on 2019/9/22.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoInfoViewController : UIViewController


@property(nonatomic, copy)void(^deletedPhotoBlock)(UIImage *deletedPhotoImage);
@property(nonatomic, strong)UIImage *photoImage;

@end

NS_ASSUME_NONNULL_END
