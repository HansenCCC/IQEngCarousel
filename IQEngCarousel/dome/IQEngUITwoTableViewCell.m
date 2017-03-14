//
//  IQEngUITwoTableViewCell.m
//  IQEngCarousel
//
//  Created by 程恒盛 on 17/3/14.
//  Copyright © 2017年 力王. All rights reserved.
//

#import "IQEngUITwoTableViewCell.h"
#import "IQEngCarouselView.h"
#import "IQEngUICollectionViewCell.h"

@interface IQEngUITwoTableViewCell ()<IQEngCarouselViewDelegate>
@property(nonatomic, strong) IQEngCarouselView *carouselView;

@end


@implementation IQEngUITwoTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.carouselView = [[IQEngCarouselView alloc] init];
        self.carouselView.pageControl.hidden = YES;
        self.carouselView.allowAutoNextPage = YES;
        self.carouselView.allowInfiniteBanner = YES;
        self.carouselView.timeInterval = 4;
        self.carouselView.collectionViewLayout.minimumLineSpacing = 20;
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
    
    CGSize itemSize = CGSizeMake(f1.size.width*2/3, f1.size.height*2/3);
    CGFloat blankSpace = (f1.size.width - itemSize.width)/2;
    CGFloat lineSpacing = self.carouselView.collectionViewLayout.minimumLineSpacing;
    UIEdgeInsets insets = UIEdgeInsetsMake(0, blankSpace, 0, -blankSpace + lineSpacing);
    self.carouselView.collectionViewLayout.itemSize = itemSize;
    self.carouselView.collectionViewLayout.sectionInset = insets;
}
#pragma mark - IQEngCarouselViewDelegate
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    IQEngUICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IQEngUICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:rand()%255/255.0 green:rand()%255/255.0 blue:rand()%255/255.0 alpha:1];
    cell.label.text = [NSString stringWithFormat:@"%d",indexPath.row];
    return cell;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIAlertView *v = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"My name is %d",indexPath.row] message:@"i'm here https://www.zhihu.com/people/EngCCC" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
    [v show];
}
@end
