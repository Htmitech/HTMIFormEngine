//
//  HTMIStandardRegionModel.h
//  MXClient
//
//  Created by wlq on 2017/01/23.
//  Copyright © 2018年 MXClient. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HTMIStandardFieldItemModel.h"

@interface HTMIStandardRegionModel : NSObject<NSCopying>

/**
 服务器返回给手机端时，已经排好序。手机端不用处理
 
 @property (nonatomic, assign) NSInteger displayOrder;
 */


/**
 行顺序
 */
@property (nonatomic, copy) NSString *displayOrder;

/**
 整个行是否显示纵向分割线
 */
@property (nonatomic, assign) BOOL vlineVisible;

/**
 信息块的（行）ID
 */
@property (nonatomic, copy) NSString *regionId;

/**
 列列表 该信息块中包含的字段和值。
 */
@property (nonatomic, strong) NSArray <HTMIStandardFieldItemModel *> *fieldItems;

/**
 当前行（region）是表格，如果是ture则，当前region是表格的一部分
 */
@property (nonatomic, assign) BOOL isTable;

/**
 当isTable=true时，用来存子表的标识ID
 */
@property (nonatomic, copy) NSString *tableId;

/**
 当前“区域”属于哪个表格
 当前“行”属于哪个表格
 */
@property (nonatomic, copy) NSString *parentTableId;

/**
 表示当前行的整体背景颜色。多于的设计？暂时保留。表单配置器上也已经删除该配置
 */
@property (nonatomic, assign) NSInteger backColor;

/**
 是否折叠区域、间隔区域，是否为分组间隔
 */
@property (nonatomic, assign) BOOL isSplitRegion;

/**
 打开子表方式   0，无（高度20分组间隔） 1，折叠；2，点击弹出新的页面
 */
@property (nonatomic, assign) NSInteger splitAction;

/**
 
 父级行，表示行的隶属关系。表示折叠到哪个Region上；或ParentRegionID弹出新页面时，调出的Region有哪些
 
 表示行的隶属关系。
 
 表示折叠到哪个Region上；
 或
 ParentRegionID弹出新页面时，调出的Region有哪些
 */
@property (nonatomic, copy) NSString *parentRegionId;

/**
 滑动标记： 0 不滑动,1 水平滑动
 */
@property (nonatomic, assign) NSInteger scrollFlag;

/**
 水平滑动时，固定前几列。默认：0（不固定）
 */
@property (nonatomic, assign) NSInteger scrollFixColCount;

#pragma mark - 以下可能是自定义的

///**
// 滑动子表宽度
// */
//@property (nonatomic, strong) NSMutableArray *eachMaxWidthArray;
//@property (nonatomic, strong) NSMutableDictionary *allMaxWidthDic;
//
//@property (nonatomic, assign) BOOL isOpen;
//
//+ (HTMIStandardRegionModel *)getRegionCellModelWithDict:(NSDictionary *)dict;

@end
