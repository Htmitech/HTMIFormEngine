//
//  HTMIRegionCellModel.h
//  MXClient
//
//  Created by 赵志国 on 2017/10/16.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HTMIFieldItemModel.h"
@class HTMIStandardRegionModel;
@class HTMIWorkFlowEventKeyValueModel;

@interface HTMIRegionCellModel : NSObject<NSCopying>

/**
 服务器返回给手机端时，已经排好序。手机端不用处理
 
 @property (nonatomic, assign) NSInteger displayOrder;
 */

/**
 整个行是否显示纵向分割线
 */
@property (nonatomic, assign) BOOL vlineVisible;

/**
 信息块的（行）ID
 */
@property (nonatomic, copy) NSString *regionIdString;

/**
 该信息块中包含的字段和值。
 */
@property (nonatomic, strong) NSArray <HTMIFieldItemModel *> *fieldItemArray;

/**
 如果是ture则，当前region是表格的一部分
 */
@property (nonatomic, assign) BOOL isTable;

/**
 当isTable=true时，用来存子表的标识ID
 */
@property (nonatomic, copy) NSString *tableIdString;

/**
 当前“行”属于哪个表格
 */
@property (nonatomic, copy) NSString *parentTableIdString;

/**
 表示当前行的整体背景颜色
 */
@property (nonatomic, assign) NSInteger backColor;

/**
 表示当前行的整体背景颜色
 */
@property (nonatomic, strong) UIColor *backColorForCell;

/**
 是否为分组间隔
 */
@property (nonatomic, assign) BOOL isSplitRegion;

/**
 打开子表方式   0，无（高度20分组间隔） 1，折叠；2，点击弹出新的页面
 */
@property (nonatomic, assign) NSInteger splitAction;

/**
 表示行的隶属关系。
 
 表示折叠到哪个Region上；
 或
 ParentRegionID弹出新页面时，调出的Region有哪些
 */
@property (nonatomic, copy) NSString *parentRegionIdString;

/**
 滑动子表
 */
@property (nonatomic, assign) NSInteger scrollFlag;

/**
 滑动子表固定行
 */
@property (nonatomic, assign) NSInteger scrollFixColCount;

//wlq delete 2018024 没有使用过下面的两个属性
/**
 滑动子表宽度
 */
//@property (nonatomic, strong) NSMutableArray *eachMaxWidthArray;
//@property (nonatomic, strong) NSMutableDictionary *allMaxWidthDic;

@property (nonatomic, assign) BOOL isOpen;

//wlq add 20180124 初始化时赋值
/**
 事件，所有的key value
 */
@property (nonatomic, readwrite ,strong) NSArray <HTMIWorkFlowEventKeyValueModel *>*eventKeyValueArray;

/**
 tableviewcell 的高度
 */
@property (nonatomic, assign) CGFloat tableViewCellHeight;

/**
 表单整体的水印透明度
 */
@property (nonatomic, assign) CGFloat waterMarkAlpha;

/**
 风格   0:表格式/1:互联网式
 */
@property (nonatomic, assign) NSInteger tabStyle;

/**
 当前模型的indexPath
 */
@property (nonatomic, strong) NSIndexPath *indexPath;

/**
 指定模型初始化
 
 @param standardRegionModel 标准区域模型
 @return 区域模型
 */
- (instancetype)initWithStandardRegionModel:(HTMIStandardRegionModel *)standardRegionModel;

/**
 从模型获取cell高度
 
 @param tabFormModel 页签模型
 @param formLabelFont 表单整体字体
 @return 模型对应的cell高度
 */
- (CGFloat)tableViewCellHeightByTabFormModel:(HTMITabFormModel *)tabFormModel
                               formLabelFont:(NSInteger)formLabelFont;

@end
