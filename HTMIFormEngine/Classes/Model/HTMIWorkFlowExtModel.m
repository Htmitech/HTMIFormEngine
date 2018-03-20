//
//  HTMIWorkFlowExtModel.m
//  MXClient
//
//  Created by 赵志国 on 2017/5/5.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import "HTMIWorkFlowExtModel.h"

#import "HTMIStandardFiledFileModel.h"

@implementation HTMIWorkFlowExtModel

/**
 使用标准文件模型初始化文件模型
 
 @param standardFiledFileModel 标准文件模型
 @return 文件模型
 */
- (instancetype)initWithStandardFiledFileModel:(HTMIStandardFiledFileModel *)standardFiledFileModel
{
    self = [super init];
    if (self) {
        
        _form_id = standardFiledFileModel.formId;
        _field_id = standardFiledFileModel.fieldId;
        _file_name = standardFiledFileModel.fileName;
        _file_type = standardFiledFileModel.fileType;
        _file_size = standardFiledFileModel.fileSize;
        _file_creater = standardFiledFileModel.fileCreater;
        _file_time = standardFiledFileModel.fileTime;
        _file_url = standardFiledFileModel.fileUrl;
        _file_summ_url = standardFiledFileModel.fileSummUrl;
        _file_long = [standardFiledFileModel.fileLong floatValue];
        _file_id = standardFiledFileModel.fileId;
        
    }
    return self;
}

@end
