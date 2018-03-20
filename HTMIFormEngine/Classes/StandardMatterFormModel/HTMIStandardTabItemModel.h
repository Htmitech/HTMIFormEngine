//
//  HTMIStandardTabItemModel.h
//  MXClient
//
//  Created by wlq on 2018/01/23.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HTMIStandardRegionModel;
@class HTMIStandardTabEventModel;

@interface HTMIStandardTabItemModel : NSObject<NSCopying>

/**
 Tab的数据ID，主键
 */
@property (nonatomic, copy) NSString *tabId;

/**
 Tab名称
 */
@property (nonatomic, copy) NSString *tabName;

/**
 1: 慧通原生【表单】
 2: 点聚AIP签批【表单】
 3: URL网页【表单】
 4：OWA网页【正文】
 5: 【附件】
 6: 【流程】
 7: 点聚AIP签批【正文】
 8: 金格PDF签批【表单】
 9: 金格PDF签批【正文】
 10: 数科OFD签批【表单】
 11: 数科OFD签批【正文】
 */
@property (nonatomic, assign) NSInteger tabType;

/**
 表单内容容纳的一个字符串扩展（需要存放的内容，如，
 TabType=1时，无意义；
 TabType=2时，存放全文签批下载路径；
 TabType=3，存放URL路径）。
 */
@property (nonatomic, copy) NSString *tabContent;

/**
 表单Key
 当前Tab对应的表单的ID（单个表单tab时返回为空，多个tab时用来区分不同的表单数据。不同的表单下包含了相同的字段key，formkey就尤为重要）
 */
@property (nonatomic, copy) NSString *formKey;

/**
 显示顺序
 返回给手机端时已经排好序了
 */
@property (nonatomic, assign) NSInteger displayOrder;

/**
 流程编号
 冗余字段，方便移动端取值
 */
@property (nonatomic, copy) NSString *flowId;

/**
 表单内容区域（行）的集合
 */
@property (nonatomic, strong) NSArray <HTMIStandardRegionModel *> *regions;

/**
 事件  2.5.5 add tabEventDict -> tabEvent
 */
@property (nonatomic, strong) HTMIStandardTabEventModel *tabEvent;

/**
 Tab展示风格0, 表格式表单； 1，互联网表单
 */
@property (nonatomic, assign) NSInteger tabStyle;
/**
 Tab的用途 0, 查看和审批； 1，创建和发起
 */
@property (nonatomic, assign) NSInteger tabPurpose;

//#pragma mark ------ 自己添加属性
///**
// 存放子表折叠部分
// */
//@property (nonatomic, strong) NSMutableArray *childTabFormMarray;
//
//+ (HTMIStandardTabItemModel *)getTabFormModelWithDict:(NSDictionary *)dict;

@end
