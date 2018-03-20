//
//  HTMIFieldItemModel.m
//  MXClient
//
//  Created by 赵志国 on 2017/10/16.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import "HTMIFieldItemModel.h"

//#import "HTMIMatterFormModel.h"

#import "HTMIWorkFlowExtModel.h"

#import "HTMIFormComponentHeader.h"

#import "NSString+HTMISize.h"

#import "HTMIUserdefaultHelper.h"

#import "HTMIFormChangedFieldModel.h"

//#import "HTMIConst.h"

#import "HTMIItemDicsModel.h"

#import "HTMIStandardFieldItemModel.h"

#import "HTMIWorkFlowExtModel.h"
#import "HTMIStandardAjaxEventModel.h"
//#import "HTMILoginUserModel.h"

#import "HTMIStandardSignModel.h"

#import "MJExtension.h"

#import "UtilsMacros.h"

#import "HTMIConstString.h"

@interface HTMIFieldItemModel ()

/**
 表单的字体大小
 */
@property (nonatomic, assign, readwrite) CGFloat formLabelFont;

@end

@implementation HTMIFieldItemModel

- (instancetype)init
{
    return  [self initWithStandardFieldItemModel:nil];
}

/**
 指定初始化方法
 
 @param standardFieldItemModel 标准字段模型
 @return 字段模型
 */
- (instancetype)initWithStandardFieldItemModel:(HTMIStandardFieldItemModel *)standardFieldItemModel
{
    self = [super init];
    if (self) {
        
        _nameString =  standardFieldItemModel.name;
        //已经删除了
        //_beforeNameString =  standardFieldItemModel.beforeNameString;
        //_endNameString =  standardFieldItemModel.endNameString;
        _nameVisible =  standardFieldItemModel.nameVisible;
        _nameRN =  standardFieldItemModel.nameRN;
        _splitString =  standardFieldItemModel.splitString;
        _valueString =  standardFieldItemModel.value;
        _beforeValueString =  standardFieldItemModel.beforeValueString;
        _endValueString =  standardFieldItemModel.endValueString;
        {
            _percent =  standardFieldItemModel.percent;
            _finalItemWidth = kScreenWidth * (_percent / 100.f);
        }
        _alignString =  standardFieldItemModel.align;
        _keyString =  standardFieldItemModel.key;
        _modeString =  standardFieldItemModel.mode;
        _inputString =  standardFieldItemModel.input;
        _maxLength =  standardFieldItemModel.maxLength;
        _mustInput =  standardFieldItemModel.mustInput;
        _backColor =  standardFieldItemModel.backColor;
        //已经删除了
        //_nameBackColor =  standardFieldItemModel.nameBackColor;
        _nameFontColor =  standardFieldItemModel.nameFontColor;
        //_valueBackColor =  standardFieldItemModel.valueBackColor;
        _valueFontColor =  standardFieldItemModel.valueFontColor;
        _formkeyString =  standardFieldItemModel.formKey;
        _fieldIdString =  standardFieldItemModel.fieldId;
        _is_ext =  standardFieldItemModel.isExt;
        _ajaxEventModel =  standardFieldItemModel.ajaxEvent;
        _signs = standardFieldItemModel.signs;
        [self htmi_setOpintionArrayWithStandardOpintionModelArray:standardFieldItemModel.opintions];
        [self htmi_setDicsArrayWithStandardDicModelArray:standardFieldItemModel.dics];
        
        [self htmi_setExtFiledImagesArrayWithStandardFiledFileModelArray:standardFieldItemModel.filedImages];
        [self htmi_setExtFiledAudioArrayWithStandardFiledFileModelArray:standardFieldItemModel.filedAudios];
        [self htmi_setExtFiledVideoArrayWithStandardFiledFileModelArray:standardFieldItemModel.filedVideos];
        
        if ((![_modeString isEqual:[NSNull null]] && [_modeString isEqualToString:@"1"])) {
            
            //处理可编辑状态下的
            [self p_setupEditState];
        }
        else {
            
            //处理不可编辑状态下的 签名
            [self p_setupNoEditState];
        }
        
        _myUserName = [[NSUserDefaults standardUserDefaults] objectForKey:kHTMI_User_Name];
        _scheduleFormNetWorkStyle = YES;
        
        //监听通知
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleAjaxEventNSNotification:) name:HTMI_Notification_Ajax_Event object:nil];
        
        
        //拼接好的字段名称
        _finalNameString = [NSString stringWithFormat:@"%@%@%@%@", _beforeNameString, _nameString, _endNameString, _splitString];
        
        //拼接好的值
        _finalValueString = [NSString stringWithFormat:@"%@%@%@", _beforeValueString, _valueString, _endValueString];
        
    }
    return self;
}

/**
 使用标准意见模型数组初始化意见模型数组
 
 @param standardOpintionModelArray 标准意见模型数组
 */
- (void)htmi_setOpintionArrayWithStandardOpintionModelArray:(NSArray<HTMIStandardOpintionModel *> *)standardOpintionModelArray {
    
    NSMutableArray *opintionModelArray = [NSMutableArray array];
    
    [standardOpintionModelArray enumerateObjectsUsingBlock:^(HTMIStandardOpintionModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        HTMIItemOpintionModel *opintionModel = [[HTMIItemOpintionModel alloc] initWithStandardOpintionModel:obj];
        
        [opintionModelArray addObject:opintionModel];
    }];
    
    _opintionArray = opintionModelArray;
}

/**
 使用标准字典模型数组初始化字典模型数组
 
 @param standardDicModelArray 标准字典模型数组
 */
- (void)htmi_setDicsArrayWithStandardDicModelArray:(NSArray<HTMIStandardDicModel *> *)standardDicModelArray {
    
    NSMutableArray *dicArray = [NSMutableArray array];
    
    [standardDicModelArray enumerateObjectsUsingBlock:^(HTMIStandardDicModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        HTMIItemDicsModel *opintionModel = [[HTMIItemDicsModel alloc] initWithStandardDicModel:obj];
        
        [dicArray addObject:opintionModel];
    }];
    
    _dicsArray = dicArray;
}

/**
 设置图片文件模型集合
 
 @param standardFiledFileModelArray 标准图片文件模型集合
 */
- (void)htmi_setExtFiledImagesArrayWithStandardFiledFileModelArray:(NSArray <HTMIStandardFiledFileModel *>*)standardFiledFileModelArray {
    
    _filedImageArray = [self p_fileModelArray:standardFiledFileModelArray];
}

/**
 设置音频文件模型集合
 
 @param standardFiledFileModelArray 标准音频文件模型集合
 */
- (void)htmi_setExtFiledAudioArrayWithStandardFiledFileModelArray:(NSArray <HTMIStandardFiledFileModel *>*)standardFiledFileModelArray {
    _filedAudioArray = [self p_fileModelArray:standardFiledFileModelArray];
}

/**
 设置视频文件模型集合
 
 @param standardFiledFileModelArray 标准视频文件模型集合
 */
- (void)htmi_setExtFiledVideoArrayWithStandardFiledFileModelArray:(NSArray <HTMIStandardFiledFileModel *>*)standardFiledFileModelArray {
    _filedVideoArray = [self p_fileModelArray:standardFiledFileModelArray];
}

/**
 验证是否是必填
 
 @param mustinput 必填
 @param value 值
 @return 是否必填
 */
- (BOOL)isMustInput:(BOOL)mustinput value:(NSString *)value {
    BOOL isMustinput = NO;
    
    if (mustinput && value.length < 1) {
        isMustinput = YES;
    }
    
    return isMustinput;
}

/**
 设置表单字体
 
 @param font 字号大小
 */
- (void)htmi_setupFormLabelFont:(CGFloat)font {
    self.formLabelFont = font;
}


/**
 根据意见的值更新数据

 @param opinion 意见
 */
- (void)htmi_updateOpinion:(NSString *)opinion {
    
    self.valueString = [NSString stringWithFormat:@"%@",opinion];
    self.isShowMustInputWarning = NO;
    
    if ([self.inputString isEqualToString:@"2004"]) {
        
        if (opinion.length > 0) {
            
            NSMutableArray *opinionArray = [NSMutableArray arrayWithArray:self.opintionArray];
            
            if (opinionArray.count > 0) {
                HTMIItemOpintionModel *model = [self.opintionArray lastObject];
                model.opinionString = opinion;
                
                [opinionArray replaceObjectAtIndex:self.opintionArray.count-1 withObject:model];
                
            } else {
                HTMIItemOpintionModel *model = [[HTMIItemOpintionModel alloc] init];
                model.opinionString = opinion;
                
                [opinionArray addObject:model];
            }
            
            self.opintionArray = opinionArray;
        }
        
    }
    
    self.autographOrOpinionString = FormGetHTMILocalString(@"htmi_screenshot_opinion");
}

/**
 清空音频文件数组
 */
- (void)htmi_removeAllFiledAudiosAarrayItem {
    self.filedAudioArray = @[];
}

#pragma mark - 处理通知

/**
 处理事件通知
 
 @param notification 通知对象
 */
- (void)handleAjaxEventNSNotification:(NSNotification *)notification {
    
    HTMIFormChangedFieldModel * model = notification.object; //获取模型
    
    //分析是不是自己的key
    if ([self.keyString isEqualToString:model.fieldKey]) {
        
        [self p_handleAjaxEventWithFormChangedFieldModel:model];
    }
}

#pragma mark - 私有方法

/**
 处理Ajax事件 (需要子类实现)
 */
- (void)p_handleAjaxEventWithFormChangedFieldModel:(HTMIFormChangedFieldModel *)changedFieldModel {
    
    self.valueString = changedFieldModel.fieldValue;
    
    NSMutableArray *dicsMarray = [NSMutableArray array];
    //    for (NSDictionary *dict in changedFieldModel.dics) {
    //        HTMIItemDicsModel *model = [HTMIItemDicsModel getItemDicsModelWithDict:dict];
    //        [dicsMarray addObject:model];
    //    }
    self.dicsArray = [changedFieldModel.dics copy];
    
    self.isShowMustInputWarning = NO;
    
    if (changedFieldModel.hiden == 0) {//显示
        self.isHidden = NO;
    } else if (changedFieldModel.hiden == 1) {//隐藏
        self.isHidden = YES;
    }
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:HTMI_Notification_Ajax_Event_FieldItem object:self userInfo:nil];
}

/**
 初始化可编辑状态下的字段
 */
- (void)p_setupEditState {
    
    if ([_inputString isEqualToString:@"2001"] ||
        [_inputString isEqualToString:@"2003"] ||
        [_inputString isEqualToString:@"6001"] ||
        [_inputString isEqualToString:@"6002"] ||
        [_inputString isEqualToString:@"6101"] ||
        [_inputString isEqualToString:@"6102"]) {
        
        _valueString = @"";//清空value，必填时用于验证
        
    } else if ([_inputString isEqualToString:@"2002"]) {
        
        [self p_setupForSign];
        
    } else if ([_inputString isEqualToString:@"2004"]) {
        
        [self p_setupForOpinion];
    }
}

/**
 标准文件模型数组转为文件模型数组
 
 @param standardFiledFileModelArray 标准文件模型数组
 @return 文件模型数组
 */
- (NSArray <HTMIWorkFlowExtModel *> *)p_fileModelArray:(NSArray <HTMIStandardFiledFileModel *>*)standardFiledFileModelArray {
    NSMutableArray *fileModelArray = [NSMutableArray array];
    
    [standardFiledFileModelArray enumerateObjectsUsingBlock:^(HTMIStandardFiledFileModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        HTMIWorkFlowExtModel *workFlowExtModel = [[HTMIWorkFlowExtModel alloc] initWithStandardFiledFileModel:obj];
        
        [fileModelArray addObject:workFlowExtModel];
    }];
    
    return [fileModelArray copy];
}

/**
 初始化时，设置意见
 */
- (void)p_setupForOpinion {
    if (_opintionArray.count > 0) {
        HTMIItemOpintionModel *itemOpinionModel = [_opintionArray lastObject];
        _valueString = itemOpinionModel.opinionString;
    } else {
        _valueString = @"";
    }
}

/**
 初始化不可编辑状态下的 签名放到数组中
 */
- (void)p_setupNoEditState {
    
    if ([_inputString isEqualToString:@"2002"]) {
        
        [self p_setupForSign];
    }
}

/**
 初始化时，设置签名
 */
- (void)p_setupForSign {
    //已经存在的签名放入opinion数组，同意见统一
    NSMutableArray *tempMarray = [NSMutableArray array];
    for (HTMIStandardSignModel *signModel in _signs) {
        HTMIItemOpintionModel *model = [[HTMIItemOpintionModel alloc] init];
        model.userNameString = signModel.userName;
        model.saveTimeString = signModel.saveTime;
        
        [tempMarray addObject:model];
    }
    _opintionArray = tempMarray;
    
    
//    if (_valueString.length > 0) {
//        NSArray *autographArray = [_valueString componentsSeparatedByString:@"\r\n"];
//        NSMutableArray *tempMarray = [NSMutableArray array];
//        for (NSString *nameString in autographArray) {
//            HTMIItemOpintionModel *model = [[HTMIItemOpintionModel alloc] init];
//            model.userNameString = nameString;
//
//            [tempMarray addObject:model];
//        }
//        _opintionArray = tempMarray;
//    }
    
    _valueString = @"";
}

#pragma mark - 懒加载

- (NSArray<HTMIWorkFlowExtModel *> *)filedAudioArray {
    if (!_filedAudioArray) {
        _filedAudioArray = @[];
    }
    return _filedAudioArray;
}

- (void)setMaxLength:(NSInteger)maxLength {
    _maxLength = maxLength == 0 ? 10000 : maxLength;
}

- (id)copyWithZone:(NSZone *)zone {
    HTMIFieldItemModel *model = [[[self class] allocWithZone:zone] init];
    
    model.nameString = [self.nameString copy];
    model.beforeNameString = [self.beforeNameString copy];
    model.endNameString = [self.endNameString copy];
    model.splitString = [self.splitString copy];
    model.valueString = [self.valueString copy];
    model.beforeValueString = [self.beforeValueString copy];
    model.endValueString = [self.endValueString copy];
    model.alignString = [self.alignString copy];
    model.keyString = [self.keyString copy];
    model.modeString = [self.modeString copy];
    model.inputString = [self.inputString copy];
    model.opintionArray = [self.opintionArray copy];
    model.dicsArray = [self.dicsArray copy];
    model.formkeyString = [self.formkeyString copy];
    model.fieldIdString = [self.fieldIdString copy];
    model.filedImageArray = [self.filedImageArray copy];
    model.filedAudioArray = [self.filedAudioArray copy];
    model.filedVideoArray = [self.filedVideoArray copy];
    model.ajaxEventModel = [self.ajaxEventModel copy];
    model.valueString = [self.valueString copy];
    model.autographOrOpinionString = [self.autographOrOpinionString copy];
    model.imageArray = [self.imageArray copy];
    model.extFiledAudiosAddMarray = [self.extFiledAudiosAddMarray copy];
    model.signs = [self.signs copy];
    model.nameVisible = self.nameVisible;
    model.nameRN = self.nameRN;
    model.percent = self.percent;
    model.maxLength = self.maxLength;
    model.mustInput = self.mustInput;
    model.backColor = self.backColor;
    model.nameBackColor = self.nameBackColor;
    model.nameFontColor = self.nameFontColor;
    //model.valueBackColor = self.valueBackColor;
    model.valueFontColor = self.valueFontColor;
    model.is_ext = self.is_ext;
    
    model.imageHeight = self.imageHeight;
    model.formLabelFont = self.formLabelFont;
    model.isShowMustInputWarning = self.isShowMustInputWarning;
    model.isHidden = self.isHidden;
    
    
    model.myUserName = [self.myUserName copy];
    model.scheduleFormNetWorkStyle = self.scheduleFormNetWorkStyle;
    model.finalItemWidth = self.finalItemWidth;
    model.finalNameString = [self.finalNameString copy];
    model.finalValueString = [self.finalValueString copy];
    
    
    return model;
}

- (NSString *)description {
    return [self mj_keyValues].description;
}

@end
