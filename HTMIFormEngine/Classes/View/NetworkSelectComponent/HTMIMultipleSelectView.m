//
//  HTMIMultipleSelectView.m
//  choose单选多选
//
//  Created by Zc on 2017/8/30.
//  Copyright © 2017年 Zc. All rights reserved.
//

#import "HTMIMultipleSelectView.h"
#import "HTMIMultioleTableViewCell.h"

#import "HTMISettingManager.h"

#import "UtilsMacros.h"

@interface HTMIMultipleSelectView ()
<UIPickerViewDelegate,
UIPickerViewDataSource,
UITableViewDelegate,
UITableViewDataSource>


//当前view的height
@property (assign, nonatomic) NSInteger height;
#pragma mark 单选
@property (nonatomic, strong)NSMutableArray *allMultipleSelectmArray;
@property (strong, nonatomic) UIPickerView *singlePickerView;
@property (strong, nonatomic) UILabel *myTimeLabel;
@property (copy, nonatomic) NSString *selectString;

#pragma mark 多选

@property (strong, nonatomic) UITableView *moreTableView;
@property (strong, nonatomic) NSMutableArray *selectedmArray;

@end
//取消 完成 view的height
static NSInteger viewHeight = 40;

@implementation HTMIMultipleSelectView

//cellidentifier
static NSString *Identifier = @"HTMIMultioleTableViewCellIdentifier";

static NSInteger kSingle = 200;//单选视图弹出高度

static NSInteger kMulti = 350;//多选视图弹出高度

- (instancetype)initWithFrame:(CGRect)frame showArray:(NSArray *)array selectString:(HTMISelectType)selectString
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _selectType = selectString;
        [self.allMultipleSelectmArray addObjectsFromArray:array];
        [self makeSureAndCancleButtonAndLabelTime];
        switch (selectString) {
                //单选
            case HTMISelectTypeSingle:
                self.height = kSingle;
                [self singleSelectPickerView];
                break;
                //多选
            case HTMISelectTypeMulti:
                self.height = kMulti;
                [self moreSelectTableView];
                
                break;
                
            default:
                break;
        }
    }
    return self;
}

#pragma mark ---------单选控件布局---------
- (void)singleSelectPickerView{
    self.singlePickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, viewHeight, kScreenWidth, self.height - viewHeight)];
    // 显示选中框
    self.singlePickerView.showsSelectionIndicator = YES;
    self.singlePickerView.dataSource = self;
    self.singlePickerView.delegate = self;
    NSInteger framex = self.height/2-29;
    UIImageView *selectionCenterView=[[UIImageView alloc]initWithFrame:CGRectMake(0, framex, kScreenWidth, 36)];
    selectionCenterView.backgroundColor = [UIColor clearColor];
    selectionCenterView.alpha = 0.5;
    [self.singlePickerView addSubview:selectionCenterView];
    [self addSubview:self.singlePickerView];
    
    [self.singlePickerView selectRow:1 inComponent:0 animated:NO];
    self.selectString = self.allMultipleSelectmArray[1];
    
}
#pragma mark 代理方法UIPickerViewDataSource
// 返回多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
// 返回每列的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.allMultipleSelectmArray.count;
}
#pragma mark 代理方法UIPickerViewDelegate
// 反回pickerView的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return kScreenWidth;
};
// 返回pickerView 每行的内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return self.allMultipleSelectmArray[row];
};

// 选中行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    self.myTimeLabel.text = [NSString stringWithFormat:@"%@",self.allMultipleSelectmArray[row]];
    self.selectString = [NSString stringWithFormat:@"%@",self.allMultipleSelectmArray[row]];
};
#pragma mark 调整字体显示大小
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.font = [UIFont systemFontOfSize:8.0];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}
#pragma mark ------ 确定 、 取消 按钮
- (void)makeSureAndCancleButtonAndLabelTime {
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, viewHeight)];
    
    bgView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    [self addSubview:bgView];
    NSArray *array = @[FormGetHTMILocalString(@"htmi_photo_cancel"),
                       FormGetHTMILocalString(@"htmi_device_complete")];
    UIButton *mscButton1 = [UIButton buttonWithType:UIButtonTypeSystem];
    mscButton1.frame = CGRectMake(0, 5, kW6(60), kH6(30));
    [mscButton1 setTitle:array[0] forState:UIControlStateNormal];
    [mscButton1 setTitleColor:[UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0] forState:UIControlStateNormal];
    mscButton1.titleLabel.font = [UIFont systemFontOfSize:15];
    mscButton1.backgroundColor = [UIColor clearColor];
    mscButton1.tag = HTMIUIButtonTagTypeCancel;
    [mscButton1 addTarget:self action:@selector(makeSureAndCancleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:mscButton1];
    
    UIButton *mscButton2 = [UIButton buttonWithType:UIButtonTypeSystem];
    mscButton2.frame = CGRectMake(kScreenWidth-kW6(60), 5, kW6(60), kH6(30));
    [mscButton2 setTitle:array[1] forState:UIControlStateNormal];
    if (kApplicationHue == HTMIApplicationHueWhite) {//白色色调
        [mscButton2 setTitleColor:[UIColor colorWithRed:41/255.0 green:123/255.0 blue:251/255.0 alpha:1.0] forState:UIControlStateNormal];
    } else {
        [mscButton2 setTitleColor:navBarColor forState:UIControlStateNormal];
    }
    
    mscButton2.titleLabel.font = [UIFont systemFontOfSize:15];
    mscButton2.backgroundColor = [UIColor clearColor];
    mscButton2.tag = HTMIUIButtonTagTypeConfim;
    [mscButton2 addTarget:self action:@selector(makeSureAndCancleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:mscButton2];
    
    self.myTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(kW6(60), 5, kScreenWidth-kW6(120), kH6(30))];
    self.myTimeLabel.font = [UIFont systemFontOfSize:15];
    self.myTimeLabel.textAlignment = NSTextAlignmentCenter;
    //[self addSubview:self.myTimeLabel];
    UIImageView *myImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    myImg.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
    [bgView addSubview:myImg];
    
}
- (void)makeSureAndCancleButtonClick:(UIButton *)btn {
    if (btn.tag == HTMIUIButtonTagTypeConfim) {
        
        if (_selectType == HTMISelectTypeSingle) {
            self.selectTypeBlockString(@[self.selectString]);
        }else{
            self.selectTypeBlockString(self.selectedmArray);
        }
    }else if (btn.tag == HTMIUIButtonTagTypeCancel){
        
        [self dismiss];
    }
    
    [self.delegate myresignFirstResponder];
}
-(NSMutableArray *)allMultipleSelectmArray{
    if (!_allMultipleSelectmArray) {
        _allMultipleSelectmArray = [NSMutableArray array];
    }
    return _allMultipleSelectmArray;
}
/**
 单选显示
 */
- (void)show{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    tempView.backgroundColor = [UIColor blackColor];
    tempView.alpha = 0.5;
    tempView.tag = 901;
    [self.window addSubview:tempView];
    
    [UIView beginAnimations:@"move" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    self.frame = CGRectMake(0, kScreenHeight-self.height, kScreenWidth, self.height);
    [UIView commitAnimations];
    
    
}
/**
 单选取消
 */
- (void)dismiss{
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(0, kScreenHeight, kScreenWidth, self.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    UIView *tempView = [self.window viewWithTag:901];
    [tempView removeFromSuperview];
}
#pragma mark ---------多选控件布局 ----------

- (void)moreSelectTableView{
    
    [self addSubview:self.moreTableView];
    [self.moreTableView registerNib:[UINib nibWithNibName:@"HTMIMultioleTableViewCell" bundle:nil] forCellReuseIdentifier:Identifier];
}

-(UITableView *)moreTableView{
    if (!_moreTableView) {
        _moreTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, viewHeight, kScreenWidth,  self.height - viewHeight) style:UITableViewStylePlain];
        _moreTableView.delegate = self;
        _moreTableView.dataSource = self;
    }
    return _moreTableView;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allMultipleSelectmArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HTMIMultioleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        cell = [[HTMIMultioleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.moreTitleLabel.text = [NSString stringWithFormat:@"%@",self.allMultipleSelectmArray[indexPath.row]];
    if ([self.selectedmArray containsObject:self.allMultipleSelectmArray[indexPath.row]]) {
        cell.moreTitleLabel.textColor = [UIColor colorWithRed:41/255.0 green:123/255.0 blue:251/255.0 alpha:1.0];
        cell.chooseImg.image = [UIImage imageNamed:@"btn_check_selected"];
    }else{
        cell.moreTitleLabel.textColor = [UIColor blackColor];
        cell.chooseImg.image = [UIImage imageNamed:@"btn_check_normal"];
    }
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.selectedmArray containsObject:self.allMultipleSelectmArray[indexPath.row]]) {
        
        [self.selectedmArray removeObject:self.allMultipleSelectmArray[indexPath.row]];
    }else{
        
        [self.selectedmArray addObject:self.allMultipleSelectmArray[indexPath.row]];
    }
    [tableView reloadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (NSMutableArray *)selectedmArray{
    if (!_selectedmArray) {
        _selectedmArray = [NSMutableArray array];
    }
    return _selectedmArray;
}
@end
