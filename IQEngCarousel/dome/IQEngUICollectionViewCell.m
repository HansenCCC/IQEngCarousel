//
//  IQEngUICarouselCollectionViewCell.m
//  轮播图-无限滚动-定时滚动
//
//  Created by 程恒盛 on 17/3/9.
//  Copyright © 2017年 力了个王. All rights reserved.
//

#import "IQEngUICollectionViewCell.h"

@implementation IQEngUICollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageView];
        
        self.label = [[UILabel alloc] init];
        self.label.font = [UIFont systemFontOfSize:50];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.label];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.bounds;
    CGRect f1 = bounds;
    self.imageView.frame = f1;
    self.label.frame = f1;
}
@end
