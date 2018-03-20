//
//  HTMISelectView.m
//  单选多选
//
//  Created by 赵志国 on 16/6/16.
//  Copyright (c) 2016年 htmitech.com. All rights reserved.
//

#import "HTMISelectView.h"

#import "HTMISelectTableViewCell.h"

#import "HTMIItemDicsModel.h"

#import "UtilsMacros.h"


@interface HTMISelectView ()<UITableViewDataSource,UITableViewDelegate>

/**
 *  多选时存放选中数据
 */
@property (nonatomic, strong) NSMutableArray *selectedArray;

/**
 *  单选时选中行
 */
@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, strong) UITableView *boxTableView;

/**
 *  array
 */
@property (nonatomic, strong) NSArray *dicsArray;

/**
 *  是否必填
 */
@property (nonatomic, assign) BOOL isMustInput;

/**
 *  已经选了的
 */
@property (nonatomic, copy) NSString *valueString;

@end

@implementation HTMISelectView

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame dicsArray:(NSArray *)dicsArray selectType:(selectType)selectType isMustInput:(BOOL)isMustInput value:(NSString *)valueString {
    self = [super initWithFrame:frame];
    if (self) {
        self.boxTableView = [[UITableView alloc] initWithFrame:self.bounds];
        self.boxTableView.delegate = self;
        self.boxTableView.dataSource = self;
        self.boxTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.boxTableView.scrollEnabled = NO;
        //水印
        self.boxTableView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.boxTableView];
        
        self.selectedIndex = -1;
        
        self.selectType = selectType;
        self.dicsArray = dicsArray;
        
        for (HTMIItemDicsModel *model in dicsArray) {
            [self.idArray addObject:model.idString];
            [self.nameArray addObject:model.nameString];
            [self.valueArray addObject:model.valueString];
        }
        
        self.isMustInput = isMustInput;
        self.valueString = valueString;
    }
    
    return self;
}

#pragma mark UITableViewDelegate && UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.nameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *myCell = @"selectBoxCell";
    HTMISelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
    if (!cell) {
        cell = [[HTMISelectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCell cellWidth:self.frame.size.width];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //水印
    if (self.isMustInput) {
        cell.backgroundColor = [UIColor colorWithRed:254/255.0 green:250/255.0 blue:235/255.0 alpha:0.6];
    } else {
        cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0];
    }
    
    if (self.selectType == SingleSelectionID ||
        self.selectType == SingleSelectionName ||
        self.selectType == SingleSelectionValue) {
        //单选
        if (indexPath.row == self.selectedIndex ||
            [self.valueString isEqualToString:self.nameArray[indexPath.row]]) {
            [cell.cellImageView setImage:[UIImage imageNamed:@"btn_radio_selected"]];
            
        } else {
            [cell.cellImageView setImage:[UIImage imageNamed:@"btn_radio_normal"]];
        }
        
    } else if (self.selectType == MultiSelectionID ||
               self.selectType == MultiSelectionName ||
               self.selectType == MultiSelectionValue) {
            NSArray *selectArray = [self.valueString componentsSeparatedByString:@"|"];
            
            
            if ([selectArray containsObject:self.nameArray[indexPath.row]]) {
                cell.cellImageView.image = [UIImage imageNamed:@"btn_check_selected"];
                
                if (self.selectType == MultiSelectionID) {
                    [self.selectedArray addObject:self.idArray[indexPath.row]];
                } else if (self.selectType == MultiSelectionName) {
                    [self.selectedArray addObject:self.nameArray[indexPath.row]];
                } else if (self.selectType == MultiSelectionValue) {
                    [self.selectedArray addObject:self.valueArray[indexPath.row]];
                }
                
            } else {
                cell.cellImageView.image = [UIImage imageNamed:@"btn_check_normal"];
            }
    }

    cell.cellLabel.text = self.nameArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (self.selectType == SingleSelectionName) {//单选返回name
        self.selectedIndex = indexPath.row;
        self.SingleSelectionBlock(self.nameArray[indexPath.row]);
        
    } else if (self.selectType == SingleSelectionID) {//单选返回id
        self.selectedIndex = indexPath.row;
        self.SingleSelectionBlock(self.idArray[indexPath.row]);
        
    } else if (self.selectType == SingleSelectionValue) {//单选返回value
        self.selectedIndex = indexPath.row;
        self.SingleSelectionBlock(self.valueArray[indexPath.row]);
        
    } else if (self.selectType == MultiSelectionName) {//多选返回name
        NSArray *selectArray = [self.valueString componentsSeparatedByString:@"|"];
        
        
        if ([selectArray containsObject:self.nameArray[indexPath.row]]) {
            [self.selectedArray removeObject:self.nameArray[indexPath.row]];
        } else {
            [self.selectedArray addObject:self.nameArray[indexPath.row]];
        }
        
        self.MultiSelectionBlock(self.selectedArray);
        
    } else if (self.selectType == MultiSelectionID) {//多选返回id
        NSArray *selectArray = [self.valueString componentsSeparatedByString:@"|"];
        
        
        if ([selectArray containsObject:self.nameArray[indexPath.row]]) {
            [self.selectedArray removeObject:self.idArray[indexPath.row]];
        } else {
            [self.selectedArray addObject:self.idArray[indexPath.row]];
        }
        
        self.MultiSelectionBlock(self.selectedArray);
        
    } else if (self.selectType == MultiSelectionValue) {//多选返回value
        NSArray *selectArray = [self.valueString componentsSeparatedByString:@"|"];
        
        
        if ([selectArray containsObject:self.nameArray[indexPath.row]]) {
            [self.selectedArray removeObject:self.valueArray[indexPath.row]];
        } else {
            [self.selectedArray addObject:self.valueArray[indexPath.row]];
        }
        
        self.MultiSelectionBlock(self.selectedArray);
        
    }
    
//    [tableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kH6(40);
}

#pragma mark ------ 懒加载
- (NSMutableArray *)selectedArray {
    if (!_selectedArray) {
        _selectedArray = [NSMutableArray array];
    }
    
    return _selectedArray;
}

- (NSMutableArray *)idArray {
    if (!_idArray) {
        _idArray = [NSMutableArray array];
    }
    
    return _idArray;
}

- (NSMutableArray *)nameArray {
    if (!_nameArray) {
        _nameArray = [NSMutableArray array];
    }
    
    return _nameArray;
}

- (NSMutableArray *)valueArray {
    if (!_valueArray) {
        _valueArray = [NSMutableArray array];
    }
    
    return _valueArray;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
