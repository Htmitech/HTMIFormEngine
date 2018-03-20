//
//  HTMIStandardFieldItemModel.h
//  MXClient
//
//  Created by wlq on 2017/01/23.
//  Copyright © 2018年 MXClient. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HTMIStandardFiledFileModel;
@class HTMIStandardAjaxEventModel;
@class HTMIStandardOpintionModel;
@class HTMIStandardDicModel;
@class HTMIStandardSignModel;

@interface HTMIStandardFieldItemModel : NSObject<NSCopying>

/**
 标题名称
 */
@property (nonatomic, copy) NSString *name;

/**
 名称是否显示
 */
@property (nonatomic, assign) BOOL nameVisible;

/**
 字段名称和Value之间可能的分隔符
 */
@property (nonatomic, copy) NSString *splitString;

/**
 字段名称和Value之间是否隔行显示：true表示需要隔行，false表示一行显示
 */
@property (nonatomic, assign) BOOL nameRN;

/**
 值
 */
@property (nonatomic, copy) NSString *value;

/**
 Value值之前的文字
 */
@property (nonatomic, copy) NSString *beforeValueString;

/**
 Value值之后的文字
 */
@property (nonatomic, copy) NSString *endValueString;

/**
 字段占位百分比
 表示改行（一个InfoRegion），中多个字段FieldItems，每个字段对应的宽度比例。
 */
@property (nonatomic, assign) NSInteger percent;

/**
 显示顺序，字段顺序号
 */
@property (nonatomic, copy) NSString *displayOrder;


/**
 该item的对齐方式三种。为空时，按Left处理；  Right，Center，Left
 */
@property (nonatomic, copy) NSString *align;

/**
 字段映射的接口中的字段enName，通常是数据库中字段的名称
 */
@property (nonatomic, copy) NSString *key;

/**
 显示状态
 1:编辑，10只读，100隐藏，
 */
@property (nonatomic, copy) NSString *mode;

/**
 输入类型
 */
@property (nonatomic, copy) NSString *input;

/**
 最大输入长度
 */
@property (nonatomic, assign) NSInteger maxLength;

/**
 是否必填
 */
@property (nonatomic, assign) BOOL mustInput;

/**
 意见列表 opintionArray ->opintions
 */
@property (nonatomic, strong) NSArray <HTMIStandardOpintionModel *> *opintions;

/**
 签名
 */
@property (nonatomic, strong) NSArray <HTMIStandardSignModel *> *signs;

/**
 编辑时用到的选项列表 dicsArray ->dics
 */
@property (nonatomic, strong) NSArray <HTMIStandardDicModel *> *dics;

/**
 表示是否在name和Value之间显示分割线；为true时，splitstring不起作用。
 */
@property (nonatomic, assign) BOOL isSplitWithLine;

/**
 表示当前字段的整体背景颜色
 */
@property (nonatomic, assign) NSInteger backColor;

//已删除 Name的背景颜色，因为增加该字段会增加程序处理的复杂度
//@property (nonatomic, assign) NSInteger nameBackColor;

/**
 表示Name的字体颜色
 */
@property (nonatomic, assign) NSInteger nameFontColor;

//已删除 值背景颜色，因为增加该字段会增加程序处理的复杂
//@property (nonatomic, assign) NSInteger valueBackColor;

/**
 值字体颜色
 */
@property (nonatomic, assign) NSInteger valueFontColor;


/**
 为了解决，多tab页，每页内容上传的问题
 */
@property (nonatomic, copy) NSString *formKey;

/**
 字段Id（自增唯一主键）
 */
@property (nonatomic, copy) NSString *fieldId;

/**
 该字段包含的图片列表（与是否扩展没有关系，所以去掉了ext开头的写法。）
 extFiledImagesArray ->filedImages
 */
@property (nonatomic, strong) NSArray <HTMIStandardFiledFileModel *> *filedImages;

/**
 扩展字段_音频 extFiledAudiosMarray ->filedAudios
 */
@property (nonatomic, strong) NSArray <HTMIStandardFiledFileModel *> *filedAudios;

/**
 扩展字段_视频 extFiledVideosArray -> filedVideos
 */
@property (nonatomic, strong) NSArray <HTMIStandardFiledFileModel *> *filedVideos;

/**
 是否扩展字段
 */
@property (nonatomic, assign) BOOL isExt;

/**
 事件定义   2.5.5  add ajaxEventDict -> ajaxEvent
 */
@property (nonatomic, strong) HTMIStandardAjaxEventModel *ajaxEvent;

@end
