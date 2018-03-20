//
//  HTMIWorkFlowInputType2002Strategy.m
//  MXClient
//
//  Created by wlq on 2018/1/26.
//  Copyright © 2018年 MXClient. All rights reserved.
//

#import "HTMIWorkFlowInputType2002Strategy.h"

#import "HTMIFieldItemModel.h"

#import "HTMITabFormModel.h"

#import "HTMIFormBaseView.h"

#import "HTMIFormComponentHeader.h"

#import "NSString+HTMISize.h"

#import "HTMIUserdefaultHelper.h"

#import "HTMIFormChangedFieldModel.h"

//#import "HTMIConst.h"

#import "HTMIFormOpinionAutographView.h"

@implementation HTMIWorkFlowInputType2002Strategy

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSAssert(NO,@"只能使用指定构造函数进行初始化initWithFieldItemModel:");
    }
    return self;
}

/**
 指定初始化方法
 
 @param fieldItemModel  字段模型
 @param tableItemModel  tab模型
 @return 策略对象
 */
- (instancetype)initWithFieldItemModel:(HTMIFieldItemModel *)fieldItemModel
                          tabFormModel:(HTMITabFormModel *)tabFormModel {
    
    self = [super initWithFieldItemModel:fieldItemModel tabFormModel:tabFormModel];
    if (self) {
        //子类的个性初始化
    }
    return self;
}

/**
 获取字段view
 
 @return 字段view
 */
- (HTMIFormBaseView *)getFieldItemView {
    
    return [[HTMIFormOpinionAutographView alloc] init];
}

/**
 获取字段view高度
 
 @return 字段view高度
 */
- (CGFloat)getFieldItemViewHeight {
    
    CGFloat allHeight = 0;
    
    CGFloat nameHeight = self.fieldItemModel.finalNameString.length>0 ? [NSString labelSizeWithMaxWidth:self.fieldItemModel.finalItemWidth-stringLeftWidth*2 content:self.fieldItemModel.finalNameString FontOfSize:self.fieldItemModel.formLabelFont].height+stringTopHeight*2 : 0;
    
    if ([self.fieldItemModel.modeString isEqualToString:@"1"]) {
        if (self.fieldItemModel.nameVisible) {
            if (self.fieldItemModel.nameRN) {//显示name并且折行
                //签名
                if (self.fieldItemModel.opintionArray.count > 0){
                    allHeight += nameHeight;
                    
//                    NSArray *autographArray = [self.fieldItemModel.valueString componentsSeparatedByString:@"\r\n"];
                    
                    for (HTMIItemOpintionModel *model in self.fieldItemModel.opintionArray) {
                        NSString *string = model.userNameString;
                        float eachHeight = [NSString labelSizeWithMaxWidth:self.fieldItemModel.finalItemWidth-stringLeftWidth*2 content:string FontOfSize:self.fieldItemModel.formLabelFont].height+stringTopHeight;
                        
                        allHeight+=eachHeight;
                    }
                    
                    HTMIItemOpintionModel *lastModel = [self.fieldItemModel.opintionArray lastObject];
                    if ([lastModel.userNameString rangeOfString:self.fieldItemModel.myUserName].location == NSNotFound){
                        allHeight+=cellMinHeight;
                    }
                }
            } else {//显示name不折行
                //签名
                if (self.fieldItemModel.opintionArray.count > 0){
//                    NSArray *autographArray = [self.fieldItemModel.valueString componentsSeparatedByString:@"\r\n"];
                    
                    for (HTMIItemOpintionModel *model in self.fieldItemModel.opintionArray) {
                        NSString *string = model.userNameString;
                        float eachHeight = [NSString labelSizeWithMaxWidth:self.fieldItemModel.finalItemWidth-stringLeftWidth*2 content:string FontOfSize:self.fieldItemModel.formLabelFont].height+stringTopHeight;
                        
                        allHeight+=eachHeight;
                    }
                    
                    HTMIItemOpintionModel *lastModel = [self.fieldItemModel.opintionArray lastObject];
                    if ([lastModel.userNameString rangeOfString:self.fieldItemModel.myUserName].location == NSNotFound){
                        allHeight+=cellMinHeight;
                    }
                }
            }
        } else {//不显示name
            //签名
            if (self.fieldItemModel.opintionArray.count > 0){
//                NSArray *autographArray = [self.fieldItemModel.valueString componentsSeparatedByString:@"\r\n"];
                
                for (HTMIItemOpintionModel *model in self.fieldItemModel.opintionArray) {
                    NSString *string = model.userNameString;
                    float eachHeight = [NSString labelSizeWithMaxWidth:self.fieldItemModel.finalItemWidth-stringLeftWidth*2 content:string FontOfSize:self.fieldItemModel.formLabelFont].height+stringTopHeight;
                    
                    allHeight+=eachHeight;
                }
                
                HTMIItemOpintionModel *lastModel = [self.fieldItemModel.opintionArray lastObject];
                if ([lastModel.userNameString rangeOfString:self.fieldItemModel.myUserName].location == NSNotFound){
                    allHeight+=cellMinHeight;
                }
            }
            
        }
        
    } else {//不可编辑
        //签名
        if (self.fieldItemModel.valueString.length > 0){
//            NSArray *autographArray = [self.fieldItemModel.valueString componentsSeparatedByString:@"\r\n"];
            NSArray *autographArray = self.fieldItemModel.signs;
            
            for (int i = 0; i < autographArray.count; i++) {
                NSString *string = autographArray[i];
                float eachHeight = [NSString labelSizeWithMaxWidth:self.fieldItemModel.finalItemWidth-stringLeftWidth*2 content:string FontOfSize:self.fieldItemModel.formLabelFont].height+stringTopHeight;
                
                allHeight+=eachHeight;
            }
        }
    }
    return allHeight;
}

@end
