//
//  HTMIStandardFiledFileModel.m
//  MXClient
//
//  Created by wlq on 2018/1/24.
//  Copyright © 2018年 MXClient. All rights reserved.
//

#import "HTMIStandardFiledFileModel.h"

#import "MJExtension.h"

@implementation HTMIStandardFiledFileModel

- (id)copyWithZone:(NSZone *)zone {
    
    HTMIStandardFiledFileModel *model = [[self class] allocWithZone:zone];
    
    model.formId = [self.formId copy];
    model.dataId = [self.dataId copy];
    model.fieldId = [self.fieldId copy];
    model.fileName = [self.fileName copy];
    model.fileType = [self.fileType copy];
    model.fileSize = [self.fileSize copy];
    model.fileCreater = [self.fileCreater copy];
    model.fileTime = [self.fileTime copy];
    model.fileUrl = [self.fileUrl copy];
    model.fileSummUrl = [self.fileSummUrl copy];
    model.fileLong = [self.fileLong copy];
    model.fileId = [self.fileId copy];
    return model;
}

- (NSString *)description {
    return [self mj_keyValues].description;
}

@end
