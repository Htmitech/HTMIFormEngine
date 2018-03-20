//
//  HTMISliderView.h
//  单选多选
//
//  Created by wlq on 18/3/1.
//  Copyright (c) 2016年 htmitech.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HTMIFieldItemModel;

typedef void(^HTMISliderViewSingleValueBlock)(NSString *string);
typedef void(^HTMISliderViewSectionBlock)(NSString *string);

typedef NS_ENUM(NSInteger, HTMISilderType) {
    HTMISilderTypeSingleValue = 0,
    HTMISilderTypeSection,
};

@interface HTMISliderView : UIView

/**
 *  block 返回单选的字符串
 */
@property (nonatomic, copy) HTMISliderViewSingleValueBlock singleValueBlock;

/**
 *  block 返回多选的数组
 */
@property (nonatomic, copy) HTMISliderViewSectionBlock sectionBlock;

/**
 *  选值还是选择区间
 */
@property (nonatomic, assign) HTMISilderType silderType;

/**
 *  idArray
 */
@property (nonatomic, strong) NSMutableArray *idArray;

/**
 *  nameArray
 */
@property (nonatomic, strong) NSMutableArray *nameArray;

/**
 *  valueArray
 */
@property (nonatomic, strong) NSMutableArray *valueArray;

- (instancetype)initWithFrame:(CGRect)frame
               fieldItemModel:(HTMIFieldItemModel *)fieldItemModel
                   silderType:(HTMISilderType)silderType
                  isMustInput:(BOOL)isMustInput
                        value:(NSString *)valueString
                   valueLabel:(UILabel *)valueLabel
             singleValueBlock:(HTMISliderViewSingleValueBlock)singleValueBlock
                 sectionBlock:(HTMISliderViewSectionBlock)sectionBlock;

@end
