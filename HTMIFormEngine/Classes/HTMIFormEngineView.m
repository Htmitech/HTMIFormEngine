//
//  HTMIFormView.m
//  HTMIFormComponent
//
//  Created by 赵志国 on 2018/3/16.
//  Copyright © 2018年 htmitech.com. All rights reserved.
//

#import "HTMIFormEngineView.h"

#import "HTMIWorkFlowDetailTableViewCell.h"

//#import "HTMIMatterFormModel.h"

#import "HTMIConstString.h"

#import "UITableViewCell+GetCell.h"

#import "HTMIApplicationHubManager.h"

#import "HTMITabFormModel.h"

#import "HTMISettingManager.h"

@interface HTMIFormEngineView ()<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView *formTableView;

@property (nonatomic, strong) HTMITabFormModel *tabFormModel;

/**
 控制器
 */
@property (nonatomic, strong) UIViewController *controller;

/**
 水印
 */
@property (nonatomic, assign) CGFloat waterMarkAlpha;

/**
 字体大小
 */
@property (nonatomic, assign) CGFloat formLabelFont;

@end

@implementation HTMIFormEngineView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.formTableView];
    }
    return self;
}

#pragma mark ------ 公有方法
- (void)setTabFormModel:(HTMITabFormModel *)model controller:(UIViewController *)controller waterMarkAlpha:(CGFloat)alpha formLabelFont:(CGFloat)formLabelFont {
    
    _tabFormModel = model;
    _controller = controller;
    _waterMarkAlpha = alpha;
    _formLabelFont = formLabelFont;
    _infoRegionArray = [NSMutableArray arrayWithArray:model.regionCellArray];
    [_infoRegionArray removeObjectsInArray:model.childTabFormMarray];
    
    [self.formTableView reloadData];
}

- (void)reloadFormData {
    
    [self.formTableView reloadData];
}

- (void)saveUserName:(NSString *)userName {
    
    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:kHTMI_User_Name];
}

- (void)setApplicationHub:(id)type {
    
    [[HTMIApplicationHubManager manager] setUpApplicationHue:(HTMIApplicationHueType)type];
}

/**
 设置表单点击用户名聊天权限
 
 @param isCanChart 是否可聊天
 */
- (void)setFormUserNameChart:(BOOL)isCanChart {
    
    
}

#pragma mark ------ UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.infoRegionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *formCell = @"formCell";
    HTMIWorkFlowDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:formCell];

    if (!cell) {
        cell = [[HTMIWorkFlowDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:formCell];

        //表格式表单和互联网表单透明度不一样
//        if (self.waterMarkAlpha < 1 && self.tabFormModel.tabStyle == 1) {
//            self.waterMarkAlpha = 0.8;
//        }
    }
    
    HTMIRegionCellModel  *regionCellModel = self.infoRegionArray[indexPath.row];
    regionCellModel.waterMarkAlpha = self.waterMarkAlpha;
    regionCellModel.tabStyle = self.tabFormModel.tabStyle;
    regionCellModel.indexPath = indexPath;
    
    [cell setupDataSourceWithRegionCellModel:regionCellModel
                                tabFormModel:self.tabFormModel
                              waterMarkAlpha:self.waterMarkAlpha
                               formLabelFont:self.formLabelFont
             oaMatterFormTableViewController:self.controller];
    
    //显示内容
    [cell configureCellWithRegionCellModel:regionCellModel
                               atIndexPath:indexPath
                                 tableView:tableView];

    return cell;
}

/**
 cell高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    HTMIRegionCellModel  *regionCellModel = self.infoRegionArray[indexPath.row];
    CGFloat cellHeight = [regionCellModel tableViewCellHeightByTabFormModel:self.tabFormModel formLabelFont:self.formLabelFont];

    return cellHeight;

}

//主要实现子表功能
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//
//    UIImageView *downImage = nil;
//
//    for (id view in cell.contentView.subviews) {
//        if ([view isKindOfClass:[UIImageView class]]) {
//            downImage = view;
//        }
//    }
//
//    HTMIRegionCellModel *regionCellModel = self.tabFormModel.regionCellArray[indexPath.row];
//
//    if ((regionCellModel.isSplitRegion && regionCellModel.splitAction == 1)) {
//        if (regionCellModel.isOpen) {
//            downImage.image = [UIImage imageNamed:@"btn_angle_up_circle"];
//        } else {
//            downImage.image = [UIImage imageNamed:@"btn_angle_down_circle"];
//        }
//
//        if (!regionCellModel.isOpen) {
//            //展开
//            NSMutableArray *changInfoReginArray = [NSMutableArray array];
//
//            for (HTMIRegionCellModel *model in self.tabFormModel.childTabFormMarray) {
//                if ([model.parentRegionIdString isEqualToString:regionCellModel.regionIdString]) {
//                    [changInfoReginArray addObject:model];
//
//                }
//                [self.infoReginChangedArray addObject:@[regionCellModel.regionIdString,changInfoReginArray]];
//            }
//
//            NSRange range = NSMakeRange(indexPath.row+1, changInfoReginArray.count);
//            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
//            [self.infoRegionArray insertObjects:changInfoReginArray atIndexes:indexSet];
//
//            NSMutableArray *indexPathArray = [NSMutableArray array];
//            for (int i = 0; i < changInfoReginArray.count; i++) {
//                NSIndexPath *path = [NSIndexPath indexPathForItem:(indexPath.row+i+1) inSection:0];
//                [indexPathArray addObject:path];
//            }
//
//            [tableView beginUpdates];
//            [tableView insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationTop];
//            [tableView endUpdates];
//
//        } else {
//            //收回
//            //点击的indexPath.row时dedao其
//            NSInteger count = 0;
//            NSArray *reginArray = nil;
//
//            for (int i = 0; i < self.infoReginChangedArray.count; i++) {
//                NSArray *array = self.infoReginChangedArray[i];
//
//                NSString *reginID = array[0];
//
//                if ([reginID isEqualToString:regionCellModel.regionIdString]) {
//                    reginArray = array[1];
//
//                    [self.infoReginChangedArray removeObject:array];
//                    count += reginArray.count;
//
//                    [self.infoRegionArray removeObjectsInArray:reginArray];
//
//                } else {
//
//                    for (HTMIRegionCellModel *model in reginArray) {
//                        if ([reginID isEqualToString:model.regionIdString]) {
//                            NSArray *array1 = array[1];
//
//                            [self.infoReginChangedArray removeObject:array];
//                            count += array1.count;
//
//                            [self.infoRegionArray removeObjectsInArray:array1];
//
//                            model.isOpen = !model.isOpen;
//                        }
//                    }
//                }
//            }
//
//            NSMutableArray *indexPathArray = [NSMutableArray array];
//
//            for (int i = 0; i < count; i++) {
//                NSIndexPath *path = [NSIndexPath indexPathForItem:(indexPath.row+i+1) inSection:0];
//                [indexPathArray addObject:path];
//            }
//
//            [tableView beginUpdates];
//            [tableView deleteRowsAtIndexPaths:indexPathArray  withRowAnimation:UITableViewRowAnimationTop];
//            [tableView endUpdates];
//        }
//
//        regionCellModel.isOpen = !regionCellModel.isOpen;
//    }
//}



#pragma mark ------ UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    BOOL isScroll = NO;
    
    NSString *currentParentReginIDString = @"";
    for (NSArray *array in self.scrollViewArray) {
        UIScrollView *scroll = array[1];
        if (scrollView == scroll) {
            
            isScroll = YES;
            currentParentReginIDString = array[2];
        }
    }
    
    for (NSArray *array in self.scrollViewArray) {
        UIScrollView *scroll = array[1];
        
        if (isScroll && [currentParentReginIDString isEqualToString:array[2]]) {
            [scroll setContentOffset:CGPointMake(scrollView.contentOffset.x, 0) ];
            
            UITableViewCell *cell = [UITableViewCell getCellBy:scrollView];
            HTMIRegionCellModel *infoRegion = self.infoRegionArray[[self.formTableView indexPathForCell:cell].row];
            
            [self.contentOffSetDic setValue:[NSString stringWithFormat:@"%f",scrollView.contentOffset.x] forKey:infoRegion.parentRegionIdString];
        }
    }
}

#pragma mark ------ 懒加载
- (UITableView *)formTableView {
    if (!_formTableView) {
        _formTableView = [[UITableView alloc] initWithFrame:self.bounds];
        _formTableView.delegate = self;
        _formTableView.dataSource = self;
        _formTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _formTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _formTableView;
}

- (NSMutableArray *)scrollViewArray {
    if (!_scrollViewArray) {
        _scrollViewArray = [NSMutableArray array];
    }
    return _scrollViewArray;
}

- (NSMutableDictionary *)contentOffSetDic {
    if (!_contentOffSetDic) {
        _contentOffSetDic = [NSMutableDictionary dictionary];
    }
    return _contentOffSetDic;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
