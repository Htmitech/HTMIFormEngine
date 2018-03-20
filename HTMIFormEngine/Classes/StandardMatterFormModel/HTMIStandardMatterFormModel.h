//
//  HTMIStandardMatterFormModel.h
//  MXClient
//
//  Created by wlq on 2018/01/23.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HTMIStandardActionModel;
@class HTMIStandardTabItemModel;
@class HTMIStandardAttachModel;
@class HTMIStandardTrackInfoModel;


@interface HTMIStandardMatterFormModel : NSObject<NSCopying>

/**
 流程实例Id（工作流构件适用）
 */
@property (nonatomic, copy) NSString *docId;

/**
 表单Id（通用表单适用）
 */
@property (nonatomic, copy) NSString *formId;

/**
 表单对应的数据ID（通用表单构件适用）
 */
@property (nonatomic, copy) NSString *dataId;

/**
 Tab页签列表  TabItems -> tabItems (tabFormArray)
 */
@property (nonatomic, strong) NSArray <HTMIStandardTabItemModel *> *tabItems;

//RegionItems 未使用过

/**
 表单中的可编辑字段。提交表单时回传的字段和字段值列表。打开详情时返回为空。提交接口时才会用到。
 */
//@property (nonatomic, strong) NSArray <NSDictionary *> *editFieldsArray;

/**
 表示当前办理人，对当前可以办理的动作 actionInfoArray -> listActionInfo
 */
@property (nonatomic, strong) NSArray <HTMIStandardActionModel *> *listActionInfo;
/**
当前流程实例的附件列表 attachInfoArray ->listAttInfo
 */
@property (nonatomic, strong) NSArray <HTMIStandardAttachModel *> *listAttInfo;

/**
 有多个活动节点时，返回给手机端需要手机端选择的跟踪ID列表 trackInfoArray ->listTrackInfo
 */
@property (nonatomic, strong) NSArray <HTMIStandardTrackInfoModel *> *listTrackInfo;

/**
 正文Id(有正文时)
 正文ID，如果该字端返回空，则表示没有正文。否则，可以用该字段保存正文ID备用，提取正文内容和下载正文需要传入该参数。
 docAttachmentIdString ->docAttachmentId
 */
@property (nonatomic, copy) NSString *docAttachmentId;

/**
流程Id
 */
@property (nonatomic, copy) NSString *flowId;

/**
 流程名称
 */
@property (nonatomic, copy) NSString *flowName;

/**
当前节点Id
 */
@property (nonatomic, copy) NSString *currentNodeId;

/**
 当前节点名称
 */
@property (nonatomic, copy) NSString *currentNodeName;

/**
当前办理人Id
 */
@property (nonatomic, copy) NSString *currentUserId;

/**
 当前办理人姓名
 */
@property (nonatomic, copy) NSString *currentUsername;

/**
 当前跟踪Id
 跟踪ID------动作提交必须(慧正OA，用来唯一确定一个实例的一个路由)
 */
@property (nonatomic, copy) NSString *currentTrackId;

/**
 后续操作，需要回发到服务器列表中返回的字段 appid，用来决定跟哪个第三方系统进行交互。
 (发给手机端的，需要回发到服务器。列表中返回的字段 appid，用来决定调用哪个路径的api)
 kind -> systemCode
 */
@property (nonatomic, copy) NSString *systemCode;

///**
// OWA正文URL
//删除，不再使用
//调整，放到“正文”Tab下的tabContent中，tabType：
///// Tab的类型：
//1，原生渲染表单
//2，全文签批(点聚产品对接）
//       3，URL网页， tabContent中存储Html网页的路径
//       4，OWA正文， tabContent中存储OWA正文路径
//       5，PDF正文，tabContent中存储PDF正文URL
//       6，附件
//       7，流程历史
//
//       tabType=4
//       PDF正文的URL从
//       tabContent中取
//
// */
//@property (nonatomic, copy) NSString *docViewUrlString;

@end
