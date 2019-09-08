//
//  PackageView.h
//  DailyDiary
//
//  Created by mob on 2019/9/8.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PackageView : UIView

@end


@protocol clickKeyboardToolBarItemDelegate <NSObject>

-(void)clickKeyboardToolBarAlbumItem;
-(void)clickKeyboardToolBarDoneItem;

@end

@interface KeyboardToolBarView : UIView

@property(nonatomic, assign)BOOL enableShowAlbumButton;
@property(nonatomic, assign)BOOL enableShowDoneButton;
@property(nonatomic, weak) id<clickKeyboardToolBarItemDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
