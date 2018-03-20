//
//  HTMINetWorkOpnionView.m
//  MXClient
//
//  Created by 赵志国 on 2017/9/6.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import "HTMINetWorkOpnionView.h"

#import "HTMISupportCopyLabel.h"

#import "NSString+HTMISize.h"

#import "HTMIFormComponentHeader.h"

#import "HTMIUserdefaultHelper.h"
//#import "HTMIDBManager.h"
//#import "HTMISYS_UserModel.h"
//#import "HTMIWorkFlowComponetManager.h"
#import "HTMISettingManager.h"

//#import "HTMIMatterFormModel.h"

#import "UIFont+HTMIFont.h"

//#import "HTMILoginUserModel.h"

#import "HTMIConstString.h"

#import "HTMITabFormModel.h"

@interface HTMINetWorkOpnionView ()<UITextViewDelegate>

@property (nonatomic, strong) HTMIFieldItemModel *fieldItem;

@property (nonatomic, assign) CGFloat labelFont;

@property (nonatomic, strong) HTMISupportCopyLabel *nameLabel;

@property (nonatomic, strong) UITextView *textView;

/**
 弹出键盘后底部蓝色线条
 */
@property (nonatomic, strong) UIImageView *bottomLineImageView;

@end

@implementation HTMINetWorkOpnionView


- (instancetype)initWithFrame:(CGRect)frame
                    fieldItem:(HTMIFieldItemModel *)fieldItem
                     textFont:(CGFloat)textFont {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.fieldItem = fieldItem;
        self.labelFont = textFont;
        CGFloat nameHeight = 0;
        
        if (fieldItem.nameVisible || [fieldItem.inputString isEqualToString:@"2003"]) {//显示 name
            nameHeight = 40;
            
        } else {//不显示 name
            
        }
        
        CGRect nameRect = CGRectMake(stringLeftWidth, 0, kScreenWidth-100, nameHeight);
        self.nameLabel = [[HTMISupportCopyLabel alloc] initWithFrame:nameRect];
        self.nameLabel.text = fieldItem.nameString;
        self.nameLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        self.nameLabel.font = [UIFont htmi_systemFontOfSize:textFont];
        self.nameLabel.userInteractionEnabled = YES;
        [self addSubview:self.nameLabel];
        
        CGFloat opinionHeight = [self opnionExistentNameHeight:nameHeight];
        
        CGRect textViewRect = CGRectMake(stringLeftWidth, nameHeight+opinionHeight, W(self)-stringLeftWidth*2, 90);
        self.textView = [[UITextView alloc] initWithFrame:textViewRect];
        self.textView.font = [UIFont systemFontOfSize:textFont];
        self.textView.delegate = self;
        self.textView.text = fieldItem.valueString;
        self.textView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.textView];
        
        //必填
        BOOL isMustinput = [fieldItem isMustInput:fieldItem.mustInput value:fieldItem.valueString];
        if (isMustinput) {
            self.textView.text = @"(必填)";
            self.textView.textColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
        }
        
        [self addSubview:self.bottomLineImageView];
        
        if ([fieldItem.inputString isEqualToString:@"2003"]) {
            UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(W(self)-30, 10, 20, 20)];
            arrowImageView.image = [UIImage imageNamed:@"icon_editeImage"];
            [self addSubview:arrowImageView];
            
            self.nameLabel.tag = self.tag;
            UITapGestureRecognizer *borderViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(autographTap:)];
            [self.nameLabel addGestureRecognizer:borderViewTap];
        }
    }
    return self;
}


//已经存在的意见
- (CGFloat)opnionExistentNameHeight:(CGFloat)nameHeight {
    CGFloat allheight = 0;
    
    for (int i = 0; i < self.fieldItem.opintionArray.count; i++) {
        HTMIItemOpintionModel *model = self.fieldItem.opintionArray[i];
        
        NSString *opinion = ((NSString *)model.opinionString).length>0 ? model.opinionString : @" ";
        NSString *name = model.userNameString;
        NSString *time = model.saveTimeString;
        
        CGFloat opinionHeight = [NSString labelSizeWithMaxWidth:W(self)-stringLeftWidth*2 content:opinion FontOfSize:self.labelFont].height;
        CGFloat nameHeight = [NSString labelSizeWithMaxWidth:W(self)-stringLeftWidth*2 content:name FontOfSize:self.labelFont].height;
        CGFloat timeHeight = [NSString labelSizeWithMaxWidth:W(self)-stringLeftWidth*2 content:time FontOfSize:self.labelFont].height;
        
        CGRect opinionFrame =CGRectMake(stringLeftWidth,
                                        stringTopHeight+allheight+nameHeight,
                                        W(self)-stringLeftWidth*2,
                                        opinionHeight);
        HTMISupportCopyLabel *opinionLabel = [HTMISupportCopyLabel creatLabelWithFrame:opinionFrame text:opinion alingment:@"Left" textColor:-16777216 fontSize:self.labelFont];
        [self addSubview:opinionLabel];
        
        CGRect nameframe = CGRectMake(stringLeftWidth,
                                      stringTopHeight+opinionHeight+allheight+nameHeight,
                                      [NSString labelSizeWithMaxWidth:0 content:name FontOfSize:self.labelFont].width,
                                      nameHeight);
        HTMISupportCopyLabel *nameLabel = [HTMISupportCopyLabel creatLabelWithFrame:nameframe text:name alingment:@"Left" textColor:-16777216 fontSize:self.labelFont];
        nameLabel.userInteractionEnabled = YES;
        
        NSString *userId = model.userIDString;
        NSString *loginUserId = [HTMIUserdefaultHelper defaultLoadUserID];
        //zzg
//        HTMISYS_UserModel *userModel = [[HTMIDBManager manager] getCurrentUserInfo:userId];
//        if ([[HTMIWorkFlowComponetManager manager].com_workflow_mobileconfig_IM_enabled isEqualToString:@"1"] &&
//            userId.length > 0 &&
//            (userModel.emi_type == 1) &&
//            ![userId isEqualToString:loginUserId]) {
//            if (kApplicationHue == HTMIApplicationHueWhite) {//白色色调
//                nameLabel.textColor = eidtColor;
//            } else {
//                nameLabel.textColor = navBarColor;
//            }
//        }
//        else {
//            nameLabel.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0];
//        }
        
        [self addSubview:nameLabel];
        
        CGRect timeframe = CGRectMake(stringLeftWidth,
                                      stringTopHeight+opinionHeight+nameHeight+allheight+nameHeight,
                                      W(self)-stringLeftWidth*2,
                                      timeHeight);
        HTMISupportCopyLabel *timeLabel = [HTMISupportCopyLabel creatLabelWithFrame:timeframe text:time alingment:@"Left" textColor:-16777216 fontSize:self.labelFont];
        [self addSubview:timeLabel];
        
        CGFloat eachHeight = stringTopHeight + opinionHeight + nameHeight + timeHeight;
        
        allheight += eachHeight;
        
        //zzg
        //聊天
//        if (userId.length > 0 &&
//            userModel.emi_type == 1 &&
//            [[HTMIWorkFlowComponetManager manager].com_workflow_mobileconfig_IM_enabled isEqualToString:@"1"] &&
//            ![userId isEqualToString:loginUserId]) {
//
////            [self.opinionIdArray addObject:[dic objectForKey:@"UserID"]];
////            nameLabel.tag = self.opinionIdIndex;
////
////            self.opinionIdIndex += 1;
//
//            UITapGestureRecognizer *nameTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nameTapClick:)];
//            [nameLabel addGestureRecognizer:nameTap];
//        }
    }
    
    return allheight;
}

#pragma mark ------ UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    return YES;
}


- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.bottomLineImageView.hidden = NO;
    self.nameLabel.textColor = [UIColor colorWithRed:41/255.0 green:123/255.0 blue:251/255.0 alpha:1.0];
}


- (void)textViewDidEndEditing:(UITextView *)textView {
    self.bottomLineImageView.hidden = YES;
    self.nameLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    
    self.editEndBlock(textView.text);
}

#pragma mark ------ 事件
- (void)nameTapClick:(UITapGestureRecognizer *)tap {
    
}

- (void)autographTap:(UITapGestureRecognizer *)tap {
    
    NSString *myUserName = [[NSUserDefaults standardUserDefaults] objectForKey:kHTMI_User_Name];

    self.textView.text = myUserName;

    self.editEndBlock(myUserName);
}

#pragma mark ------ 懒加载
- (UIImageView *)bottomLineImageView {
    if (!_bottomLineImageView) {
        _bottomLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(stringLeftWidth, H(self)-2, W(self)-stringLeftWidth, 2)];
        _bottomLineImageView.backgroundColor = [UIColor colorWithRed:41/255.0 green:123/255.0 blue:251/255.0 alpha:1.0];
        _bottomLineImageView.hidden = YES;
    }
    return _bottomLineImageView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
