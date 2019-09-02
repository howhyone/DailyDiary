//
//  HomePageTableViewCell.m
//  DailyDiary
//
//  Created by mob on 2019/8/28.
//  Copyright © 2019 howhyone. All rights reserved.
//

#import "HomePageTableViewCell.h"
#import "HomeTableViewCell.h"

@interface HomePageTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic, strong)UICollectionView *homePageCollectionView;
@end

@implementation HomePageTableViewCell
/**
-(UITableView *)homePageTableView
{
    if (!_homePageTableView) {
        _homePageTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _homePageTableView.delegate = self;
        _homePageTableView.dataSource = self;
        _homePageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_homePageTableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"HomeTableViewCell"];
    }
    return _homePageTableView;
}

**/

-(UICollectionView *)homePageCollectionView
{
    if (!_homePageCollectionView) {
        
        UICollectionViewFlowLayout *flowLayouts= [[UICollectionViewFlowLayout alloc] init];
        CGFloat itemWidth = (kScale_Width - 30) / 3;
        
        // 设置每个item的大小
        flowLayouts.itemSize = CGSizeMake(itemWidth, itemWidth + 20 + 30);
        
        // 设置列间距
        flowLayouts.minimumInteritemSpacing = 1;
        
        // 设置行间距
        flowLayouts.minimumLineSpacing = 1;
        
        //每个分区的四边间距UIEdgeInsetsMake
        flowLayouts.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _homePageCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayouts];
        _homePageCollectionView.collectionViewLayout = flowLayouts;
        _homePageCollectionView.delegate = self;
        _homePageCollectionView.dataSource = self;
        [_homePageCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    }
    return _homePageCollectionView;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViewInfo];
    }
    return self;
}
-(void)setupViewInfo
{
//    [self addSubview:self.homePageTableView];
    [self addSubview:self.homePageCollectionView];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 31;
}

/**
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 31;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80 * kScale_Height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableViewCell" forIndexPath:indexPath];
    
    return cell;
}

**/

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
	
