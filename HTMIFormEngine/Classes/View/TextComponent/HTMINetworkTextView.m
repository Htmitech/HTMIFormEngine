//
//  HTMINetworkTextView.m
//  MXClient
//
//  Created by 赵志国 on 2017/8/29.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import "HTMINetworkTextView.h"

#import "HTMIFormComponentHeader.h"

#import "HTMISupportCopyLabel.h"

#import "Masonry.h"

#import "NSString+HTMISize.h"

#import "HTMIUserdefaultHelper.h"
//#import "HTMIDBManager.h"
//#import "HTMISYS_UserModel.h"
//#import "HTMIWorkFlowComponetManager.h"
#import "HTMISettingManager.h"

#import "UIFont+HTMIFont.h"


@interface HTMINetworkTextView ()<UITextViewDelegate>

/**
 请假申请，意见等标识
 */
@property (nonatomic, strong) HTMISupportCopyLabel *nameLabel;

/**
 弹出键盘后底部蓝色线条
 */
@property (nonatomic, strong) UIImageView *bottomLineImageView;

/**
 大文本
 */
@property (nonatomic, strong) UITextView *textView;

/**
 字体大小
 */
@property (nonatomic, assign) CGFloat textFont;

@property (nonatomic, assign) BOOL mustInput;
@end

@implementation HTMINetworkTextView

- (instancetype)initWithFrame:(CGRect)frame
                   nameString:(NSString *)nameString
                  valueString:(NSString *)valueString
                  isMustInput:(BOOL)isMustInput
                     textFont:(CGFloat)textFont{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.textFont = textFont;
        _mustInput = isMustInput;
        
        if (nameString.length > 0) {
            [self initNameLabel:nameString];
        }
        
        [self addSubview:self.bottomLineImageView];
        
        [self initTextView:valueString];

        if (valueString.length <= 0 && isMustInput) {
            self.textView.text = @"(必填)";
            self.textView.textColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
        }
    }
    return self;
}

#pragma mark ------ UI
- (void)initNameLabel:(NSString *)nameString  {
    self.nameLabel = [[HTMISupportCopyLabel alloc] init];
    self.nameLabel.text = nameString;
    self.nameLabel.font = [UIFont htmi_systemFontOfSize:self.textFont];
    self.nameLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    self.nameLabel.userInteractionEnabled = YES;
    [self addSubview:self.nameLabel];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(stringLeftWidth);
        make.right.equalTo(self).offset(-stringLeftWidth);
        make.top.equalTo(self);
        make.height.mas_equalTo(50);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nameLabelClick)];
    [self.nameLabel addGestureRecognizer:tap];
}


- (void)initTextView:(NSString *)valueString {
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(stringLeftWidth, 40, W(self)-stringLeftWidth*2, 90)];
    self.textView.font = [UIFont systemFontOfSize:self.textFont];
    self.textView.delegate = self;
    self.textView.text = valueString;
    self.textView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.textView];
}

#pragma mark ------ UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    return YES;
}


- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.bottomLineImageView.hidden = NO;
    self.nameLabel.textColor = [UIColor colorWithRed:41/255.0 green:123/255.0 blue:251/255.0 alpha:1.0];
    
    if ([textView.text isEqualToString:@"(必填)"]) {
        self.textView.text = @"";
        self.textView.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0];
    } else {
        self.textView.text = textView.text;
        self.textView.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    self.bottomLineImageView.hidden = YES;
    self.nameLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    
    self.editEndBlock(textView.text);
    
    if (textView.text.length <= 0 && self.mustInput) {
        self.textView.text = @"(必填)";
        self.textView.textColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
    }
}

#pragma mark ------ 事件
- (void)nameLabelClick {
    [self.textView becomeFirstResponder];
}

#pragma mark ------ 懒加载
- (UIImageView *)bottomLineImageView {
    if (!_bottomLineImageView) {
        _bottomLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(stringLeftWidth, 138, W(self)-stringLeftWidth, 2)];
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
