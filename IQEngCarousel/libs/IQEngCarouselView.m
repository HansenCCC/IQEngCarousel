//
//  IQEngCarouselView.m
//  IQEngCarousel
//
//  Created by 程恒盛 on 17/3/10.
//  Copyright © 2017年 力王. All rights reserved.
//

#import "IQEngCarouselView.h"
#import "IQEngCollectionViewFlowLayout.h"

@interface IQEngCarouselView ()<UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong) UIPageControl *pageControl;
@property(nonatomic, strong) UICollectionView *collectionView;

@end

@implementation IQEngCarouselView{
    CGSize _itemSize;
    BOOL _beenInitialPosition;
    NSTimer *_timer;
}
-(NSString *)description{
    return [NSString stringWithFormat:@"%@:%@",[self class],[super description]];
}
-(instancetype)init{
    if (self = [super init]) {
        [self initialization];
    }
    return self;
}
-(instancetype)initWithDelegate:(id <IQEngCarouselViewDelegate>) delegate{
    if (self = [self init]) {
        self.delegate = delegate;
    }
    return self;
}
-(void)initialization{//初始化
    self.timeInterval = IQEngCarouselDefualtTimeInterval;
    
    self.allowAutoNextPage = YES;
    self.allowInfiniteBanner = YES;
    self.allEqual = NO;

}
-(void)setAllowAutoNextPage:(BOOL)allowAutoNextPage{
    _allowAutoNextPage = allowAutoNextPage;
    if (allowAutoNextPage) {
        [self removeTimer];//先移除当前
        [self addTimer];
    }else{
        [self removeTimer];
    }
}
-(void)setAllowInfiniteBanner:(BOOL)allowInfiniteBanner{
    _allowInfiniteBanner = allowInfiniteBanner;
}
-(void)setTimeInterval:(NSInteger)timeInterval{
    if (_timeInterval == timeInterval) {
        return;
    }
    _timeInterval = timeInterval;
    [self removeTimer];
    [self addTimer];
}
//添加定时器
-(void)addTimer{
    __weak typeof(self) wself = self;
    _timer = [NSTimer scheduledTimerWithTimeInterval:_timeInterval repeats:YES block:^(NSTimer * _Nonnull timer) {
        __weak typeof(self) self = wself;
        [self iqScrollToIndexPath:self.nextIndexPath animated:YES];
    }];
//    __weak typeof(self) wself = self;
//    _timer = [NSTimer timerWithTimeInterval:_timeInterval repeats:YES block:^(NSTimer * _Nonnull timer) {
//        __weak typeof(self) self = wself;
//        [self scrollToIndexPath:self.nextIndexPath animated:YES];
//    }];
//    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
// 删除定时器
-(void)removeTimer{
    [_timer invalidate];
    _timer = nil;
}
-(void)iqScrollToIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated{
    UICollectionViewCell *cell = [self collectionView:self.collectionView cellForItemAtIndexPath:indexPath];
    CGFloat f1_minX = cell.frame.origin.x;
    CGPoint point = CGPointZero;
    point.x = f1_minX;
    CGPoint nextPoint = [self.collectionViewLayout targetContentOffsetForProposedContentOffset:point withScrollingVelocity:CGPointZero];
    [self.collectionView setContentOffset:nextPoint animated:animated];
    //推迟，调用此方法重新开始计时
    [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:_timeInterval]];
}
-(void)scrollToInitialAnimated:(BOOL)animated{
    if (_beenInitialPosition == NO) {
        _beenInitialPosition = YES;
    }else{
        return;
    }
    int section = (self.allowInfiniteBanner?IQEngCarouselViewNumberOfSections:1)/2;
    NSIndexPath *indePath = [NSIndexPath indexPathForItem:0 inSection:section];
    //设置中间值（当collectionview并未设置frame时，此方法会crash）
    [self.collectionView scrollToItemAtIndexPath:indePath atScrollPosition:UICollectionViewScrollPositionLeft animated:animated];
}
-(void)iqScrollToMostSuitableAnimated:(BOOL)animated{
    CGPoint point = [self.collectionViewLayout targetContentOffsetForProposedContentOffset:self.collectionView.contentOffset withScrollingVelocity:CGPointZero];
    [self.collectionView setContentOffset:point animated:animated];
}
//该方法已经被弃用
-(CGSize)itemSize{
    return self.bounds.size;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect bounds = self.bounds;
    CGRect f1 = bounds;
    self.collectionView.frame = f1;
    
    CGRect f2 = bounds;
    f2.origin.y = bounds.size.height - 20;
    f2.size.height = 20;
    self.pageControl.frame = f2;
    
    //设置初始位置
    [self scrollToInitialAnimated:NO];
    
    //适配横竖屏刷新机制
    [self.collectionView reloadData];
    [self iqScrollToMostSuitableAnimated:NO];
}
-(NSIndexPath *)currentIndexPath{
    CGPoint point = CGPointZero;
    point.x = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width/2;
    point.y = self.collectionView.bounds.size.height/2;
    NSIndexPath *indePath = [self.collectionView indexPathForItemAtPoint:point];
    return indePath;
}
-(NSIndexPath *)nextIndexPath{
    NSIndexPath *indexPath = nil;
    NSInteger sections = self.currentIndexPath.section;
    NSInteger row = self.currentIndexPath.row;
    if (row >= [self.collectionView numberOfItemsInSection:sections] - 1) {
        if (sections >= self.collectionView.numberOfSections - 1) {
            sections = (self.allowInfiniteBanner?IQEngCarouselViewNumberOfSections:1)/2;
        }else{
            sections++;
        }
        row = 0;
    }else{
        row ++;
    }
    indexPath = [NSIndexPath indexPathForRow:row inSection:sections];
    return indexPath;
}
-(NSIndexPath *)lastIndexPath{
    NSIndexPath *indexPath = nil;
    NSInteger sections = self.currentIndexPath.section;
    NSInteger row = self.currentIndexPath.row;
    if (row<=0) {
        if (sections<=0) {
            sections = (self.allowInfiniteBanner?IQEngCarouselViewNumberOfSections:1)/2;
        }else{
            sections --;
        }
        row = [self.collectionView numberOfItemsInSection:sections] - 1;
    }else{
        row --;
    }
    indexPath = [NSIndexPath indexPathForRow:row inSection:sections];
    return indexPath;
}
#pragma mark - lazy load
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell_IQEngBaseCell"];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.prefetchingEnabled = NO;
        [self addSubview:_collectionView];
    }
    return _collectionView;
}
-(UICollectionViewFlowLayout *)collectionViewLayout{
    if (!_collectionViewLayout) {
        _collectionViewLayout = [[IQEngCollectionViewFlowLayout alloc] init];
        _collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _collectionViewLayout;
}
-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        NSInteger numberOfPages = [self collectionView:self.collectionView numberOfItemsInSection:0];
        _pageControl.numberOfPages = numberOfPages;
        [self addSubview:_pageControl];
    }
    return _pageControl;
}

#pragma mark - <UICollectionViewDelegate,UICollectionViewDataSource>
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(collectionView:cellForItemAtIndexPath:)]) {
        return [self.delegate collectionView:collectionView cellForItemAtIndexPath:indexPath];
    }
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell_IQEngBaseCell" forIndexPath:indexPath];
    return cell;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if ([self.delegate respondsToSelector:@selector(collectionView:numberOfItemsInSection:)]) {
        return [self.delegate collectionView:collectionView numberOfItemsInSection:section];
    }
    
    return 0;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (!self.allEqual) {
        if (![self.currentIndexPath isEqual:indexPath]) {
            [self iqScrollToIndexPath:indexPath animated:YES];
            return;
        }
    }
    if ([self.delegate respondsToSelector:@selector(collectionView:didSelectItemAtIndexPath:)]) {
        [self.delegate collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    }
    if (self.whenClick) {
        self.whenClick(indexPath);
    }
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    int section = IQEngCarouselViewNumberOfSections;
    return self.allowInfiniteBanner?section:1;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
        return [self.delegate collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath];
    }
    return self.collectionViewLayout.itemSize;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_timer setFireDate:[NSDate distantFuture]];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:_timeInterval]];
    if ([self.delegate respondsToSelector:@selector(collectionViewDidEndScrolling:)]) {
        [self.delegate collectionViewDidEndScrolling:scrollView];
    }
    [self reloadCurrentPageControl];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([self.delegate respondsToSelector:@selector(collectionViewDidEndScrolling:)]) {
        [self.delegate collectionViewDidEndScrolling:scrollView];
    }
    [self reloadCurrentPageControl];
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if ([self.delegate respondsToSelector:@selector(collectionViewDidEndScrolling:)]) {
        [self.delegate collectionViewDidEndScrolling:scrollView];
    }
    [self reloadCurrentPageControl];
}
-(void)reloadCurrentPageControl{
    if (self.pageControl.hidden||self.pageControl.alpha == 0) {
        return;
    }
    NSInteger currentPage = self.currentIndexPath.row;
    self.pageControl.currentPage = currentPage;
}
@end
