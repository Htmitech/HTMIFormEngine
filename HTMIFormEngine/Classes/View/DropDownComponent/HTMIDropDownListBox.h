//
//  HTDropDownListBox.h
//  自定义下拉选择
//
//  Created by 赵志国 on 16/6/16.
//  Copyright (c) 2016年 htmitech.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, blockType){
    BlockID = 0,
    BlockUserName,
    BlockValue,
    BlockTextField,
};

typedef void(^HTDropDownListBoxBlock)(NSString *userName);

@interface HTMIDropDownListBox : UIView

/**
 *   返回自己，判断是自己不做处理，不是自己全部收回
 */
typedef void(^blockSelf)(HTMIDropDownListBox *box);

/**
 *  判断弹出试图是弹出还是收回
 */
@property (nonatomic, assign) BOOL dropDownClick;

/**
 *  USerName
 */
@property (nonatomic, strong) NSArray *userNameArray;

/**
 *  id
 */
@property (nonatomic, strong) NSArray *idArray;

/**
 *  value
 */
@property (nonatomic, strong) NSArray *valueArray;

/**
 *  用来显示选中的结果
 */
@property (nonatomic, strong) UILabel *selectedLabel;

/**
 *  textField 可输入下拉框
 */
@property (nonatomic, strong) UITextField *textField;


/**
 *  父试图的self.view
 */
@property (nonatomic, strong) UITableView *listBoxPlaceView;

/**
 *  返回类型，ID、name、value
 */
@property (nonatomic, assign) blockType blockType;

/**
 *  字体大小
 */
@property (nonatomic, assign) NSInteger formLabelFont;

/**
 *  block
 */
@property (nonatomic, copy) HTDropDownListBoxBlock listBoxBlock;
@property (nonatomic, copy) blockSelf blockSelf;

@property (nonatomic, assign) BOOL isMustInput;

@property (nonatomic, copy) NSString *valueString;

/**
 *  初始化
 *
 *  @param view  是父试图的self.view 用来存放弹出试图，直接加在cell.contentView上获取不到点击事件
 */
- (instancetype)initWithFrame:(CGRect)frame view:(UITableView *)view blockType:(blockType)type isMustinput:(BOOL)isMustinput isShowWarning:(BOOL)isShowWarning;


@end
