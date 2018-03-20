//
//  HTMIMultipleSelectView.h
//  choose单选多选
//
//  Created by Zc on 2017/8/30.
//  Copyright © 2017年 Zc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HTMIMultipleSelectViewDelegate <NSObject>

- (void)myresignFirstResponder;

@end

@interface HTMIMultipleSelectView : UIView

typedef void(^selectTypeBlock)();
//block
@property (nonatomic, strong)selectTypeBlock selectTypeBlockString;

/**
 枚举
 */
typedef NS_ENUM(NSInteger ,HTMISelectType){
    
    HTMISelectTypeSingle = 0,//单选
    HTMISelectTypeMulti,//多选
};
//枚举值
@property (nonatomic,assign)HTMISelectType selectType;


typedef NS_ENUM(NSInteger , HTMIUIButtonTagType){
    
    HTMIUIButtonTagTypeConfim = 101010,//确定
    HTMIUIButtonTagTypeCancel,//取消
};
@property (nonatomic, assign)HTMIUIButtonTagType *buttonTagType;


@property (weak, nonatomic) id<HTMIMultipleSelectViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame showArray:(NSArray *)array selectString:(HTMISelectType)selectString;

- (void)show;
- (void)dismiss;
@end
