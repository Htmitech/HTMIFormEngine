//
//  HTMIFormBaseView.m
//  MXClient
//
//  Created by 赵志国 on 2017/8/25.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import "HTMIFormBaseView.h"

//#import "HTMIConst.h"

//#import "HTMIMatterFormModel.h"


@interface HTMIFormBaseView ()

@property (nonatomic, weak, readwrite) HTMIFieldItemModel *fieldItemModel;

@property (nonatomic, assign, readwrite) CGFloat formLabelFont;

@property (nonatomic, weak, readwrite) UITableView *matterFormTableView;

@property (nonatomic, weak, readwrite) NSArray *infoRegionArray;

@property (nonatomic, copy, readwrite) NSString *nameString;

@property (nonatomic, copy, readwrite) NSString *valueString;

@property (nonatomic, assign, readwrite) CGFloat itemWidth;

@property (nonatomic, assign, readwrite) CGFloat cellHeight;

//@property (nonatomic, weak, readwrite) UIView *parentView;

@property (nonatomic, weak, readwrite) UIViewController *controller;

@property (nonatomic, weak, readwrite) NSIndexPath *indexPath;

/**
 table模型，这里用于判断 tab风格（表格式表单/互联网表单）
 */
@property (nonatomic, weak, readwrite) HTMITabFormModel *tabFormModel;

@property (nonatomic, assign, readwrite) BOOL scheduleFormNetWorkStyle;

@end

@implementation HTMIFormBaseView

/**
 初始化
 */
//- (instancetype)initWithTabeleView:(UITableView *)tableView {
//    self = [super init];
//    if (self) {
////        self.matterFormTableView = tableView;
////        self.backgroundColor = [UIColor whiteColor];
//        //监听通知
////        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleAjaxEventNSNotification:) name:HTMI_Notification_Ajax_Event object:nil];
//    }
//    return self;
//}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)setFieldItemModel:(HTMIFieldItemModel *)fieldItemModel
            formLabelFont:(CGFloat)formLabelFont
      matterFormTableView:(UITableView *)matterFormTableView
          infoRegionArray:(NSArray *)infoRegionArray
               nameString:(NSString *)nameString
              valueString:(NSString *)valueString
                itemWidth:(CGFloat)itemWidth
               cellHeight:(CGFloat)cellHeight
               controller:(UIViewController *)controller
                indexPath:(NSIndexPath *)indexPath
           tableItemModel:(HTMITabFormModel *)tableItemModel {
    
    self.fieldItemModel = fieldItemModel;
    self.formLabelFont = formLabelFont;
    self.matterFormTableView = matterFormTableView;
    self.infoRegionArray = infoRegionArray;
    self.nameString = nameString;
    self.valueString = valueString;
    self.itemWidth = itemWidth;
    self.cellHeight = cellHeight;
    self.controller = controller;
    self.indexPath = indexPath;
    self.tabFormModel = tableItemModel;
    
    self.scheduleFormNetWorkStyle = YES;
}

- (void)inputTypeFieldItem:(HTMIFieldItemModel *)fieldItem name:(NSString *)nameString value:(NSString *)valueString width:(CGFloat)itemWidth totalView:(UIView *)view cellHeight:(CGFloat)cellHeight {
    
}

/**
 处理事件通知
 
 @param notification 通知对象
 */
//- (void)handleAjaxEventNSNotification:(NSNotification *)notification {
//
//    //    [[NSNotificationCenter defaultCenter] postNotificationName:HTMI_Notification_CommonformSubControllerRefresh
//    //                                                        object:nil];
//    
//    HTMIFormChangedFieldModel * model = notification.object; //获取模型
//    
//    //分析是不是自己的key
//    if ([self.fieldItemModel.key isEqualToString:model.field_key]) {
//        //调用子类的方法
//        [self handleAjaxEvent:model];
//        
//    }
//}

/**
 处理Ajax事件 (需要子类实现)
 */
- (void)handleAjaxEvent:(HTMIFormChangedFieldModel *)changedFieldModel {
   
}

- (void)dealloc {
    //移除通知
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end
