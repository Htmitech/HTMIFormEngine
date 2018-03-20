//
//  HTMIFormTagView.m
//  MXClient
//
//  Created by wlq on 2018/3/1.
//  Copyright © 2018年 MXClient. All rights reserved.
//

#import "HTMIFormTagView.h"

#import "HTMIFormComponentHeader.h"

#import "HTMISupportCopyLabel.h"

#import "NSString+HTMISize.h"

#import "HTMISelectTagView.h"

#import "Masonry.h"

#import "HTMIMultipleSelectView.h"

#import "UITableViewCell+GetCell.h"
#import "HTMIStandardAjaxEventModel.h"

#import "HTMIItemDicsModel.h"

#import "HTMITabFormModel.h"


@implementation HTMIFormTagView

+ (CGFloat)formTagViewHeight:(HTMIFieldItemModel *)fieldItemModel {
    return [HTMISelectTagView formTagViewHeight:fieldItemModel];
}

#pragma mark ------ 单选多选框（内容）
- (void)inputTypeFieldItem:(HTMIFieldItemModel *)fieldItem name:(NSString *)nameString value:(NSString *)valueString width:(CGFloat)itemWidth totalView:(UIView *)view cellHeight:(CGFloat)cellHeight {
    
    [view addSubview:self];
    self.frame = view.bounds;
    
    CGRect tempRect = CGRectMake(0, 0, itemWidth, cellHeight);
    
    CGFloat nameHeight = nameString.length>0 ? [NSString labelSizeWithMaxWidth:itemWidth-stringLeftWidth*2 content:nameString FontOfSize:self.formLabelFont].height+stringTopHeight*2 : 0;
    
    HTMISupportCopyLabel *namelabel = [HTMISupportCopyLabel creatLabelWithFrame:CGRectMake(stringLeftWidth, 0, itemWidth-stringLeftWidth*2, nameHeight) text:nameString alingment:fieldItem.alignString textColor:fieldItem.nameFontColor fontSize:self.formLabelFont];
    [view addSubview:namelabel];
    
    tempRect.origin.y += nameHeight;
    tempRect.size.height -= nameHeight;
    
    [self creatSelectViewFrame:tempRect superView:view array:fieldItem.dicsArray fieldItem:fieldItem];
}

- (void)creatSelectViewFrame:(CGRect)frame superView:(UIView *)superView array:(NSArray *)array fieldItem:(HTMIFieldItemModel *)fieldItem {
    NSDictionary *dic = @{@"521":@"0",
                          @"522":@"1",
                          @"523":@"2",
                          @"531":@"3",
                          @"532":@"4",
                          @"533":@"5"};
    
    BOOL isMustInput = fieldItem.mustInput;
    
    __weak typeof(self) weakSelf = self;
    __weak typeof(fieldItem) weakItem = fieldItem;
    HTMISelectTagView *selectView = [[HTMISelectTagView alloc] initWithFrame:frame dicsArray:array
                                                                  selectType:[[dic objectForKey:fieldItem.inputString] integerValue]
                                                                 isMustInput:isMustInput
                                                                       value:[self changValueOrIdToName:fieldItem.valueString dicArrarr:fieldItem.dicsArray]
                                                        singleSelectionBlock:^(NSString *string) {

                                                            [weakSelf.delegate editValueChangeKey:weakItem.keyString
                                                                                        value:string
                                                                                         mode:weakItem.modeString
                                                                                    inputType:weakItem.inputString
                                                                                      formKey:weakItem.formkeyString
                                                                                        isExt:weakItem.is_ext
                                                                                    eventType:[NSString stringWithFormat:@"%@",weakItem.ajaxEventModel.eventType]
                                                                               fieldItemModel:weakItem];
                                                            
                                                            weakItem.valueString = string;
                                                            weakItem.isShowMustInputWarning = NO;
                                                            
                                                            //[self.matterFormTableView reloadData];
                                                        }
                                                         multiSelectionBlock:^(NSArray *array) {
                                                             NSString *string = [array componentsJoinedByString:@"|"];
                                                             
                                                             [weakSelf.delegate editValueChangeKey:weakItem.keyString
                                                                                         value:string
                                                                                          mode:weakItem.modeString
                                                                                     inputType:weakItem.inputString
                                                                                       formKey:weakItem.formkeyString
                                                                                         isExt:weakItem.is_ext
                                                                                     eventType:[NSString stringWithFormat:@"%@",weakItem.ajaxEventModel.eventType]
                                                                                fieldItemModel:weakItem];
                                                             
                                                             weakItem.valueString = string;
                                                             weakItem.isShowMustInputWarning = NO;
                                                             
                                                             //[self.matterFormTableView reloadData];
                                                         } ];
    [superView addSubview:selectView];
    
    if (self.fieldItemModel.isShowMustInputWarning) {
        selectView.layer.borderWidth = 1.0;
        selectView.layer.borderColor = WARNING_BORDER_COLOR;
    } else {
        selectView.layer.borderWidth = 0.0;
    }
}

#pragma mark ------ value 或 id 转化为 name
- (NSString *)changValueOrIdToName:(NSString *)valueId dicArrarr:(NSArray *)dicArrarr {
    NSArray *array = [valueId componentsSeparatedByString:@";"];
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    NSString *nameString = nil;
    
    for (int i = 0; i < dicArrarr.count; i++) {
        HTMIItemDicsModel *model = dicArrarr[i];
        
        NSString *name = model.nameString;
        NSString *idString = model.idString;
        NSString *valueString = model.valueString;
        
        for (int j = 0; j < array.count; j++) {
            NSString *string = array[j];
            if ([string isEqualToString:idString] || [string isEqualToString:valueString] || [string isEqualToString:name]) {
                [mutableArray addObject:name];
            }
        }
    }
    
    nameString = [mutableArray componentsJoinedByString:@";"];
    
    return nameString;
}

/**
 处理Ajax事件 (需要子类实现)
 */
- (void)handleAjaxEvent:(HTMIFormChangedFieldModel *)changedFieldModel {
    
    //直接写事件的处理逻辑
    NSLog(@"%@",changedFieldModel);
    
    self.fieldItemModel.valueString = changedFieldModel.fieldValue;
    
    NSMutableArray *dicsMarray = [NSMutableArray array];
    
    self.fieldItemModel.dicsArray = [changedFieldModel.dics copy];
    
    [self.matterFormTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:self.indexPath,nil] withRowAnimation:UITableViewRowAnimationFade];
}

@end
