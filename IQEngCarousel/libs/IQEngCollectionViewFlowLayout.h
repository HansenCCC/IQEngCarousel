//
//  IQEngCollectionViewFlowLayout.h
//  IQEngCarousel
//  功能：实现整页滚动
//  Created by 程恒盛 on 17/3/10.
//  Copyright © 2017年 力王. All rights reserved.
//  因：虽然系统的collectionview.pageingEnabled属性可以实现整页滚动，但次整页的size是collectionview.frame.size 大小，当cell的size不与collectionview尺寸相等时，这个属性就毫无意义

#import <UIKit/UIKit.h>

@interface IQEngCollectionViewFlowLayout : UICollectionViewFlowLayout
//是否整页滚动 （默认YES）
@property(nonatomic,getter=isPagingEnabled) BOOL pagingEnabled;

@end
