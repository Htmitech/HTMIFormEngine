//
//  HTMISelectTagView.h
//  单选多选
//
//  Created by wlq on 18/3/1.
//  Copyright (c) 2016年 htmitech.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HTMIFieldItemModel;

typedef void(^HTMISelectTagViewMultiSelectionBlock)(NSArray *array);
typedef void(^HTMISelectTagViewSingleSelectionBlock)(NSString *string);

typedef NS_ENUM(NSInteger, SelectTagType) {
    SingleSelectTagTypeID = 0,
    SingleSelectTagTypeName,
    SingleSelectTagTypeValue,
    MultiSelectTagTypeID,
    MultiSelectTagTypeName,
    MultiSelectTagTypeValue,
};

@interface HTMISelectTagView : UIView

/**
 *  block 返回单选的字符串
 */
@property (nonatomic, copy) HTMISelectTagViewSingleSelectionBlock singleSelectionBlock;

/**
 *  block 返回多选的数组
 */
@property (nonatomic, copy) HTMISelectTagViewMultiSelectionBlock multiSelectionBlock;

/**
 *  单选还是多选
 */
@property (nonatomic, assign) SelectTagType selectType;

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
                    dicsArray:(NSArray *)dicsArray
                   selectType:(SelectTagType)selectType
                  isMustInput:(BOOL)isMustInput
                        value:(NSString *)valueString
         singleSelectionBlock:(HTMISelectTagViewSingleSelectionBlock)singleSelectionBlock
          multiSelectionBlock:(HTMISelectTagViewMultiSelectionBlock)multiSelectionBlock;

+ (CGFloat)formTagViewHeight:(HTMIFieldItemModel *)fieldItemModel;

@end
