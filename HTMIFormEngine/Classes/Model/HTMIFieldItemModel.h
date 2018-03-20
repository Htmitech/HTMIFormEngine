//
//  HTMIFieldItemModel.h
//  MXClient
//
//  Created by 赵志国 on 2017/10/16.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HTMIItemOpintionModel.h"

#import "HTMIItemDicsModel.h"

#import <UIKit/UIKit.h>

@class HTMITabFormModel;

@class ACSelectMediaView_form;
@class HTMIStandardFieldItemModel;
@class HTMIWorkFlowExtModel;
@class HTMIStandardAjaxEventModel;
@class HTMIStandardFiledFileModel;
@class HTMIStandardSignModel;

@interface HTMIFieldItemModel : NSObject<NSCopying>

/**
 name 字段
 */
@property (nonatomic, copy) NSString *nameString;
@property (nonatomic, copy) NSString *beforeNameString;
@property (nonatomic, copy) NSString *endNameString;

/**
 是否显示 name 字段
 */
@property (nonatomic, assign) BOOL nameVisible;

/**
 name字段名称和Value之间是否隔行显示
 */
@property (nonatomic, assign) BOOL nameRN;

/**
 name字段名称和Value之间的分割符号
 */
@property (nonatomic, copy) NSString *splitString;

/**
 value 字段
 */
@property (nonatomic, copy) NSString *valueString;
@property (nonatomic, copy) NSString *beforeValueString;
@property (nonatomic, copy) NSString *endValueString;

/**
 每个 item 占屏比
 */
@property (nonatomic, assign) NSInteger percent;

/**
 该item的对齐方式三种。为空时，按Left处理；  Right，Center，Left
 */
@property (nonatomic, copy) NSString *alignString;

/**
 表单id_字段id，用于与第三方系统交互时，匹配字段。非常重要。
 */
@property (nonatomic, copy) NSString *keyString;

/**
 显示类型  1:编辑
 */
@property (nonatomic, copy) NSString *modeString;

/**
 输入类型
 */
@property (nonatomic, copy) NSString *inputString;

/**
 wlq add 2016/09/12 字段限制的最大长度
 */
@property (nonatomic, assign) NSInteger maxLength;

/**
 必填项
 */
@property (nonatomic, assign) BOOL mustInput;

/**
 意见列表
 */
@property (nonatomic, strong) NSArray <HTMIItemOpintionModel *> *opintionArray;

/**
 签名
 */
@property (nonatomic, strong) NSArray <HTMIStandardSignModel *> *signs;

/**
 编辑时用到的选项列表
 */
@property (nonatomic, strong) NSArray <HTMIItemDicsModel *> *dicsArray;

/**
 颜色相关
 */
@property (nonatomic, assign) NSInteger backColor;
@property (nonatomic, assign) NSInteger nameBackColor;
@property (nonatomic, assign) NSInteger nameFontColor;
//已经删除了
//@property (nonatomic, assign) NSInteger valueBackColor;
@property (nonatomic, assign) NSInteger valueFontColor;

///**
// 为了解决，多tab页，每页内容上传的问题
// */
@property (nonatomic, copy) NSString *formkeyString;

/**
 字段id
 */
@property (nonatomic, copy) NSString *fieldIdString;

/**
 扩展字段_图片
 */
@property (nonatomic, strong) NSArray <HTMIWorkFlowExtModel *> *filedImageArray;

/**
 扩展字段_音频
 */
@property (nonatomic, strong) NSArray <HTMIWorkFlowExtModel *> *filedAudioArray;

/**
 扩展字段_视频
 */
@property (nonatomic, strong) NSArray <HTMIWorkFlowExtModel *> *filedVideoArray;

/**
 是否扩展字段
 */
@property (nonatomic, assign) BOOL is_ext;

/**
 事件   2.5.5  add
 */
@property (nonatomic, strong) HTMIStandardAjaxEventModel *ajaxEventModel;


#pragma mark ------ 以下为自己需要添加
@property (nonatomic, copy) NSString *eidtValueString;

/**
 *  签名还是意见
 */
@property (nonatomic, copy) NSString *autographOrOpinionString;

#pragma mark ------ 扩展字段
@property (nonatomic, strong) ACSelectMediaView_form *mediaView;
@property (nonatomic, assign) CGFloat imageHeight;
@property (nonatomic, strong) NSArray *imageArray;


/**
 自己录制添加的音频路径
 */
@property (nonatomic, strong) NSMutableArray *extFiledAudiosAddMarray;

/**
 表单字体大小
 */
@property (nonatomic, assign, readonly) CGFloat formLabelFont;

/**
 必填提示
 */
@property (nonatomic, assign) BOOL isShowMustInputWarning;

/**
 水规定制考勤添加，是否隐藏字段，默认全部不隐藏
 */
@property (nonatomic, assign) BOOL isHidden;





/**
 当前用户的用户名
 */
@property (nonatomic, copy) NSString *myUserName;

/**
 <#Description#>
 */
@property (nonatomic, assign) BOOL scheduleFormNetWorkStyle;

/**
 算好的当前字段自己的宽度
 */
@property (nonatomic, assign) CGFloat finalItemWidth;

/**
 拼接好的字段名称
 */
@property (nonatomic, copy) NSString *finalNameString;

/**
 拼接好的字段值
 */
@property (nonatomic, copy) NSString *finalValueString;

/**
 指定初始化方法
 
 @param standardFieldItemModel 标准字段模型
 @return 字段模型
 */
- (instancetype)initWithStandardFieldItemModel:(HTMIStandardFieldItemModel *)standardFieldItemModel;

/**
 使用标准意见模型数组初始化意见模型数组
 
 @param standardOpintionModelArray 标准意见模型数组
 */
- (void)htmi_setOpintionArrayWithStandardOpintionModelArray:(NSArray<HTMIStandardOpintionModel *> *)standardOpintionModelArray;

/**
 使用标准字典模型数组初始化字典模型数组
 
 @param standardDicModelArray 标准字典模型数组
 */
- (void)htmi_setDicsArrayWithStandardDicModelArray:(NSArray<HTMIStandardDicModel *> *)standardDicModelArray;

/**
 设置图片文件模型集合
 
 @param standardFiledFileModelArray 标准图片文件模型集合
 */
- (void)htmi_setExtFiledImagesArrayWithStandardFiledFileModelArray:(NSArray <HTMIStandardFiledFileModel *>*)standardFiledFileModelArray;

/**
 设置音频文件模型集合
 
 @param standardFiledFileModelArray 标准音频文件模型集合
 */
- (void)htmi_setExtFiledAudioArrayWithStandardFiledFileModelArray:(NSArray <HTMIStandardFiledFileModel *>*)standardFiledFileModelArray;

/**
 设置视频文件模型集合
 
 @param standardFiledFileModelArray 标准视频文件模型集合
 */
- (void)htmi_setExtFiledVideoArrayWithStandardFiledFileModelArray:(NSArray <HTMIStandardFiledFileModel *>*)standardFiledFileModelArray;
/**
 设置表单字体
 
 @param font 字号大小
 */
- (void)htmi_setupFormLabelFont:(CGFloat)font;

/**
 清空音频文件数组
 */
- (void)htmi_removeAllFiledAudiosAarrayItem;

/**
 验证是否是必填
 
 @param mustinput 必填
 @param value 值
 @return 是否必填
 */
- (BOOL)isMustInput:(BOOL)mustinput value:(NSString *)value;

/**
 根据意见的值更新数据
 
 @param opinion 意见
 */
- (void)htmi_updateOpinion:(NSString *)opinion;

@end
