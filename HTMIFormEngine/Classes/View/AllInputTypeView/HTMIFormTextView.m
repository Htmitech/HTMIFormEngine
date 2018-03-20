//
//  HTMIFormTextView.m
//  MXClient
//
//  Created by 赵志国 on 2017/8/25.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import "HTMIFormTextView.h"

#import "HTMIFormComponentHeader.h"

#import "NSString+HTMISize.h"

//#import "UIView+Common.h"

#import "HTMITxtView.h"

#import "HTMISupportCopyLabel.h"

#import "HTMINetworkTextView.h"
#import "HTMIStandardAjaxEventModel.h"

#import "UIFont+HTMIFont.h"

#import "HTMITabFormModel.h"

@implementation HTMIFormTextView


- (void)inputTypeFieldItem:(HTMIFieldItemModel *)fieldItem name:(NSString *)nameString value:(NSString *)valueString width:(CGFloat)itemWidth totalView:(UIView *)view cellHeight:(CGFloat)cellHeight {
    
    BOOL isMustInput = fieldItem.mustInput;
    
    CGRect txtViewRect = CGRectMake(0, 0, itemWidth, cellHeight);
    
    if ((![fieldItem.modeString isEqual:[NSNull null]] && [fieldItem.modeString isEqualToString:@"1"])) {
        
        if (self.tabFormModel.tabStyle == 0) {
            HTMITxtView *txtView = nil;
            
            if (fieldItem.nameVisible) {
                if (fieldItem.nameRN) {//显示name且分行显示
                    
                    CGFloat nameHeight = nameString.length>0 ? [NSString labelSizeWithMaxWidth:itemWidth-stringLeftWidth*2 content:nameString FontOfSize:self.formLabelFont].height+stringTopHeight*2 : 0;
                    
                    HTMISupportCopyLabel *namelabel = [HTMISupportCopyLabel creatLabelWithFrame:CGRectMake(stringLeftWidth, 0, itemWidth-stringLeftWidth*2, nameHeight) text:nameString alingment:fieldItem.alignString textColor:fieldItem.nameFontColor fontSize:self.formLabelFont];
                    [view addSubview:namelabel];
                    
                    txtViewRect.origin.y += nameHeight;
                    txtViewRect.size.height -= nameHeight;
                    
                } else {//显示name不分行
                    CGFloat nameWidth = [NSString labelSizeWithMaxWidth:0 content:nameString FontOfSize:self.formLabelFont].width;
                    
                    HTMISupportCopyLabel *namelabel = [HTMISupportCopyLabel creatLabelWithFrame:CGRectMake(stringLeftWidth, 0, nameWidth, cellHeight) text:nameString alingment:fieldItem.alignString textColor:fieldItem.nameFontColor fontSize:self.formLabelFont];
                    [view addSubview:namelabel];
                    
                    txtViewRect.origin.x += (nameWidth+stringLeftWidth);
                    txtViewRect.size.width -= (nameWidth+stringLeftWidth);
                    
                }
            } else {//不显示name
                
            }
            
            txtView = [[HTMITxtView alloc] initWithFrame:txtViewRect
                                                textType:TextTypeTextView
                                              beforValue:fieldItem.beforeValueString
                                               textValue:fieldItem.valueString
                                                endValue:fieldItem.endValueString
                                             isMustInput:isMustInput
                                                textFont:self.formLabelFont
                                               maxLength:fieldItem.maxLength isShowWarning:fieldItem.isShowMustInputWarning];
            //txtView.delegate = self;
            [view addSubview:txtView];
            
            txtView.editBlock = ^(NSString *string) {
                
                fieldItem.valueString = string;
                fieldItem.isShowMustInputWarning = NO;
                
            };
            
            txtView.editEndBlock = ^(NSString *string) {
                
                [self.delegate editValueChangeKey:fieldItem.keyString
                                            value:string
                                             mode:fieldItem.modeString
                                        inputType:fieldItem.inputString
                                          formKey:fieldItem.formkeyString
                                            isExt:fieldItem.is_ext
                                        eventType:[NSString stringWithFormat:@"%@",fieldItem.ajaxEventModel.eventType]
                                   fieldItemModel:fieldItem];
                
                [self.matterFormTableView reloadData];
            };
            
        } else {
            //互联网表单
            [self netWorkFormTextView:view];
            
        }
        
        
    } else {
        if (self.tabFormModel.tabStyle == 1) {
            fieldItem.alignString = @"Left";
            
            if (NO) {//self.scheduleFormNetWorkStyle
                
                CGRect nameRect = CGRectMake(stringLeftWidth, 0, kScreenWidth*0.3-stringLeftWidth*2, cellHeight);
                CGRect valueRect = CGRectMake(kScreenWidth*0.3, 0, kScreenWidth*0.7, cellHeight);
                
                HTMISupportCopyLabel *nameLabel = [[HTMISupportCopyLabel alloc] initWithFrame:nameRect];
                nameLabel.text = self.nameString;
                nameLabel.textAlignment = NSTextAlignmentLeft;
                nameLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
                nameLabel.font = [UIFont htmi_systemFontOfSize:self.formLabelFont];
                nameLabel.numberOfLines = 0;
                nameLabel.adjustsFontSizeToFitWidth = YES;
                [view addSubview:nameLabel];
                
                HTMISupportCopyLabel *valueLabel = [[HTMISupportCopyLabel alloc] initWithFrame:valueRect];
                valueLabel.text = self.valueString;
                valueLabel.textAlignment = NSTextAlignmentLeft;
                valueLabel.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0];
                valueLabel.font = [UIFont htmi_systemFontOfSize:self.formLabelFont];
                valueLabel.numberOfLines = 0;
                valueLabel.adjustsFontSizeToFitWidth = YES;
                [view addSubview:valueLabel];
            } else {
                [HTMISupportCopyLabel inputNoEditFieldItem:fieldItem
                                                nameString:nameString
                                               valueString:valueString
                                                     width:itemWidth-stringLeftWidth*2
                                                cellHeight:cellHeight
                                                 superView:view
                                                  fontSize:self.formLabelFont];
            }
        } else {
            [HTMISupportCopyLabel inputNoEditFieldItem:fieldItem
                                            nameString:nameString
                                           valueString:valueString
                                                 width:itemWidth-stringLeftWidth*2
                                            cellHeight:cellHeight
                                             superView:view
                                              fontSize:self.formLabelFont];
        }
    }
}

/**
 处理Ajax事件 (需要子类实现)
 */
- (void)handleAjaxEvent:(HTMIFormChangedFieldModel *)changedFieldModel {
    
    //直接写事件的处理逻辑
    NSLog(@"%@",changedFieldModel);
    
    self.fieldItemModel.valueString = changedFieldModel.fieldValue;
    
    //    NSMutableArray *dicsMarray = [NSMutableArray array];
    //    for (NSDictionary *dict in changedFieldModel.dics) {
    //        HTMIItemDicsModel *model = [HTMIItemDicsModel getItemDicsModelWithDict:dict];
    //        [dicsMarray addObject:model];
    //    }
    self.fieldItemModel.dicsArray = [changedFieldModel.dics copy];
    
    [self.matterFormTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:self.indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    //    [self.matterFormTableView reloadData];
}

#pragma mark ------ 互联网表单
- (void)netWorkFormTextView:(UIView *)totalView {
    
    BOOL isMustInput = [self.fieldItemModel isMustInput:self.fieldItemModel.mustInput value:self.fieldItemModel.valueString];
    
    CGRect textViewFrame = totalView.bounds;
    
    HTMINetworkTextView *textView = [[HTMINetworkTextView alloc] initWithFrame:textViewFrame
                                                                    nameString:self.fieldItemModel.nameString
                                                                   valueString:self.fieldItemModel.valueString
                                                                   isMustInput:isMustInput
                                                                      textFont:self.formLabelFont];
    
    
    [totalView addSubview:textView];
    
    textView.editEndBlock = ^(NSString *string) {
        
        self.fieldItemModel.valueString = string;
        
        [self.delegate editValueChangeKey:self.fieldItemModel.keyString
                                    value:string
                                     mode:self.fieldItemModel.modeString
                                inputType:self.fieldItemModel.inputString
                                  formKey:self.fieldItemModel.formkeyString
                                    isExt:self.fieldItemModel.is_ext
                                eventType:[NSString stringWithFormat:@"%@",self.fieldItemModel.ajaxEventModel.eventType]
                           fieldItemModel:self.fieldItemModel];
    };
}

@end
