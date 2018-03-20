//
//  HTMIItemDicsModel.h
//  MXClient
//
//  Created by 赵志国 on 2017/10/16.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HTMIStandardDicModel;

@interface HTMIItemDicsModel : NSObject<NSCopying>

@property (nonatomic, copy) NSString *nameString;

@property (nonatomic, copy) NSString *idString;

@property (nonatomic, copy) NSString *valueString;

/**
 通过标准字典模型初始化
 
 @param standardDicModel 标准字典模型
 @return 字典模型
 */
- (instancetype)initWithStandardDicModel:(HTMIStandardDicModel *)standardDicModel;

@end
