//
//  IQEngCarouselView.h
//  IQEngCarousel
//  轮播主视图
//  Created by 程恒盛 on 17/3/10.
//  Copyright © 2017年 力王. All rights reserved.
//  轮播列表基于collectionview实现，实现轮播思路是section设置一个值(IQEngCarouselViewNumberOfSections)，初始collectionview当前偏移量为section/2,从而实现循环轮播

#import <UIKit/UIKit.h>
#import "IQEngCollectionViewFlowLayout.h"

#define IQEngCarouselViewNumberOfSections 100 //限制
#define IQEngCarouselDefualtTimeInterval 4 //默认翻页时间间隙

//定义collectionview点击block
typedef void(^IQEngCarouselClickBlock)(NSIndexPath *indexPath);

@protocol IQEngCarouselViewDelegate <NSObject>//对轮播界面的扩展
@required
-(UICollectionViewCell *)iqCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
-(NSInteger)iqCollectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;

@optional
/**
 相应点击UICollectionViewCell事件，当点击cell时，协议方法和block whenClick 都会执行，协议方法优先级高于block

 @param collectionView UICollectionView
 @param indexPath      坐标
 */
-(void)iqCollectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 优先级高于collectionViewLayout.itemSize

 @param collectionView       UICollectionView
 @param collectionViewLayout flowLayer
 @param indexPath            indexPath

 @return size
 */
-(CGSize)iqCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 当collectionView 滚动是调用此方法（用于自定义轮播扩展）

 @param scrollView <#scrollView description#>
 */
-(void)iqCollectionViewDidEndScrolling:(UIScrollView *)scrollView;

@end

@interface IQEngCarouselView : UIView
<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic, readonly) UIPageControl *pageControl;
@property(nonatomic, readonly) UICollectionView *collectionView;
@property(nonatomic, readonly) NSIndexPath *currentIndexPath;//获取当前显示cell
@property(nonatomic, readonly) NSIndexPath *nextIndexPath;
@property(nonatomic, readonly) NSIndexPath *lastIndexPath;


//flowLayout 未设置时自动设置默认
@property(nonatomic, strong) UICollectionViewFlowLayout *collectionViewLayout;
//递用链传递
@property(nonatomic, assign) id <IQEngCarouselViewDelegate> delegate;
//选中block回调 协议方法优先级高于block
@property(nonatomic, strong) IQEngCarouselClickBlock whenClick;
//允许轮播，不允许时，左右滑到界限不允许滚动  defalut YES
@property(nonatomic, assign) BOOL allowInfiniteBanner;
//允许自动滚动    default YES
@property(nonatomic, assign) BOOL allowAutoNextPage;
//翻页时间间隔 default 4s
@property(nonatomic, assign) NSInteger timeInterval;
//是允许点击中间 cell default NO
@property(nonatomic, assign) BOOL allEqual;

/**
 *  标准初始化方法
 */
-(instancetype)init;
-(instancetype)initWithDelegate:(id <IQEngCarouselViewDelegate>) delegate;
/**
 根据当先cell，寻找合适尺寸

 @param animated <#animated description#>
 */
-(void)iqScrollToMostSuitableAnimated:(BOOL)animated;
/**
 滚动到指定indexPath，若想修改滚动时间和动画。最好的方法是重写此方法

 @param indexPath 目标indexPath
 @param animated  <#animated description#>
 */
-(void)iqScrollToIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;
/**
 cell尺寸  （修改方法：实现IQEngCarouselViewDelegate<collectionView:layout:sizeForItemAtIndexPath:>的代理方法 或者 设置collectionViewLayout.itemSize）
 */
@property(nonatomic, readonly) CGSize itemSize NS_DEPRECATED_IOS(2_0, 5_0, "Pretending to be very NB") __TVOS_PROHIBITED;
@end
