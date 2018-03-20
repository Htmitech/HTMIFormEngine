//
//  HTMIFormPullDownView.m
//  MXClient
//
//  Created by 赵志国 on 2017/8/25.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import "HTMIFormPullDownView.h"

#import "HTMIFormComponentHeader.h"

//#import "UIView+Common.h"

#import "NSString+HTMISize.h"

#import "HTMISupportCopyLabel.h"

#import "HTMIDropDownListBox.h"

#import "Masonry.h"

#import "UITableViewCell+GetCell.h"

#import "HTMIMultipleSelectView.h"

//#import "HTMIMatterFormModel.h"
#import "HTMIStandardAjaxEventModel.h"

#import "UIFont+HTMIFont.h"

#import "HTMITabFormModel.h"

@interface HTMIFormPullDownView ()<UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *listBoxArray;

@property (nonatomic, strong) UITextField *valueTextField;

@end

@implementation HTMIFormPullDownView

#pragma mark ------ 下拉选择（内容）
- (void)inputTypeFieldItem:(HTMIFieldItemModel *)fieldItem name:(NSString *)nameString value:(NSString *)valueString width:(CGFloat)itemWidth totalView:(UIView *)view cellHeight:(CGFloat)cellHeight {
    
    [view addSubview:self];
    self.frame = view.bounds;
    
    CGFloat nameHeight = nameString.length>0 ? [NSString labelSizeWithMaxWidth:itemWidth-stringLeftWidth*2 content:nameString FontOfSize:self.formLabelFont].height+stringTopHeight*2 : 0;
    
    if ((![fieldItem.modeString isEqual:[NSNull null]] && [fieldItem.modeString isEqualToString:@"1"])) {
        
        if (self.tabFormModel.tabStyle == 0) {
            if (fieldItem.nameVisible) {
                if (fieldItem.nameRN) {//显示name且分行显示
                    HTMISupportCopyLabel *namelabel = [HTMISupportCopyLabel creatLabelWithFrame:CGRectMake(stringLeftWidth, 0, itemWidth-stringLeftWidth*2, nameHeight) text:nameString alingment:fieldItem.alignString textColor:fieldItem.nameFontColor fontSize:self.formLabelFont];
                    [view addSubview:namelabel];
                    
                    [self creatDropDownListBoxByFrame:CGRectMake(0, nameHeight, itemWidth, cellHeight-nameHeight) superView:view tableView:self.matterFormTableView fieldItem:fieldItem];
                    
                } else {//显示name不分行
                    [self creatDropDownListBoxByFrame:CGRectMake(0, 0, itemWidth, cellHeight) superView:view tableView:self.matterFormTableView fieldItem:fieldItem];
                }
            } else {//不显示name
                [self creatDropDownListBoxByFrame:CGRectMake(0, 0, itemWidth, cellHeight) superView:view tableView:self.matterFormTableView fieldItem:fieldItem];
            }
            
        } else {//互联网表单
            [self netWorkPullDown:view];
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

- (void)creatDropDownListBoxByFrame:(CGRect)frame superView:(UIView *)superView tableView:(UITableView *)tableView fieldItem:(HTMIFieldItemModel *)fieldItem {
    
    BOOL isMustInput = fieldItem.mustInput;
    
    NSDictionary *dic = @{@"401":@"0",@"402":@"1",@"403":@"2",@"412":@"3"};
    //[tableView.subviews firstObject]
    HTMIDropDownListBox *dropDownListbox = [[HTMIDropDownListBox alloc] initWithFrame:frame
                                                                                 view:tableView
                                                                            blockType:[[dic objectForKey:fieldItem.inputString] integerValue]
                                                                          isMustinput:isMustInput isShowWarning:fieldItem.isShowMustInputWarning];
    dropDownListbox.userNameArray = [self nameArrayFieldItem:fieldItem];
    dropDownListbox.idArray = [self idArrayFieldItem:fieldItem];
    dropDownListbox.valueArray = [self valueArrayFieldItem:fieldItem];
    dropDownListbox.formLabelFont = self.formLabelFont;
    dropDownListbox.valueString = fieldItem.valueString;
    
    
    if ([fieldItem.inputString isEqualToString:@"412"]) {
        dropDownListbox.textField.text = fieldItem.valueString;
        dropDownListbox.isMustInput = fieldItem.mustInput;
    } else {
        for (HTMIItemDicsModel *model in fieldItem.dicsArray) {
            if ([fieldItem.valueString isEqualToString:model.idString] ||
                [fieldItem.valueString isEqualToString:model.nameString] ||
                [fieldItem.valueString isEqualToString:model.valueString]) {
                
                dropDownListbox.selectedLabel.text = model.nameString;
            }
        }
    }
    
    [superView addSubview:dropDownListbox];
    
    [self.listBoxArray addObject:dropDownListbox];
    
    typeof(dropDownListbox) __weak weakDropDownListBox = dropDownListbox;
    
    dropDownListbox.blockSelf = ^(HTMIDropDownListBox *box) {
        
        for (id __strong view in [tableView.subviews firstObject].subviews) {
            if ([view isKindOfClass:[UITableView class]]) {
                [view removeFromSuperview];
                view = nil;
            }
        }
        
        for (HTMIDropDownListBox *listbox in self.listBoxArray) {
            if (listbox != box) {
                listbox.dropDownClick = NO;
            }
        }
    };
    
    dropDownListbox.listBoxBlock = ^(NSString *string) {
        
        [self.delegate editValueChangeKey:fieldItem.keyString
                                    value:string mode:fieldItem.modeString
                                inputType:fieldItem.inputString
                                  formKey:fieldItem.formkeyString
                                    isExt:fieldItem.is_ext
                                eventType:[NSString stringWithFormat:@"%@",fieldItem.ajaxEventModel.eventType]
                           fieldItemModel:fieldItem];
        
        if (![fieldItem.inputString isEqualToString:@"412"]) {
            fieldItem.valueString = weakDropDownListBox.selectedLabel.text;
            fieldItem.isShowMustInputWarning = NO;
            
            [self.matterFormTableView reloadData];
        }
    };
}

//ID、name、value数组
- (NSArray *)idArrayFieldItem:(HTMIFieldItemModel *)fieldItem {
    NSMutableArray *idArray = [NSMutableArray array];
    
    for (HTMIItemDicsModel *model in fieldItem.dicsArray) {
        [idArray addObject:model.idString];
    }
    
    return idArray;
}

- (NSArray *)nameArrayFieldItem:(HTMIFieldItemModel *)fieldItem {
    NSMutableArray *nameArray = [NSMutableArray array];
    
    for (HTMIItemDicsModel *model in fieldItem.dicsArray) {
        [nameArray addObject:model.nameString];
    }
    
    return nameArray;
}

- (NSArray *)valueArrayFieldItem:(HTMIFieldItemModel *)fieldItem {
    NSMutableArray *valueArray = [NSMutableArray array];
    
    for (HTMIItemDicsModel *model in fieldItem.dicsArray) {
        [valueArray addObject:model.valueString];
    }
    
    return valueArray;
}

- (NSMutableArray *)listBoxArray {
    if (!_listBoxArray) {
        _listBoxArray = [NSMutableArray array];
    }
    
    return _listBoxArray;
}

#pragma mark ------ 互联网表单
- (void)netWorkPullDown:(UIView *)superView {
    
    CGRect valueRect = CGRectMake(0, 0, self.itemWidth, self.cellHeight);
    
    if (self.fieldItemModel.nameVisible) {
        //显示 name，固定 30% 长度
        CGRect nameRect = CGRectMake(stringLeftWidth, 0, kScreenWidth*0.3-stringLeftWidth*2, self.cellHeight);
        HTMISupportCopyLabel *namelabel = [HTMISupportCopyLabel creatLabelWithFrame:nameRect
                                                                               text:self.fieldItemModel.nameString
                                                                          alingment:@"Left"
                                                                          textColor:self.fieldItemModel.nameFontColor
                                                                           fontSize:self.formLabelFont];
        namelabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        [superView addSubview:namelabel];
        
        valueRect.origin.x += kScreenWidth*0.3;
        valueRect.size.width -= kScreenWidth*0.3;
        
    } else {//不显示name
        
    }
    
    HTMISupportCopyLabel *valuelabel = [HTMISupportCopyLabel creatLabelWithFrame:valueRect
                                                                            text:self.valueString
                                                                       alingment:@"Left"
                                                                       textColor:self.fieldItemModel.valueFontColor
                                                                        fontSize:self.formLabelFont];
    valuelabel.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0];
    [superView addSubview:valuelabel];
    
    UIImageView *arrowImageView = [[UIImageView alloc] init];
    arrowImageView.image = [UIImage imageNamed:@"icon_right_arrows"];
    [valuelabel addSubview:arrowImageView];
    
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(valuelabel).offset(-10);
        make.centerY.equalTo(valuelabel);
        make.width.height.mas_equalTo(40);
    }];
    
    //必填
    BOOL isMustinput = [self.fieldItemModel isMustInput:self.fieldItemModel.mustInput value:self.fieldItemModel.valueString];
    if (isMustinput) {
        valuelabel.text = @"(必填)";
        valuelabel.textColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
    }
    
    valuelabel.tag = superView.tag;
    UITapGestureRecognizer *borderViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selecet:)];
    [valuelabel addGestureRecognizer:borderViewTap];
    
    //可输入下拉
    if ([self.fieldItemModel.inputString isEqualToString:@"412"]) {
        valuelabel.text = @"";
        
        self.valueTextField = [[UITextField alloc] init];
        self.valueTextField.delegate = self;
        self.valueTextField.font = [UIFont htmi_systemFontOfSize:self.formLabelFont];
        self.valueTextField.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0];
        self.valueTextField.text = self.valueString;
        [valuelabel addSubview:self.valueTextField];
        
        [self.valueTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(valuelabel);
            make.right.equalTo(valuelabel).offset(-40);
        }];
    }
}

- (void)selecet:(UITapGestureRecognizer *)tap {
    //单选（ID、Name、Value）
    if ([self.delegate respondsToSelector:@selector(popViewDismiss)]) {
        [self.delegate popViewDismiss];
    }
    
    UITableViewCell *cell = [UITableViewCell getCellBy:tap.view];
    HTMIRegionCellModel *infoRegion = self.infoRegionArray[[self.matterFormTableView indexPathForCell:cell].row];
    HTMIFieldItemModel *fieldItem = infoRegion.fieldItemArray[tap.view.tag];
    
    NSMutableArray *nameArray = [NSMutableArray array];
    for (HTMIItemDicsModel *dicsModel in fieldItem.dicsArray) {
        [nameArray addObject:dicsModel.nameString];
    }
    HTMIMultipleSelectView *chooseSelect = [[HTMIMultipleSelectView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 200) showArray:nameArray selectString:HTMISelectTypeSingle];
    
    [self.window addSubview:chooseSelect];
    
    [chooseSelect show];
    
    [self.window bringSubviewToFront:chooseSelect];
    
    typeof(chooseSelect) __weakChooseSelect = chooseSelect;
    //typeof(self) __weakSelf = self;
    
    chooseSelect.selectTypeBlockString = ^(NSArray *selectArray) {
        
        [__weakChooseSelect dismiss];
        
        NSString *string = [selectArray componentsJoinedByString:@""];
        
        NSString *submitString = [self changeToSubmitStringBySelectArray:selectArray];
        
        [self.delegate editValueChangeKey:fieldItem.keyString
                                    value:submitString
                                     mode:fieldItem.modeString
                                inputType:fieldItem.inputString
                                  formKey:fieldItem.formkeyString
                                    isExt:fieldItem.is_ext
                                eventType:[NSString stringWithFormat:@"%@",fieldItem.ajaxEventModel.eventType]
                           fieldItemModel:fieldItem];
        
        fieldItem.valueString = string;
        
        [self.matterFormTableView reloadData];
        
    };
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.delegate editValueChangeKey:self.fieldItemModel.keyString
                                value:textField.text
                                 mode:self.fieldItemModel.modeString
                            inputType:self.fieldItemModel.inputString
                              formKey:self.fieldItemModel.formkeyString
                                isExt:self.fieldItemModel.is_ext
                            eventType:[NSString stringWithFormat:@"%@",self.fieldItemModel.ajaxEventModel.eventType]
                       fieldItemModel:self.fieldItemModel];
    
    self.fieldItemModel.valueString = textField.text;
    
    //    [self.matterFormTableView reloadData];
}

- (NSString *)changeToSubmitStringBySelectArray:(NSArray *)nameArray {
    
    NSMutableArray *submitArray = [NSMutableArray array];
    
    if ([self.fieldItemModel.inputString isEqualToString:@"401"]) {
        //ID
        for (NSString *nameString in nameArray) {
            
            for (HTMIItemDicsModel *model in self.fieldItemModel.dicsArray) {
                if ([nameString isEqualToString:model.nameString]) {
                    [submitArray addObject:model.idString];
                    break;
                }
            }
        }
        
    } else if ([self.fieldItemModel.inputString isEqualToString:@"403"]) {
        //value
        for (NSString *nameString in nameArray) {
            
            for (HTMIItemDicsModel *model in self.fieldItemModel.dicsArray) {
                if ([nameString isEqualToString:model.nameString]) {
                    [submitArray addObject:model.valueString];
                    break;
                }
            }
        }
        
    } else {
        //name
        submitArray = [NSMutableArray arrayWithArray:nameArray];
        
    }
    
    return [submitArray componentsJoinedByString:@";"];
    
}

/**
 处理Ajax事件 (需要子类实现)
 */
- (void)handleAjaxEvent:(HTMIFormChangedFieldModel *)changedFieldModel {
    
    //直接写事件的处理逻辑
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

@end
