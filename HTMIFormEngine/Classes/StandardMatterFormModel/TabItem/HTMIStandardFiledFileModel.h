//
//  HTMIStandardFiledFileModel.h
//  MXClient
//
//  Created by wlq on 2018/1/24.
//  Copyright © 2018年 MXClient. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTMIStandardFiledFileModel : NSObject<NSCopying>

/**
 表单form_id
 */
@property (nonatomic, copy) NSString *formId;

/**
 表单data_id
 */
@property (nonatomic, copy) NSString *dataId;

/**
 被包含在字段的主键
 */
@property (nonatomic, copy) NSString *fieldId;

/**
 文件名称
 */
@property (nonatomic, copy) NSString *fileName;

/**
 文件类型
 */
@property (nonatomic, copy) NSString *fileType;

/**
 文件大小
 */
@property (nonatomic, copy) NSString *fileSize;

/**
 文件上传人
 */
@property (nonatomic, copy) NSString *fileCreater;

/**
 文件时间
 */
@property (nonatomic, copy) NSString *fileTime;

/**
 原文件Url
 */
@property (nonatomic, copy) NSString *fileUrl;

/**
 文件缩略图Url
 */
@property (nonatomic, copy) NSString *fileSummUrl;

/**
 录音时长或者视频时长
 */
@property (nonatomic, copy) NSString *fileLong;

/**
 保存文件服务器文件ID
 */
@property (nonatomic, copy) NSString *fileId;

@end
