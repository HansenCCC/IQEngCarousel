//
//  IQEngUIOneTableViewCell.m
//  IQEngCarousel
//
//  Created by 程恒盛 on 17/3/14.
//  Copyright © 2017年 力王. All rights reserved.
//

#import "IQEngUIOneTableViewCell.h"
#import "IQEngCarouselView.h"

@interface IQEngUIOneTableViewCell ()<IQEngCarouselViewDelegate>
@property(nonatomic, strong) IQEngCarouselView *carouselView;

@end

@implementation IQEngUIOneTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.carouselView = [[IQEngCarouselView alloc] init];
        self.carouselView.allowAutoNextPage = YES;
        self.carouselView.allowInfiniteBanner = YES;
        self.carouselView.timeInterval = 4;
        [self.carouselView.collectionView registerClass:[IQEngUICollectionViewCell class] forCellWithReuseIdentifier:@"IQEngUICollectionViewCell"];
        self.carouselView.delegate = self;
        [self.contentView addSubview:self.carouselView];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    CGRect f1 = bounds;
    self.carouselView.frame = f1;
}
#pragma mark - IQEngCarouselViewDelegate
-(UICollectionViewCell *)iqCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    IQEngUICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IQEngUICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:rand()%255/255.0 green:rand()%255/255.0 blue:rand()%255/255.0 alpha:1];
    cell.label.text = [NSString stringWithFormat:@"%d",indexPath.row];
    return cell;
}
-(NSInteger)iqCollectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
-(CGSize)iqCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return collectionView.bounds.size;
}
-(void)iqCollectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIAlertView *v = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"My name is %d",indexPath.row] message:@"i'm here https://www.zhihu.com/people/EngCCC" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
    [v show];
}


@end
