//
//  IQEngCollectionViewFlowLayout.m
//  IQEngCarousel
//
//  Created by 程恒盛 on 17/3/10.
//  Copyright © 2017年 力王. All rights reserved.
//

#import "IQEngCollectionViewFlowLayout.h"

@implementation IQEngCollectionViewFlowLayout
-(instancetype)init{
    if (self = [super init]) {
        self.pagingEnabled = YES;
        self.minimumLineSpacing = 0;
        self.minimumInteritemSpacing = 0;
    }
    return self;
}
//使用自定义布局
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
/**
 停止拖拽时调用这个方法，重写该方法实现整页滚动效果
 
 @param proposedContentOffset 滑动之后最后停的位置
 @param velocity              <#velocity description#>
 
 @return 停留位置
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    
    BOOL pagingEnabled = self.pagingEnabled;
    if (pagingEnabled == NO) {
        return [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
    }
    CGRect rect = CGRectZero;
    rect.origin = proposedContentOffset;
    rect.size = self.collectionView.frame.size;
    //获取停止时，显示的cell的frame
    NSArray *tempArray  = [self layoutAttributesForElementsInRect:rect];
    //初始化衡量值
    CGFloat  gap = 1000.f;
    //偏离中心x
    CGFloat  f1_MidX = 0.f;
    for (int i = 0; i < tempArray.count; i++) {
        //判断和中心的距离，得到最小的那个
        if (gap > ABS([tempArray[i] center].x - proposedContentOffset.x - self.collectionView.frame.size.width * 0.5)) {
            gap =  ABS([tempArray[i] center].x - proposedContentOffset.x - self.collectionView.frame.size.width * 0.5);
            f1_MidX = [tempArray[i] center].x - proposedContentOffset.x - self.collectionView.frame.size.width * 0.5;
        }
    }
    //整页滚动停留位置
    CGPoint  point = CGPointMake(proposedContentOffset.x + f1_MidX , proposedContentOffset.y);
    return point;
}
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *tempArray  = [super  layoutAttributesForElementsInRect:rect];
//    NSMutableArray *tempArray_m = [[NSMutableArray alloc] initWithArray:tempArray];
//    UICollectionViewLayoutAttributes *butes = [self layoutAttributesForItemAtIndexPath:[self.carouselView lastIndexPath]];
//    if (![tempArray_m containsObject:butes]&&butes) {
//        [tempArray_m insertObject:butes atIndex:0];
//    }
    return tempArray;
}
- (void)prepareLayout
{
    [super prepareLayout];
}
@end
