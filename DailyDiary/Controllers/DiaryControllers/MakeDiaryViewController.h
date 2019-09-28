//
//  MakeDiaryViewController.h
//  DailyDiary
//
//  Created by mob on 2019/9/3.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MakeDiaryView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MakeDiaryViewController : UIViewController

@property(nonatomic, strong)MakeDiaryView *makeDiaryView;
@property(nonatomic, copy)NSString *dateStr;
@property(nonatomic, strong)NSArray *httpRequestImageArr;

@end

NS_ASSUME_NONNULL_END
