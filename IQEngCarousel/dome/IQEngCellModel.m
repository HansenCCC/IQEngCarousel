//
//  IQEngCellModel.m
//  IQEngCarousel
//
//  Created by 程恒盛 on 17/3/14.
//  Copyright © 2017年 力王. All rights reserved.
//

#import "IQEngCellModel.h"

@implementation IQEngCellModel
-(instancetype)initWithTitle:(NSString *) title cellClass:(Class) cellClass{
    if (self = [self init]) {
        self.cellClass = cellClass;
        self.title = title;
    }
    return self;
}

@end
