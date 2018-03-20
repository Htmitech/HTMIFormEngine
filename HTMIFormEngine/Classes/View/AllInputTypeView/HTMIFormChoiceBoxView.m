//
//  HTMIChoiceBoxView.m
//  MXClient
//
//  Created by 赵志国 on 2017/8/25.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import "HTMIFormChoiceBoxView.h"

#import "HTMIFormComponentHeader.h"

#import "HTMISupportCopyLabel.h"

#import "NSString+HTMISize.h"

#import "HTMISelectView.h"

#import "Masonry.h"

#import "HTMIMultipleSelectView.h"

#import "UITableViewCell+GetCell.h"
#import "HTMIStandardAjaxEventModel.h"

#import "UIFont+HTMIFont.h"

#import "HTMITabFormModel.h"


@implementation HTMIFormChoiceBoxView

#pragma mark ------ 单选多选框（内容）
- (void)inputTypeFieldItem:(HTMIFieldItemModel *)fieldItem name:(NSString *)nameString value:(NSString *)valueString width:(CGFloat)itemWidth totalView:(UIView *)view cellHeight:(CGFloat)cellHeight {
    
    [view addSubview:self];
    self.frame = view.bounds;
    
    NSArray *array = fieldItem.dicsArray;
    
    //CGFloat nameHeight = nameString.length>0 ? [NSString labelSizeWithMaxWidth:itemWidth-stringLeftWidth*2 content:nameString FontOfSize:self.formLabelFont].height+stringTopHeight*2 : 0;
    
    if ((![fieldItem.modeString isEqual:[NSNull null]] && [fieldItem.modeString isEqualToString:@"1"])) {//可编辑
        
        if (self.tabFormModel.tabStyle == 0) {
            
            CGRect tempRect = CGRectMake(0, 0, itemWidth, cellHeight);
            
            if (fieldItem.nameVisible) {
                
                if (fieldItem.nameRN) {//显示name且分行显示
                    
                    CGFloat nameHeight = nameString.length>0 ? [NSString labelSizeWithMaxWidth:itemWidth-stringLeftWidth*2 content:nameString FontOfSize:self.formLabelFont].height+stringTopHeight*2 : 0;
                    
                    HTMISupportCopyLabel *namelabel = [HTMISupportCopyLabel creatLabelWithFrame:CGRectMake(stringLeftWidth, 0, itemWidth-stringLeftWidth*2, nameHeight) text:nameString alingment:fieldItem.alignString textColor:fieldItem.nameFontColor fontSize:self.formLabelFont];
                    [view addSubview:namelabel];
                    
                    tempRect.origin.y += nameHeight;
                    tempRect.size.height -= nameHeight;
                    
                    
                } else {//显示name不分行
                    
                    CGFloat nameWidth = [NSString labelSizeWithMaxWidth:0 content:nameString FontOfSize:self.formLabelFont].width;
                    
                    HTMISupportCopyLabel *namelabel = [HTMISupportCopyLabel creatLabelWithFrame:CGRectMake(stringLeftWidth, 0, nameWidth, cellHeight) text:nameString alingment:fieldItem.alignString textColor:fieldItem.nameFontColor fontSize:self.formLabelFont];
                    [view addSubview:namelabel];
                    
                    tempRect.origin.x += (nameWidth+stringLeftWidth);
                    tempRect.size.width -= (nameWidth+stringLeftWidth);
                    
                }
                
            } else {//不显示name
                
            }
            
            [self creatSelectViewFrame:tempRect superView:view array:array fieldItem:fieldItem];
            
            
        } else {
            //互联网表单单选多选
            [self netWorkFormChoiceBox:view];
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

- (void)creatSelectViewFrame:(CGRect)frame superView:(UIView *)superView array:(NSArray *)array fieldItem:(HTMIFieldItemModel *)fieldItem {
    NSDictionary *dic = @{@"501":@"0",
                          @"502":@"1",
                          @"503":@"2",
                          @"511":@"3",
                          @"512":@"4",
                          @"513":@"5"};
    
    BOOL isMustInput = fieldItem.mustInput;
    
    HTMISelectView *selectView = [[HTMISelectView alloc] initWithFrame:frame dicsArray:array selectType:[[dic objectForKey:fieldItem.inputString] integerValue] isMustInput:isMustInput value:[self changValueOrIdToName:fieldItem.valueString dicArrarr:fieldItem.dicsArray]];
    [superView addSubview:selectView];
    
    if (self.fieldItemModel.isShowMustInputWarning) {
        selectView.layer.borderWidth = 1.0;
        selectView.layer.borderColor = WARNING_BORDER_COLOR;
    } else {
        selectView.layer.borderWidth = 0.0;
    }
    
    __weak typeof(self) weakSelf = self;
    __weak typeof(fieldItem) weakItem = fieldItem;
    
    selectView.MultiSelectionBlock = ^(NSArray *array) {
        
        NSString *string = [array componentsJoinedByString:@";"];
        
        [self.delegate editValueChangeKey:weakItem.keyString
                                    value:string
                                     mode:weakItem.modeString
                                inputType:weakItem.inputString
                                  formKey:weakItem.formkeyString
                                    isExt:weakItem.is_ext
                                eventType:[NSString stringWithFormat:@"%@",weakItem.ajaxEventModel.eventType]
         fieldItemModel:weakItem];
        
        weakItem.valueString = string;
        weakItem.isShowMustInputWarning = NO;
        
        [weakSelf.matterFormTableView reloadData];
    };
    
    selectView.SingleSelectionBlock = ^(NSString *string) {
        
        [self.delegate editValueChangeKey:weakItem.keyString
                                    value:string
                                     mode:weakItem.modeString
                                inputType:weakItem.inputString
                                  formKey:weakItem.formkeyString
                                    isExt:weakItem.is_ext
                                eventType:[NSString stringWithFormat:@"%@",weakItem.ajaxEventModel.eventType]
         fieldItemModel:weakItem];
        
        weakItem.valueString = string;
        weakItem.isShowMustInputWarning = NO;
        
        [weakSelf.matterFormTableView reloadData];
    };
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
//    for (NSDictionary *dict in changedFieldModel.dics) {
//        HTMIItemDicsModel *model = [HTMIItemDicsModel getItemDicsModelWithDict:dict];
//        [dicsMarray addObject:model];
//    }
    self.fieldItemModel.dicsArray = [changedFieldModel.dics copy];
    
    [self.matterFormTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:self.indexPath,nil] withRowAnimation:UITableViewRowAnimationFade];
//    [self.matterFormTableView reloadData];
}

#pragma mark ------ 互联网表单
- (void)netWorkFormChoiceBox:(UIView *)totalView {
    
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
        [totalView addSubview:namelabel];
        
        valueRect.origin.x += kScreenWidth*0.3;
        valueRect.size.width -= (kScreenWidth*0.3+50);
        
    } else {//不显示name
        
    }
    
    HTMISupportCopyLabel *valuelabel = [HTMISupportCopyLabel creatLabelWithFrame:valueRect
                                                                            text:self.valueString
                                                                       alingment:@"Left"
                                                                       textColor:self.fieldItemModel.valueFontColor
                                                                        fontSize:self.formLabelFont];
    valuelabel.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0];
    [totalView addSubview:valuelabel];
    
    UIImageView *arrowImageView = [[UIImageView alloc] init];
    arrowImageView.image = [UIImage imageNamed:@"icon_right_arrows"];
    [totalView addSubview:arrowImageView];
    
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(totalView).offset(-10);
        make.centerY.equalTo(valuelabel);
        make.width.height.mas_equalTo(40);
    }];
    
    //必填
    BOOL isMustinput = [self.fieldItemModel isMustInput:self.fieldItemModel.mustInput value:self.fieldItemModel.valueString];
    if (isMustinput) {
        valuelabel.text = [NSString stringWithFormat:@"（%@）",FormGetHTMILocalString(@"htmi_workflow_mandatory")];
        valuelabel.textColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
    }
    
    valuelabel.tag = totalView.tag;
    UITapGestureRecognizer *borderViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selecet:)];
    [valuelabel addGestureRecognizer:borderViewTap];
    
}

- (void)selecet:(UITapGestureRecognizer *)tap {
    //单选（ID、Name、Value），多选（ID、Name、Value）
    if ([self.delegate respondsToSelector:@selector(popViewDismiss)]) {
        [self.delegate popViewDismiss];
    }
    
    UITableViewCell *cell = [UITableViewCell getCellBy:tap.view];
    HTMIRegionCellModel *infoRegion = self.infoRegionArray[[self.matterFormTableView indexPathForCell:cell].row];
    HTMIFieldItemModel *fieldItem = infoRegion.fieldItemArray[tap.view.tag];
    
    NSMutableArray *nameArray = [NSMutableArray array];
    for (HTMIItemDicsModel *model in fieldItem.dicsArray) {
        [nameArray addObject:model.nameString];
    }
    HTMIMultipleSelectView *chooseSelect = nil;
    if ([self.fieldItemModel.inputString isEqualToString:@"501"] || [self.fieldItemModel.inputString isEqualToString:@"502"] || [self.fieldItemModel.inputString isEqualToString:@"503"]) {
        chooseSelect = [[HTMIMultipleSelectView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 200) showArray:nameArray selectString:HTMISelectTypeSingle];
        
    } else {
        chooseSelect = [[HTMIMultipleSelectView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 350) showArray:nameArray selectString:HTMISelectTypeMulti];
    }
    
    [self.window addSubview:chooseSelect];
    
    [chooseSelect show];
    
    [self.window bringSubviewToFront:chooseSelect];
    
    __weak typeof(chooseSelect) weakChooseSelect = chooseSelect;
    __weak typeof(fieldItem) weakItem = fieldItem;
    __weak typeof(self) weakSelf = self;
    
    chooseSelect.selectTypeBlockString = ^(NSArray *selectArray) {
        
        [weakChooseSelect dismiss];
        
        NSString *string = [selectArray componentsJoinedByString:@";"];
        
        NSString *submitString = [self changeToSubmitStringBySelectArray:selectArray];
        
        [self.delegate editValueChangeKey:weakItem.keyString
                                    value:submitString
                                     mode:weakItem.modeString
                                inputType:weakItem.inputString
                                  formKey:weakItem.formkeyString
                                    isExt:weakItem.is_ext
                                eventType:[NSString stringWithFormat:@"%@",weakItem.ajaxEventModel.eventType]
         fieldItemModel:weakItem];
        
        weakItem.valueString = string;
        
        [weakSelf.matterFormTableView reloadData];
        
    };
}

- (NSString *)changeToSubmitStringBySelectArray:(NSArray *)nameArray {
    
    NSMutableArray *submitArray = [NSMutableArray array];
    
    if ([self.fieldItemModel.inputString isEqualToString:@"501"] || [self.fieldItemModel.inputString isEqualToString:@"511"]) {
        //ID
        for (NSString *nameString in nameArray) {
            
            for (HTMIItemDicsModel *model in self.fieldItemModel.dicsArray) {
                if ([nameString isEqualToString:model.nameString]) {
                    [submitArray addObject:model.idString];
                    break;
                }
            }
        }
        
    } else if ([self.fieldItemModel.inputString isEqualToString:@"503"] || [self.fieldItemModel.inputString isEqualToString:@"513"]) {
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
