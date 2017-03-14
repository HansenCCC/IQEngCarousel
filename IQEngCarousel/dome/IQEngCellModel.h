//
//  IQEngCellModel.h
//  IQEngCarousel
//
//  Created by 程恒盛 on 17/3/14.
//  Copyright © 2017年 力王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IQEngCellModel : NSObject
@property(nonatomic, assign) Class cellClass;
@property(nonatomic, strong) NSString *title;

-(instancetype)initWithTitle:(NSString *) title cellClass:(Class) cellClass;
@end
