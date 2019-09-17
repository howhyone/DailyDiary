//
//  OtherLoginView.h
//  DailyDiary
//
//  Created by mob on 2019/8/22.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShareSDK/ShareSDK.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ThirdLoginDelegate <NSObject>
@required
-(void)getVerCodeWithPhone:(NSString *)phoneStr;
-(void)thirdLoginWithPlatfromType:(SSDKPlatformType)platformType;
-(void)phoneLoginWithVerCode:(NSString *)codeStr;
@end



@interface OtherLoginView : UIView
@property(nonatomic, weak)id<ThirdLoginDelegate> delegate;
@property(nonatomic, strong)UITextField *phoneTextField;
@property(nonatomic, strong)UITextField *verCodeTextField;

@end

NS_ASSUME_NONNULL_END
