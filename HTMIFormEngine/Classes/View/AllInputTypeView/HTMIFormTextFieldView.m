//
//  HTMIFormTextFieldView.m
//  MXClient
//
//  Created by 赵志国 on 2017/8/25.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import "HTMIFormTextFieldView.h"

#import "HTMIFormComponentHeader.h"

//#import "UIView+Common.h"

#import "NSString+HTMISize.h"

#import "HTMITxtView.h"

#import "HTMISupportCopyLabel.h"

//#import "NSString+Extention.h"

#import "UIColor+Hex.h"

#import "HTMINetWorkTextField.h"
#import "HTMIStandardAjaxEventModel.h"

#import "UIFont+HTMIFont.h"

#import "HTMITabFormModel.h"

@interface HTMIFormTextFieldView ()

@end

@implementation HTMIFormTextFieldView

#pragma mark ------ TextField && TextView（内容）
- (void)inputTypeFieldItem:(HTMIFieldItemModel *)fieldItem
                      name:(NSString *)nameString
                     value:(NSString *)valueString
                     width:(CGFloat)itemWidth
                 totalView:(UIView *)view
                cellHeight:(CGFloat)cellHeight {
    
    BOOL isMustInput = fieldItem.mustInput;
    
    CGRect txtFieldRect = CGRectMake(0, 0, itemWidth, cellMinHeight);
    
    NSDictionary *dic = @{@"101":@"0",@"200":@"1",@"201":@"3",@"202":@"2",@"203":@"4"};
    
    if (self.tabFormModel.tabStyle == 0) {
        if ((![fieldItem.modeString isEqual:[NSNull null]] && [fieldItem.modeString isEqualToString:@"1"])) {//可编辑
            
            HTMITxtView *txtView = nil;
            
            if (fieldItem.nameVisible) {
                if (fieldItem.nameRN) {//显示 name 且分行显示
                    
                    CGFloat nameHeight = nameString.length>0 ? [NSString labelSizeWithMaxWidth:itemWidth-stringLeftWidth*2 content:nameString FontOfSize:self.formLabelFont].height+stringTopHeight*2 : 0;
                    
                    HTMISupportCopyLabel *namelabel = [HTMISupportCopyLabel creatLabelWithFrame:CGRectMake(stringLeftWidth, 0, itemWidth-stringLeftWidth*2, nameHeight) text:nameString alingment:fieldItem.alignString textColor:fieldItem.nameFontColor fontSize:self.formLabelFont];
                    [view addSubview:namelabel];
                    
                    txtFieldRect.origin.y += nameHeight;
                    txtFieldRect.size.height -= nameHeight;
                    
                    
                    
                } else {//显示 name 不分行
                    
                    CGFloat nameWidth = [NSString labelSizeWithMaxWidth:0 content:nameString FontOfSize:self.formLabelFont].width;
                    
                    HTMISupportCopyLabel *namelabel = [HTMISupportCopyLabel creatLabelWithFrame:CGRectMake(stringLeftWidth, 0, nameWidth, cellHeight) text:nameString alingment:fieldItem.alignString textColor:fieldItem.nameFontColor fontSize:self.formLabelFont];
                    [view addSubview:namelabel];
                    
                    txtFieldRect.origin.x += (nameWidth+stringLeftWidth);
                    txtFieldRect.size.width -= (nameWidth+stringLeftWidth);
                    
                }
            } else {//不显示 name
                
            }
            
            txtView = [[HTMITxtView alloc] initWithFrame:txtFieldRect
                                                textType:[[dic objectForKey:fieldItem.inputString] integerValue]
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
                
                //            [self.matterFormTableView reloadData];
            };
            
        } else {//不可编辑
            if ([fieldItem.inputString isEqualToString:@"101"]) {
                if (fieldItem.nameVisible) {
                    HTMISupportCopyLabel *allLabel = [HTMISupportCopyLabel creatLabelWithFrame:CGRectMake(stringLeftWidth, 0, itemWidth-stringLeftWidth*2, cellHeight) text:[NSString stringWithFormat:@"%@%@",nameString,valueString] alingment:fieldItem.alignString textColor:fieldItem.nameFontColor fontSize:self.formLabelFont];
                    [view addSubview:allLabel];
                } else {
                    HTMISupportCopyLabel *allLabel = [HTMISupportCopyLabel creatLabelWithFrame:CGRectMake(stringLeftWidth, 0, itemWidth-stringLeftWidth*2, cellHeight) text:valueString alingment:fieldItem.alignString textColor:fieldItem.valueFontColor fontSize:self.formLabelFont];
                    [view addSubview:allLabel];
                }
                
            } else {
                //数字不折行
                HTMISupportCopyLabel *label = [[HTMISupportCopyLabel alloc] initWithFrame:CGRectMake(stringLeftWidth, 0, itemWidth-stringLeftWidth*2, cellHeight)];
                
                if (fieldItem.nameVisible) {
                    label.text = [NSString stringWithFormat:@"%@%@",nameString,valueString];
                } else {
                    label.text = valueString;
                }
                
                label.textAlignment = [self alignmentWithString:fieldItem.alignString];
                label.font = [UIFont htmi_systemFontOfSize:self.formLabelFont];
                label.adjustsFontSizeToFitWidth = YES;
                label.textColor = [UIColor colorWithHex:[NSString stringWithFormat:@"%x",(int)fieldItem.valueFontColor] alpha:1.0 isWhite:self.tabFormModel.tabStyle];
                [view addSubview:label];
            }
        }
    } else {
        
        //互联网表单
        [self netWorkTextField:view];
    }
    
    
}

#pragma mark ------ 互联网表单
- (void)netWorkTextField:(UIView *)superView {
    
    CGRect textFieldRect = CGRectMake(0, 0, self.itemWidth, self.cellHeight);
    BOOL isMustInput = [self.fieldItemModel isMustInput:self.fieldItemModel.mustInput value:self.fieldItemModel.valueString];
    
    NSDictionary *dic = @{@"101":@"0",@"200":@"1",@"201":@"3",@"202":@"2",@"203":@"4"};
    
    typeof(self) __weakSelf = self;
    
    if (self.fieldItemModel.nameVisible) {//显示 name
        
        if ((![self.fieldItemModel.modeString isEqual:[NSNull null]] && [self.fieldItemModel.modeString isEqualToString:@"1"])) {
            
            HTMINetWorkTextField *textField = [[HTMINetWorkTextField alloc] initWithFrame:textFieldRect
                                                                               nameString:self.nameString
                                                                              beforeValue:self.fieldItemModel.beforeValueString
                                                                              valueString:self.fieldItemModel.valueString
                                                                                 endValue:self.fieldItemModel.endValueString
                                                                              isMustInput:isMustInput
                                                                                 textFont:self.formLabelFont
                                                                                 textType:[[dic objectForKey:self.fieldItemModel.inputString] integerValue]];
            [superView addSubview:textField];
            
            
            textField.editEndBlock = ^(NSString *string) {
                __weakSelf.fieldItemModel.valueString = string;
                
                [__weakSelf.delegate editValueChangeKey:self.fieldItemModel.keyString
                                                  value:string
                                                   mode:self.fieldItemModel.modeString
                                              inputType:self.fieldItemModel.inputString
                                                formKey:self.fieldItemModel.formkeyString
                                                  isExt:self.fieldItemModel.is_ext
                                              eventType:[NSString stringWithFormat:@"%@",self.fieldItemModel.ajaxEventModel.eventType]
                                         fieldItemModel:self.fieldItemModel];
            };
            
        } else {//不可编辑
            CGRect nameRect = CGRectMake(stringLeftWidth, 0, kScreenWidth*0.3-stringLeftWidth*2, self.cellHeight);
            textFieldRect.origin.x += kScreenWidth*0.3;
            textFieldRect.size.width -= kScreenWidth*0.3;
            
            if (NO) {//self.scheduleFormNetWorkStyle
                
                nameRect = CGRectMake(stringLeftWidth, 0, kScreenWidth*0.3-stringLeftWidth*2, self.cellHeight);
                textFieldRect = CGRectMake(kScreenWidth*0.3, 0, kScreenWidth*0.7, self.cellHeight);
                
            }
            
            
            HTMISupportCopyLabel *nameLabel = [[HTMISupportCopyLabel alloc] initWithFrame:nameRect];
            nameLabel.text = self.nameString;
            nameLabel.textAlignment = NSTextAlignmentLeft;
            nameLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
            nameLabel.font = [UIFont htmi_systemFontOfSize:self.formLabelFont];
            nameLabel.numberOfLines = 0;
            nameLabel.adjustsFontSizeToFitWidth = YES;
            [superView addSubview:nameLabel];
            
            HTMISupportCopyLabel *valueLabel = [[HTMISupportCopyLabel alloc] initWithFrame:textFieldRect];
            valueLabel.text = self.valueString;
            valueLabel.textAlignment = NSTextAlignmentLeft;
            valueLabel.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0];
            valueLabel.font = [UIFont htmi_systemFontOfSize:self.formLabelFont];
            valueLabel.numberOfLines = 0;
            valueLabel.adjustsFontSizeToFitWidth = YES;
            [superView addSubview:valueLabel];
            
        }
        
    } else {//不显示 name
        
        if ((![self.fieldItemModel.modeString isEqual:[NSNull null]] && [self.fieldItemModel.modeString isEqualToString:@"1"])) {
            
            HTMINetWorkTextField *textField = [[HTMINetWorkTextField alloc] initWithFrame:textFieldRect
                                                                               nameString:@""
                                                                              beforeValue:self.fieldItemModel.beforeValueString
                                                                              valueString:self.fieldItemModel.valueString
                                                                                 endValue:self.fieldItemModel.endValueString
                                                                              isMustInput:isMustInput
                                                                                 textFont:self.formLabelFont textType:[[dic objectForKey:self.fieldItemModel.inputString] integerValue]];
            [superView addSubview:textField];
            
            textField.editEndBlock = ^(NSString *string) {
                __weakSelf.fieldItemModel.valueString = string;
                
                [__weakSelf.delegate editValueChangeKey:self.fieldItemModel.keyString
                                                  value:string
                                                   mode:self.fieldItemModel.modeString
                                              inputType:self.fieldItemModel.inputString
                                                formKey:self.fieldItemModel.formkeyString
                                                  isExt:self.fieldItemModel.is_ext
                                              eventType:[NSString stringWithFormat:@"%@",self.fieldItemModel.ajaxEventModel.eventType]
                                         fieldItemModel:self.fieldItemModel];
            };
            
        } else {
            CGRect labelRect = CGRectMake(stringLeftWidth, 0, kScreenWidth*0.3-stringLeftWidth*2, self.cellHeight);
            
            HTMISupportCopyLabel *label = [[HTMISupportCopyLabel alloc] initWithFrame:labelRect];
            label.text = self.valueString;
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0];
            label.font = [UIFont htmi_systemFontOfSize:self.formLabelFont];
            label.numberOfLines = 0;
            label.adjustsFontSizeToFitWidth = YES;
            [superView addSubview:label];
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

#pragma mark  ------ 对齐方式
- (NSTextAlignment)alignmentWithString:(NSString *)string {
    if ([string isEqualToString:@"Right"]) {
        return NSTextAlignmentRight;
    }
    else if ([string isEqualToString:@"Left"]) {
        return NSTextAlignmentLeft;
    }
    else if ([string isEqualToString:@"Center"]) {
        return NSTextAlignmentCenter;
    }
    else {
        return NSTextAlignmentLeft;
    }
}
@end
