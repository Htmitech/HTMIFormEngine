//
//  HTMIWorkFlowDetailTableViewCell.h
//  MXClient
//
//  Created by wlq on 2018/1/29.
//  Copyright © 2018年 MXClient. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HTMIRegionCellModel;
@class HTMITabFormModel;
@class HTMIFieldItemModel;
@class HTMIFormBaseView;
//@class HTMIOAMatterFormTableViewController;



@interface HTMIWorkFlowDetailTableViewCell : UITableViewCell


/**
 水印透明度
 */
@property (nonatomic, readonly,assign) CGFloat waterMarkAlpha;

/**
 数据源
 */
@property (nonatomic, readonly ,weak) HTMITabFormModel *tabFormModel;

/**
 行数据源
 */
@property (nonatomic, readonly ,weak) HTMIRegionCellModel *infoRegion;

/**
 表单的整体字体大小
 */
@property (nonatomic, readonly ,assign) NSInteger formLabelFont;

/**
 控制器
 */
@property (nonatomic, readonly ,weak) UIViewController *controller;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier superView:(UIView *)superView;


- (void)configureCellWithRegionCellModel:(HTMIRegionCellModel *)infoRegion atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView;

- (void)setupDataSourceWithRegionCellModel:(HTMIRegionCellModel *)infoRegion
                              tabFormModel:(HTMITabFormModel *)tabFormModel
                            waterMarkAlpha:(CGFloat)waterMarkAlpha
                             formLabelFont:(NSInteger)formLabelFont
           oaMatterFormTableViewController:(UIViewController *)oaMatterFormTableViewController;

@end
