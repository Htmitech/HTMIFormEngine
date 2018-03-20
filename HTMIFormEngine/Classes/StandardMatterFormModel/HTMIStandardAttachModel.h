//
//  HTMIStandardAttachModel.h
//  MXClient
//
//  Created by wlq on 2018/01/23.
//  Copyright © 2018年 MXClient. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface HTMIStandardAttachModel : NSObject <NSCopying>

/**
 附件Id
 */
@property (nonatomic, copy) NSString *attachmentId;

/**
 附件标题
 */
@property (nonatomic, copy) NSString *attachmentTitle;

/**
 附件类型
 */
@property (nonatomic, copy) NSString *attachmentType;

/**
 附件大小
 */
@property (nonatomic, copy) NSString *attachmentSize;

/**
 是否加密
 */
@property (nonatomic, assign) BOOL encrypt;

/**
 附件时间
 */
@property (nonatomic, copy) NSString *attachmentDateTime;

@end
