//
//  ViewController.m
//  IQEngCarousel
//
//  Created by 程恒盛 on 17/3/10.
//  Copyright © 2017年 力王. All rights reserved.
//

#import "ViewController.h"
#import "IQEngCellModel.h"

#import "IQEngUIOneTableViewCell.h"
#import "IQEngUITwoTableViewCell.h"
//#import "IQEngUIThereTableViewCell.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong) NSMutableArray <IQEngCellModel *> *models;
@property(nonatomic, strong) UITableView *tableView;

@end
@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.view addSubview:self.tableView];
    
    self.models = [[NSMutableArray alloc] init];
    [self.models addObject:[[IQEngCellModel alloc] initWithTitle:@"普通的轮播视图" cellClass:[IQEngUIOneTableViewCell class]]];
    [self.models addObject:[[IQEngCellModel alloc] initWithTitle:@"轮播视图风格A" cellClass:[IQEngUITwoTableViewCell class]]];
//    [self.models addObject:[[IQEngCellModel alloc] initWithTitle:@"轮播视图风格B" cellClass:[IQEngUIThereTableViewCell class]]];
    
    [self.tableView reloadData];
}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    CGRect bounds = self.view.bounds;
    CGRect f1 = bounds;
    self.tableView.frame = f1;
}
#pragma mark - IQEngCarouselViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Class cellClass = [self.models objectAtIndex:indexPath.section].cellClass;
    [tableView registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(cellClass)];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  self.models.count;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.models objectAtIndex:section].title;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableView.bounds.size.width/2;
}
@end
