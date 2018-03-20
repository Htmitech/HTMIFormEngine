//
//  HTMIFormOpinionAutographView.m
//  MXClient
//
//  Created by 赵志国 on 2017/8/25.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import "HTMIFormOpinionAutographView.h"

#import "HTMIFormComponentHeader.h"

#import "NSString+HTMISize.h"

#import "HTMISupportCopyLabel.h"

//#import "UIView+Common.h"

#import "HTMIUserdefaultHelper.h"

#import "HTMIOpinionAutographView.h"

//#import "HTMIQuickOpinionViewController.h"

#import "UITableViewCell+GetCell.h"

//#import "HTMISYS_UserModel.h"

//#import "HTMIDBManager.h"

//#import "HTMIWorkFlowComponetManager.h"

#import "HTMISettingManager.h"

//#import "HTMIOAMatterFormTableViewController.h"

#import "HTMINetWorkOpnionView.h"

#import "Masonry.h"

#import "HTMINetWorkChangeOpinionView.h"
#import "HTMIStandardAjaxEventModel.h"

//#import "HTMILoginUserModel.h"

#import "UIFont+HTMIFont.h"

#import "HTMIConstString.h"

#import "UIView+BorderView.h"

#import "HTMITabFormModel.h"

@interface HTMIFormOpinionAutographView ()//<HTMIQuickOpinionViewControllerDelegate>

@property (nonatomic, copy) NSString *myUserName;

@property (nonatomic, assign) NSInteger currentEidtRegionIndex;

@property (nonatomic, assign) NSInteger currentEidtFieldItemIndex;

@property (nonatomic, strong) NSMutableArray *opinionIdArray;

@property (nonatomic, assign) NSInteger opinionIdIndex;

@property (nonatomic, strong) NSMutableArray *autographNameArray;

@property (nonatomic, assign) NSInteger autographIndex;
@end

@implementation HTMIFormOpinionAutographView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.myUserName = [[NSUserDefaults standardUserDefaults] objectForKey:kHTMI_User_Name];
    }
    return self;
}

#pragma mark ------ 意见、签名、意见或签名（内容）
- (void)inputTypeFieldItem:(HTMIFieldItemModel *)fieldItem name:(NSString *)nameString value:(NSString *)valueString width:(CGFloat)itemWidth totalView:(UIView *)view cellHeight:(CGFloat)cellHeight {
    
    [view addSubview:self];
    self.frame = view.bounds;
    
    if (self.tabFormModel.tabStyle == 0) {
        
        if ((![fieldItem.modeString isEqual:[NSNull null]] && [fieldItem.modeString isEqualToString:@"1"])) {
            
            CGRect tempRect = CGRectMake(0, 0, itemWidth, cellHeight);
            
            if (fieldItem.nameVisible) {
                
                if (fieldItem.nameRN) {//显示name且分行显示
                    
                    CGFloat nameHeight = [self p_nameVisibleAndNameRNSuperView:view];
                    
                    tempRect.origin.y += nameHeight;
                    tempRect.size.height -= nameHeight;
                    
                } else {//显示name不分行
                    
                   CGFloat nameWidth = [self p_nameVisibleSuperView:view];
                    
                    tempRect.origin.x += nameWidth;
                    tempRect.size.width -= nameWidth;
                    
                }
            }
            
            UIView *tempView = [[UIView alloc] initWithFrame:tempRect];
            tempView.tag = view.tag;
            [view addSubview:tempView];
            
            CGFloat existHeight = [self p_existOpnionAndAutographSuperView:tempView];
            
            [self p_editViewWithExistHeight:existHeight superView:tempView];
        } else {
            
            [self p_noEditShowSuperView:view];
        }
    } else {
        //互联网表单
        
        [self networkFormOpnionAndAutograph:view];
    }
    
}


#pragma mark ------ 私有方法
- (CGFloat)p_nameVisibleAndNameRNSuperView:(UIView *)superView {
    CGFloat nameHeight = [NSString labelSizeWithMaxWidth:self.itemWidth-stringLeftWidth*2 content:self.nameString FontOfSize:self.formLabelFont].height+stringTopHeight;
    
    CGRect nameRect = CGRectMake(stringLeftWidth, 0, self.itemWidth-stringLeftWidth*2, nameHeight);
    HTMISupportCopyLabel *namelabel = [HTMISupportCopyLabel creatLabelWithFrame:nameRect
                                                                           text:self.nameString
                                                                      alingment:self.fieldItemModel.alignString
                                                                      textColor:self.fieldItemModel.nameFontColor
                                                                       fontSize:self.formLabelFont];
    [superView addSubview:namelabel];
    
    return nameHeight;
}

- (CGFloat)p_nameVisibleSuperView:(UIView *)superView {
    CGFloat nameWidth = [NSString labelSizeWithMaxWidth:0 content:self.nameString FontOfSize:self.formLabelFont].width;
    
    HTMISupportCopyLabel *namelabel = [HTMISupportCopyLabel creatLabelWithFrame:CGRectMake(stringLeftWidth, 0, nameWidth, self.cellHeight)
                                                                           text:self.nameString
                                                                      alingment:self.fieldItemModel.alignString
                                                                      textColor:self.fieldItemModel.nameFontColor
                                                                       fontSize:self.formLabelFont];
    [superView addSubview:namelabel];
    
    return nameWidth+stringLeftWidth;
}

- (void)p_editViewWithExistHeight:(CGFloat)existHeight superView:(UIView *)superView {
    
    if ([self.fieldItemModel.inputString isEqualToString:@"2001"]) {
        
        [self p_editOpinionViewWithExistHeight:existHeight superView:superView];
        
    } else if ([self.fieldItemModel.inputString isEqualToString:@"2002"]) {
        
        HTMIItemOpintionModel *model = [self.fieldItemModel.opintionArray lastObject];
        
        if ([model.userNameString rangeOfString:self.myUserName].location == NSNotFound || model.userNameString.length < 1) {
            [self p_editOpinionViewWithExistHeight:existHeight superView:superView];
        }
        else if ([model.userNameString rangeOfString:self.myUserName].location != NSNotFound && model.userNameString.length > 0) {
            self.fieldItemModel.valueString = model.userNameString;
        }
        
    } else if ([self.fieldItemModel.inputString isEqualToString:@"2003"]) {
        
        [self p_editOpinionOrAutographViewWithExistHeight:existHeight superView:superView];
        
    } else if ([self.fieldItemModel.inputString isEqualToString:@"2004"]) {
        
        if (self.fieldItemModel.opintionArray.count < 1) {
            
            [self p_editOpinionViewWithExistHeight:0 superView:superView];
            
        }
    }
}

/**
 意见、签名、修改意见
 */
- (void)p_editOpinionViewWithExistHeight:(CGFloat)existHeight superView:(UIView *)superView {
    CGRect rect = CGRectMake(borderLeftWidth,
                             borderTopHeight+existHeight,
                             W(superView)-borderLeftWidth*2,
                             H(superView)-borderTopHeight*2-existHeight);
    UIView *borderView = [UIView creatBorderViewFrame:rect];
    [superView addSubview:borderView];
    
    if (self.fieldItemModel.mustInput) {
        borderView.backgroundColor = mustInputColor;
    }
    
    if (self.fieldItemModel.isShowMustInputWarning) {
        borderView.layer.borderColor = WARNING_BORDER_COLOR;
    } else {
        borderView.layer.borderColor = NORMAL_BORDER_COLOR;
    }
    
    CGRect labelRect = CGRectMake(stringLeftWidth,
                                  borderTopHeight+existHeight,
                                  W(superView)-stringLeftWidth*2,
                                  H(superView)-borderTopHeight*2-existHeight);
    HTMISupportCopyLabel *label = [[HTMISupportCopyLabel alloc] initWithFrame:labelRect];
    label.adjustsFontSizeToFitWidth = YES;
    label.numberOfLines = 0;
    label.font = [UIFont htmi_systemFontOfSize:self.formLabelFont];
    label.text = self.fieldItemModel.valueString;
    label.tag = superView.tag;
    [superView addSubview:label];
    
    NSString *mustInputString = FormGetHTMILocalString(@"htmi_common_pleasefillinopinion");
    
    if ([self.fieldItemModel.inputString isEqualToString:@"2002"]) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(W(borderView)-30, 0, 40, 40)];
        imageView.image = [UIImage imageNamed:@"btn_singnature"];
        [borderView addSubview:imageView];
        
        mustInputString = FormGetHTMILocalString(@"htmi_common_signature");
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(autographTap:)];
        tap.delegate = self;
        [label addGestureRecognizer:tap];
        
    } else {
        UITapGestureRecognizer *opinionViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(opinionViewTapClick:)];
        opinionViewTap.delegate = self;
        [label addGestureRecognizer:opinionViewTap];
    }
    
    if (self.fieldItemModel.valueString.length < 1) {
        label.text = mustInputString;
        label.textColor = [UIColor lightGrayColor];
    }
}

/**
 签名或意见
 */
- (void)p_editOpinionOrAutographViewWithExistHeight:(CGFloat)existHeight superView:(UIView *)superView {
    
    CGFloat eidtHeight = 0;
    if (self.fieldItemModel.valueString.length > 0) {//编写的意见或签名
        CGFloat editH = [NSString labelSizeWithMaxWidth:W(superView)-stringLeftWidth*2 content:self.fieldItemModel.valueString FontOfSize:self.formLabelFont].height+stringTopHeight*2;
        
        eidtHeight = MAX(editH, kH6(50));
        
        HTMISupportCopyLabel *eidtLabel = [HTMISupportCopyLabel creatLabelWithFrame:CGRectMake(stringLeftWidth, existHeight+(W(superView)>kW6(200) ? kH6(50) :kH6(100)), W(superView)-stringLeftWidth*2, H(superView)-(existHeight+(W(superView)>kW6(200) ? kH6(50) :kH6(100)))) text:self.fieldItemModel.valueString alingment:@"Left" textColor:self.fieldItemModel.valueFontColor fontSize:self.formLabelFont];
        [superView addSubview:eidtLabel];
    }
    
    HTMIOpinionAutographView *oaView = [[HTMIOpinionAutographView alloc]
                                        initWithFrame:CGRectMake(0,existHeight,W(superView),H(superView)-existHeight-eidtHeight)
                                        selectType:VerticalType aOro:self.fieldItemModel.autographOrOpinionString];
    [superView addSubview:oaView];
    
    BOOL isMustInput = self.fieldItemModel.mustInput;
    if (isMustInput) {
        oaView.backgroundColor = mustInputColor;
    }
    
    if (self.fieldItemModel.isShowMustInputWarning) {
        oaView.layer.borderWidth = 1.0;
        oaView.layer.borderColor = WARNING_BORDER_COLOR;
    } else {
        oaView.layer.borderWidth = 0.0;
    }
    
    typeof(self) __weakSelf = self;
    
    oaView.buttonClickBlock = ^(NSString *string) {
        
        if ([string isEqualToString:FormGetHTMILocalString(@"htmi_common_signature")]) {
            self.fieldItemModel.valueString = self.myUserName;
            self.fieldItemModel.isShowMustInputWarning = NO;
            self.fieldItemModel.autographOrOpinionString = FormGetHTMILocalString(@"htmi_common_signature");
            
            //签名     暂时显示姓名，提交空格
            [self.delegate editValueChangeKey:self.fieldItemModel.keyString
                                        value:@" "
                                         mode:self.fieldItemModel.modeString
                                    inputType:self.fieldItemModel.inputString
                                      formKey:self.fieldItemModel.formkeyString
                                        isExt:self.fieldItemModel.is_ext
                                    eventType:[NSString stringWithFormat:@"%@",self.fieldItemModel.ajaxEventModel.eventType]
             fieldItemModel:self.fieldItemModel];
            
            [__weakSelf.matterFormTableView reloadData];
            
        } else if ([string isEqualToString:FormGetHTMILocalString(@"htmi_screenshot_opinion")]) {
            
            NSString *opinionString = @"";
            if (![self.fieldItemModel.valueString isEqualToString:self.myUserName]) {
                opinionString = self.fieldItemModel.valueString;
            }
            if ([self.delegate respondsToSelector:@selector(opinionViewClick:)]) {
                [self.delegate opinionViewClick:opinionString];
            }
            
            
            UITableViewCell *cell = [UITableViewCell getCellBy:superView];
            __weakSelf.currentEidtRegionIndex = [self.matterFormTableView indexPathForCell:cell].row;
            __weakSelf.currentEidtFieldItemIndex = superView.tag;
            
            if ([__weakSelf.delegate respondsToSelector:@selector(setCurrentEidtRegionIndex:currentEidtFieldItemIndex:infoRegionArray:)]) {
                [__weakSelf.delegate setCurrentEidtRegionIndex:__weakSelf.currentEidtRegionIndex currentEidtFieldItemIndex:__weakSelf.currentEidtFieldItemIndex infoRegionArray:self.infoRegionArray];
            }
        }
    };
}

/**
 不可编辑时的表单显示

 @param superView superView
 */
- (void)p_noEditShowSuperView:(UIView *)superView {
    
    if (self.fieldItemModel.nameVisible && self.fieldItemModel.nameRN) {
        
        CGFloat nameHeight = self.nameString.length>0 ? [NSString labelSizeWithMaxWidth:self.itemWidth-stringLeftWidth*2 content:self.nameString FontOfSize:self.formLabelFont].height+stringTopHeight*2 : 0;
        
        CGRect nameRect = CGRectMake(stringLeftWidth, 0, self.itemWidth-stringLeftWidth*2, nameHeight);
        HTMISupportCopyLabel *nameLabel = [HTMISupportCopyLabel creatLabelWithFrame:nameRect
                                                                               text:self.fieldItemModel.nameString
                                                                          alingment:self.fieldItemModel.alignString
                                                                          textColor:self.fieldItemModel.nameFontColor
                                                                           fontSize:self.formLabelFont];
//        [superView addSubview:nameLabel];
        
        if ([self.fieldItemModel.inputString isEqualToString:@"2001"] ||
            [self.fieldItemModel.inputString isEqualToString:@"2003"] ||
            [self.fieldItemModel.inputString isEqualToString:@"2004"]) {
            
            [self p_existOpnionAndAutographSuperView:superView];
            
        } else if ([self.fieldItemModel.inputString isEqualToString:@"2002"]) {
            
            [self p_existOpnionAndAutographSuperView:superView];
            
        }
    } else {
        if ([self.fieldItemModel.inputString isEqualToString:@"2001"] ||
            [self.fieldItemModel.inputString isEqualToString:@"2003"] ||
            [self.fieldItemModel.inputString isEqualToString:@"2004"]) {
            
            [self p_existOpnionAndAutographSuperView:superView];
            
        } else if ([self.fieldItemModel.inputString isEqualToString:@"2002"]) {

            [self p_existOpnionAndAutographSuperView:superView];
            
        }
    }
}

//已经存在的意见
- (CGFloat)p_existOpnionAndAutographSuperView:(UIView *)superView {
    __block CGFloat allheight = 0;
    
    [self.fieldItemModel.opintionArray enumerateObjectsUsingBlock:^(HTMIItemOpintionModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        HTMIItemOpintionModel *model = obj;
        
        CGFloat opinionHeight = [self getHeightWithString:model.opinionString];
        CGFloat nameHeight = [self getHeightWithString:model.userNameString];
        CGFloat timeHeight = [self getHeightWithString:model.saveTimeString];
        
        if ([self.fieldItemModel.inputString isEqualToString:@"2004"] &&
            (![self.fieldItemModel.modeString isEqual:[NSNull null]] &&
             [self.fieldItemModel.modeString isEqualToString:@"1"]) &&
            idx == self.fieldItemModel.opintionArray.count-1) {
            
            opinionHeight = opinionHeight+stringTopHeight*2;
            
            }
        
        {//意见内容
            CGRect opinionFrame = CGRectMake(stringLeftWidth,
                                             stringTopHeight+allheight,
                                             W(superView)-stringLeftWidth*2,
                                             opinionHeight);
            HTMISupportCopyLabel *opinionLabel = [HTMISupportCopyLabel creatLabelWithFrame:opinionFrame
                                                                                      text:model.opinionString
                                                                                 alingment:@"Left"
                                                                                 textColor:-16777216
                                                                                  fontSize:self.formLabelFont];
            [superView addSubview:opinionLabel];
            
            //2004 修改意见，变为可编辑，可点击
            opinionLabel.tag = superView.tag;
            if (idx == self.fieldItemModel.opintionArray.count-1) {
                [self opinionChangeEditWithOpinonLabel:opinionLabel];
            }
            
        }
        
        {//name
            CGFloat width = [NSString labelSizeWithMaxWidth:0
                                                    content:model.userNameString
                                                 FontOfSize:self.formLabelFont].width;
            CGRect nameframe = CGRectMake(stringLeftWidth,
                                          stringTopHeight+opinionHeight+allheight,
                                          MIN(width, self.itemWidth-stringLeftWidth*2),
                                          nameHeight);
            [self getUserNameLabelWithFrame:nameframe opinionModel:model superView:superView];
        }
        
        {//时间
            CGRect timeframe = CGRectMake(stringLeftWidth,
                                          stringTopHeight+opinionHeight+nameHeight+allheight,
                                          W(superView)-stringLeftWidth*2,
                                          timeHeight);
            HTMISupportCopyLabel *timeLabel = [HTMISupportCopyLabel creatLabelWithFrame:timeframe
                                                                                   text:model.saveTimeString
                                                                              alingment:@"Left"
                                                                              textColor:-16777216
                                                                               fontSize:self.formLabelFont];
            [superView addSubview:timeLabel];
        }
        
        CGFloat eachHeight = stringTopHeight + opinionHeight + nameHeight + timeHeight;
        
        allheight += eachHeight;
    }];
    
    return allheight;
}

/**
 高度
 */
- (CGFloat)getHeightWithString:(NSString *)string {
    CGFloat height = [NSString labelSizeWithMaxWidth:self.itemWidth-stringLeftWidth*2
                                                    content:string
                                                 FontOfSize:self.formLabelFont].height;
    return height;
}

/**
 已经存在的意见，修改意见类型时，意见label可编辑
 */
- (void)opinionChangeEditWithOpinonLabel:(HTMISupportCopyLabel *)label {
    
    if ([self.fieldItemModel.inputString isEqualToString:@"2004"] &&
        (![self.fieldItemModel.modeString isEqual:[NSNull null]] &&
         [self.fieldItemModel.modeString isEqualToString:@"1"])) {
            label.userInteractionEnabled = YES;
            label.layer.borderWidth = 1.0;
            label.layer.borderColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0].CGColor;
            label.layer.masksToBounds = YES;
            label.layer.cornerRadius = 2.0;
            
            if (self.fieldItemModel.mustInput) {
                label.backgroundColor = mustInputColor;
            }
            
            UITapGestureRecognizer *opinionLabelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(opinionViewTapClick:)];
            opinionLabelTap.delegate = self;
            [label addGestureRecognizer:opinionLabelTap];
            
    }
}

/**
 点击聊天 nameLabel
 */
- (void)getUserNameLabelWithFrame:(CGRect)frame opinionModel:(HTMIItemOpintionModel *)model superView:(UIView *)superView {
    HTMISupportCopyLabel *nameLabel = [HTMISupportCopyLabel creatLabelWithFrame:frame
                                                                           text:model.userNameString
                                                                      alingment:@"Left"
                                                                      textColor:-16777216
                                                                       fontSize:self.formLabelFont];
    nameLabel.userInteractionEnabled = YES;
    
    NSString *userId = [self getUserIdWithOpinionModel:model];
    NSString *loginUserId = [HTMIUserdefaultHelper defaultLoadUserID];
    //zzg
//    HTMISYS_UserModel * userModel = [[HTMIDBManager manager] getCurrentUserInfo:userId];
    if (userId.length > 0 &&
        //userModel.emi_type == 1 &&
        ![userId isEqualToString:loginUserId]
        ) {// && [[HTMIWorkFlowComponetManager manager].com_workflow_mobileconfig_IM_enabled isEqualToString:@"1"]
        
        if (kApplicationHue == HTMIApplicationHueWhite) {//白色色调
            nameLabel.textColor = eidtColor;
        } else {
            nameLabel.textColor = navBarColor;
        }
        
        //聊天
        {
            [self.opinionIdArray addObject:userId];
            nameLabel.tag = self.opinionIdIndex;
            
            self.opinionIdIndex += 1;
            
            UITapGestureRecognizer *nameTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nameTapClick:)];
            nameTap.delegate = self;
            [nameLabel addGestureRecognizer:nameTap];
        }
        
    } else{
        nameLabel.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0];
    }
    
    [superView addSubview:nameLabel];
}

/**
 获取userId
 */
- (NSString *)getUserIdWithOpinionModel:(HTMIItemOpintionModel *)model {
    NSString *userId = nil;
    if (model.userIDString.length > 0) {
        userId = model.userIDString;
    } else {
        NSArray *autoArray = [model.userNameString componentsSeparatedByString:@"("];
        
        if (autoArray.count < 1) {
            return nil;
        }
        
        //zzg
//        HTMISYS_UserModel *sys_userModel;
//        NSArray *resultArray = [[HTMIDBManager manager] searchUsersBySearchString:[autoArray firstObject] inDepartment:@""];
//        for (HTMISYS_UserModel *object in resultArray) {
//            sys_userModel = object;
//            break;
//        }
//        userId = sys_userModel.user_id;
    }
    
    return userId;
}

- (void)nameLabel:(UIView *)superView nameHeight:(CGFloat)nameHeight {
    CGRect nameRect = CGRectMake(stringLeftWidth, 0, self.itemWidth-stringLeftWidth*2, nameHeight);
    HTMISupportCopyLabel *nameLabel = [HTMISupportCopyLabel creatLabelWithFrame:nameRect
                                                                           text:self.fieldItemModel.nameString
                                                                      alingment:self.fieldItemModel.alignString
                                                                      textColor:self.fieldItemModel.nameFontColor
                                                                       fontSize:self.formLabelFont];
    [superView addSubview:nameLabel];
    
}

- (void)opinionViewTapClick:(UITapGestureRecognizer *)tap {
    UITableViewCell *cell = [UITableViewCell getCellBy:tap.view];
    self.currentEidtRegionIndex = [self.matterFormTableView indexPathForCell:cell].row;
    self.currentEidtFieldItemIndex = tap.view.tag;
    
    if ([self.delegate respondsToSelector:@selector(setCurrentEidtRegionIndex:currentEidtFieldItemIndex:infoRegionArray:)]) {
        [self.delegate setCurrentEidtRegionIndex:self.currentEidtRegionIndex currentEidtFieldItemIndex:self.currentEidtFieldItemIndex infoRegionArray:self.infoRegionArray];
    }
    
    HTMIRegionCellModel *infoRegion = self.infoRegionArray[self.currentEidtRegionIndex];
    HTMIFieldItemModel *fieldItem = infoRegion.fieldItemArray[self.currentEidtFieldItemIndex];
    
    
    
    NSString *opinionString = @"";
    if ([fieldItem.inputString isEqualToString:@"2004"]) {
        opinionString = ((HTMIItemOpintionModel *)[fieldItem.opintionArray firstObject]).opinionString;
    } else {
        opinionString = fieldItem.valueString;
    }

    if ([self.delegate respondsToSelector:@selector(opinionViewClick:)]) {
        [self.delegate opinionViewClick:opinionString];
    }
}


//签名点击事件
-(void)autographTap:(UITapGestureRecognizer *)tap {
    NSInteger currentEidtFieldItemIndex = tap.view.tag;
    HTMIFieldItemModel *fieldItem;
    
    UITableViewCell *cell = [UITableViewCell getCellBy:tap.view];
    
    
    NSInteger currentEidtRegionIndex = [self.matterFormTableView indexPathForCell:cell].row;
    HTMIRegionCellModel *infoRegion = self.infoRegionArray[currentEidtRegionIndex];
    fieldItem = infoRegion.fieldItemArray[currentEidtFieldItemIndex];
    
    fieldItem.valueString = self.myUserName;
    fieldItem.isShowMustInputWarning = NO;
    
    //zzg
//    NSString *attribute = @"";//[[HTMIUserdefaultHelper defaultLoadContext] objectForKey:@"attribute1"]
//    NSString *oa_user_id = [HTMILoginUserModel shareLoginUserModel].userID;
//    NSString *oa_user_name = [HTMILoginUserModel shareLoginUserModel].userName;
//    NSString *departmentName = [HTMILoginUserModel shareLoginUserModel].thirdDepartmentName;
//
//    NSString *writeString = nil;
//    if (attribute.length < 1) {
//        if ([departmentName isEqual:[NSNull null]] || departmentName.length < 1) {
//            writeString = [NSString stringWithFormat:@"%@#%@#2",oa_user_id,oa_user_name];
//        } else {
//            writeString = [NSString stringWithFormat:@"%@#%@(%@)#2",oa_user_id,oa_user_name,departmentName];
//        }
//
//    } else {
//        writeString = [NSString stringWithFormat:@"%@#%@#1",oa_user_id,@""];//[[HTMIUserdefaultHelper defaultLoadContext] objectForKey:@"attribute1"]
//    }
//    [self.delegate editValueChangeKey:fieldItem.keyString
//                                value:writeString
//                                 mode:fieldItem.modeString
//                            inputType:fieldItem.inputString
//                              formKey:fieldItem.formkeyString
//                                isExt:fieldItem.is_ext
//                            eventType:[NSString stringWithFormat:@"%@",fieldItem.ajaxEventModel.eventType]
//     fieldItemModel:fieldItem];
//    [self.matterFormTableView reloadData];
}

/**
 *  意见中姓名点击进入聊天事件
 *
 *  @param nameTap UITapGestureRecognizer
 */
- (void)nameTapClick:(UITapGestureRecognizer *)nameTap {
    
    NSString * userId = self.opinionIdArray[nameTap.view.tag];
    //应该将id转换成loginname
    //zzg
//    HTMISYS_UserModel * userModel = [[HTMIDBManager manager] getCurrentUserInfo:userId];
//    NSString * loginNameString = [userModel.login_name copy];
//    NSArray *userArr = @[loginNameString == nil ? @"":loginNameString];
//    [[HTMIWorkFlowComponetManager manager] chat:userArr withViewController:self.controller];
}

#pragma mark ------ 懒加载
- (NSMutableArray *)opinionIdArray {
    if (!_opinionIdArray) {
        _opinionIdArray = [NSMutableArray array];
    }
    return _opinionIdArray;
}

- (NSMutableArray *)autographNameArray {
    if (!_autographNameArray) {
        _autographNameArray = [NSMutableArray array];
    }
    
    return _autographNameArray;
}


#pragma mark ------ 互联网表单样式
- (void)networkFormOpnionAndAutograph:(UIView *)totalView {
    
    CGRect tempRect = CGRectMake(0, 0, self.itemWidth, self.cellHeight);
    typeof(self) __weakSelf = self;
    
    if ((![self.fieldItemModel.modeString isEqual:[NSNull null]] && [self.fieldItemModel.modeString isEqualToString:@"1"])) {
        
        if ([self.fieldItemModel.inputString isEqualToString:@"2001"]) {//意见（添加）
            
            HTMINetWorkOpnionView *opinionView = [[HTMINetWorkOpnionView alloc] initWithFrame:tempRect
                                                                                    fieldItem:self.fieldItemModel
                                                                                     textFont:self.formLabelFont];
            [totalView addSubview:opinionView];
            
            opinionView.editEndBlock = ^(NSString *string) {
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
            
            
        } else if ([self.fieldItemModel.inputString isEqualToString:@"2002"]) {//签名
            
            [self netWorkAutographBySuperView:totalView];
            
        } else if ([self.fieldItemModel.inputString isEqualToString:@"2003"]) {//意见或签名
            
            HTMINetWorkOpnionView *opinionView = [[HTMINetWorkOpnionView alloc] initWithFrame:tempRect
                                                                                    fieldItem:self.fieldItemModel
                                                                                     textFont:self.formLabelFont];
            [totalView addSubview:opinionView];
            
            opinionView.editEndBlock = ^(NSString *string) {
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
            
        } else if ([self.fieldItemModel.inputString isEqualToString:@"2004"]) {//意见（修改）
            
            HTMINetWorkChangeOpinionView *changeOpinionView = [[HTMINetWorkChangeOpinionView alloc] initWithFrame:tempRect fieldItem:self.fieldItemModel textFont:self.formLabelFont];
            [totalView addSubview:changeOpinionView];
            
            changeOpinionView.editEndBlock = ^(NSString *string) {
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
            
        }
        
    } else {//不可编辑时
        
        if (self.fieldItemModel.nameVisible) {
            CGFloat nameHeight = self.nameString.length>0 ? [NSString labelSizeWithMaxWidth:self.itemWidth-stringLeftWidth*2 content:self.nameString FontOfSize:self.formLabelFont].height+stringTopHeight*2 : 0;
            HTMISupportCopyLabel *nameLabel = [HTMISupportCopyLabel creatLabelWithFrame:CGRectMake(stringLeftWidth, 0, self.itemWidth-stringLeftWidth*2, nameHeight)
                                                                                   text:self.fieldItemModel.nameString
                                                                              alingment:self.fieldItemModel.alignString
                                                                              textColor:self.fieldItemModel.nameFontColor
                                                                               fontSize:self.formLabelFont];
            [totalView addSubview:nameLabel];
            
            if ([self.fieldItemModel.inputString isEqualToString:@"2001"] || [self.fieldItemModel.inputString isEqualToString:@"2003"] || [self.fieldItemModel.inputString isEqualToString:@"2004"]) {
                
                [self p_existOpnionAndAutographSuperView:totalView];
                
            } else if ([self.fieldItemModel.inputString isEqualToString:@"2002"]) {
                [self p_existOpnionAndAutographSuperView:totalView];
            }
        } else {
            if ([self.fieldItemModel.inputString isEqualToString:@"2001"] || [self.fieldItemModel.inputString isEqualToString:@"2003"] || [self.fieldItemModel.inputString isEqualToString:@"2004"]) {
                [self p_existOpnionAndAutographSuperView:totalView];
                
            } else if ([self.fieldItemModel.inputString isEqualToString:@"2002"]) {
                [self p_existOpnionAndAutographSuperView:totalView];
            }
        }
    }
}

/**
 *  互联网表单签名
 */
- (void)netWorkAutographBySuperView:(UIView *)superView {
    
    CGRect valueRect = CGRectMake(0, 0, self.itemWidth, self.cellHeight);
    
    if (self.fieldItemModel.nameVisible) {
        //显示 name，固定 30% 长度
        CGRect nameRect = CGRectMake(stringLeftWidth, 0, kScreenWidth*0.3-stringLeftWidth*2, self.cellHeight);
        HTMISupportCopyLabel *namelabel = [HTMISupportCopyLabel creatLabelWithFrame:nameRect
                                                                               text:self.nameString
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
    arrowImageView.image = [UIImage imageNamed:@"icon_editeImage"];
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
    UITapGestureRecognizer *borderViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(autographTap:)];
    [valuelabel addGestureRecognizer:borderViewTap];
    
}

#pragma mark - HTMIQuickOpinionViewControllerDelegate
- (void)quickOpinion:(NSString *)opinion {
    
}


@end
