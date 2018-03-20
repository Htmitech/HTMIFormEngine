//
//  HTMIItemDicsModel.m
//  MXClient
//
//  Created by 赵志国 on 2017/10/16.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import "HTMIItemDicsModel.h"
#import "HTMIStandardDicModel.h"

#import "MJExtension.h"

@implementation HTMIItemDicsModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"idString" : @"id",
             @"nameString" : @"name",
             @"valueString" : @"value",
             };
}

/**
 通过标准字典模型初始化

 @param standardDicModel 标准字典模型
 @return 字典模型
 */
- (instancetype)initWithStandardDicModel:(HTMIStandardDicModel *)standardDicModel
{
    self = [super init];
    if (self) {
        _idString = standardDicModel.dicId;
        _nameString = standardDicModel.name;
        _valueString = standardDicModel.value;
    }
    return self;
}

///**
// 通过字典初始化
//
// @param dict 字典
// @return 模型
// */
//+ (HTMIItemDicsModel *)getItemDicsModelWithDict:(NSDictionary *)dict {
//
//    HTMIItemDicsModel *itemDicsModel = [[HTMIItemDicsModel alloc] init];
//
//    itemDicsModel.idString = [dict objectForKey:@"id"];
//    itemDicsModel.nameString = [dict objectForKey:@"name"];
//    itemDicsModel.valueString = [dict objectForKey:@"value"];
//
//    return itemDicsModel;
//}

- (id)copyWithZone:(NSZone *)zone {
    HTMIItemDicsModel *model = [[[self class] allocWithZone:zone] init];
    
    model.nameString = [self.nameString copy];
    model.idString = [self.idString copy];
    model.valueString = [self.valueString copy];
    
    return model;
}

- (NSString *)description {
    return [self mj_keyValues].description;
}

@end
