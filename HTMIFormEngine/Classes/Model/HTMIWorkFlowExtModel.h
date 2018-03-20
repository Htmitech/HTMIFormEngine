//
//  HTMIWorkFlowExtModel.h
//  MXClient
//
//  Created by 赵志国 on 2017/5/5.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@class HTMIWorkFlowExtAudioView;
@class HTMIStandardFiledFileModel;

@interface HTMIWorkFlowExtModel : NSObject

@property (nonatomic, copy) NSString *form_id;

@property (nonatomic, copy) NSString *data_id;

@property (nonatomic, copy) NSString *field_id;

@property (nonatomic, copy) NSString *file_name;

@property (nonatomic, copy) NSString *file_type;

@property (nonatomic, copy) NSString *file_size;

@property (nonatomic, copy) NSString *file_creater;

@property (nonatomic, copy) NSString *file_time;

@property (nonatomic, copy) NSString *file_url;

@property (nonatomic, copy) NSString *file_summ_url;

@property (nonatomic, assign) CGFloat file_long;

@property (nonatomic, copy) NSString *file_id;

#pragma mark - 以下属性是自己定义的

/**
 用来标识网络请求的图片用户是否需要删除
 */
@property (nonatomic, assign) int deleteFlag;

/**
 音频视图
 */
@property (nonatomic, strong) HTMIWorkFlowExtAudioView *extAudioView;

/**
 录音文件路径
 */
@property (nonatomic, copy) NSString *file_path_string;

/**
 使用标准文件模型初始化文件模型
 
 @param standardFiledFileModel 标准文件模型
 @return 文件模型
 */
- (instancetype)initWithStandardFiledFileModel:(HTMIStandardFiledFileModel *)standardFiledFileModel;

@end
