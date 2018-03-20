//
//  HTMITabFormModel.h
//  MXClient
//
//  Created by 赵志国 on 2017/10/16.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HTMIRegionCellModel.h"
@class HTMIStandardTabItemModel;
@class HTMIStandardTabEventModel;
@class HTMIWorkFlowEventKeyValueModel;

//表单页面类型
typedef NS_ENUM(NSInteger , HTMIWorkFlowTabType) {
    
    HTMIWorkFlowTabTypeNativeForm = 1,//慧通原生【表单】
    HTMIWorkFlowTabTypeAIPForm = 2,//点聚AIP签批【表单】
    HTMIWorkFlowTabTypeURLForm = 3,//URL网页【表单】
    HTMIWorkFlowTabTypeOWAMainBody = 4,//OWA网页【正文】
    HTMIWorkFlowTabTypeMainBody = 5,//慧通原生【正文】
    HTMIWorkFlowTabTypeAttachment = 6,//【附件】
    HTMIWorkFlowTabTypeFlow = 7,//【流程】
    HTMIWorkFlowTabTypeAIPMainBody = 8,//点聚AIP签批【正文】
    HTMIWorkFlowTabTypePDFForm = 9,//金格PDF签批【表单】
    HTMIWorkFlowTabTypePDFMainBody = 10,//金格PDF签批【正文】
    HTMIWorkFlowTabTypeOFDForm = 11,//数科OFD签批【表单】
    HTMIWorkFlowTabTypeOFDMainBody = 12,//数科OFD签批【正文】
    
};

@interface HTMITabFormModel : NSObject<NSCopying>

/**
 Tab的数据ID，主键
 */
@property (nonatomic, copy) NSString *tabIdString;

@property (nonatomic, copy) NSString *tabNameString;

/**
 Tab的类型：
 1，原生渲染 2，全文签批 3，URL网页
 */
@property (nonatomic, assign) HTMIWorkFlowTabType tabType;

/**
 需要存放的内容，如，
 TabType=1时，无意义；
 TabType=2时，存放全文签批下载路径；
 TabType=3，存放URL路径
 */
@property (nonatomic, copy) NSString *tabContentString;

/**
 Tab对应的数据标记，
 Tab与后台交互的时候，比对内容
 */
@property (nonatomic, copy) NSString *formKeyString;

/**
 Tab之前的显示顺序
 */
@property (nonatomic, assign) NSInteger displayOrder;

/**
 Tab对应的FlowID
 */
@property (nonatomic, copy) NSString *flowIdString;

/**
 表单内容区域（行）的集合
 */
@property (nonatomic, strong) NSArray <HTMIRegionCellModel *> *regionCellArray;

/**
 风格   0:表格式/1:互联网式
 */
@property (nonatomic, assign) NSInteger tabStyle;
/**
 tab用途   查看和审核/创建和发起
 */
@property (nonatomic, assign) NSInteger tabPurpose;

/**
 事件  2.5.5 add readonly ,
 */
@property (nonatomic, strong) HTMIStandardTabEventModel *tabEventModel;

#pragma mark ------ 自己添加属性
/**
 存放子表折叠部分
 */
@property (nonatomic, strong) NSMutableArray *childTabFormMarray;

//wlq add 20180124 初始化时赋值
/**
 事件，所有的key value 当前表单的所有事件
 */
@property (nonatomic, readwrite ,strong) NSArray <HTMIWorkFlowEventKeyValueModel *>*eventKeyValueArray;

/**
 使用标准表单模型初始化表单模型
 
 @param standardTabItemModel 标准表单模型
 @return 表单模型
 */
- (instancetype)initWithStandardTabItemModel:(HTMIStandardTabItemModel *)standardTabItemModel;

@end
