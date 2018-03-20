//
//  HTMINetWorkChangeOpinionView.m
//  MXClient
//
//  Created by 赵志国 on 2017/9/7.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import "HTMINetWorkChangeOpinionView.h"

#import "HTMISupportCopyLabel.h"

#import "HTMIFormComponentHeader.h"

//#import "HTMIMatterFormModel.h"

#import "HTMITabFormModel.h"

#import "UIFont+HTMIFont.h"

@interface HTMINetWorkChangeOpinionView ()<UITextViewDelegate>

@property (nonatomic, strong) HTMIFieldItemModel *fieldItem;

@property (nonatomic, strong) HTMISupportCopyLabel *nameLabel;

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, assign) CGFloat labelFont;

/**
 弹出键盘后底部蓝色线条
 */
@property (nonatomic, strong) UIImageView *bottomLineImageView;

@property (nonatomic, copy) NSString *opinionString;

@end

@implementation HTMINetWorkChangeOpinionView

- (instancetype)initWithFrame:(CGRect)frame
                    fieldItem:(HTMIFieldItemModel *)fieldItem
                     textFont:(CGFloat)textFont {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.fieldItem = fieldItem;
        self.labelFont = textFont;
        CGFloat nameHeight = 0;
        
        if (fieldItem.nameVisible) {//显示 name
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
        
        HTMIItemOpintionModel *model = [self.fieldItem.opintionArray lastObject];
        
        self.opinionString = model.opinionString;
        NSString *nameString = model.userNameString;
        NSString *timeString = model.saveTimeString;
        
        CGRect textViewRect = CGRectMake(stringLeftWidth, nameHeight, W(self)-stringLeftWidth*2, 90);
        self.textView = [[UITextView alloc] initWithFrame:textViewRect];
        self.textView.font = [UIFont systemFontOfSize:textFont];
        self.textView.delegate = self;
        self.textView.text = [NSString stringWithFormat:@"%@\n%@\n%@",self.opinionString,nameString,timeString];
        self.textView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.textView];
        
        //必填
        BOOL isMustinput = [fieldItem isMustInput:fieldItem.mustInput value:fieldItem.valueString];
        if (isMustinput) {
            self.textView.text = @"(必填)";
            self.textView.textColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
        }
        
        [self addSubview:self.bottomLineImageView];
        
    }
    return self;
}

#pragma mark ------ UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    return YES;
}


- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.bottomLineImageView.hidden = NO;
    self.nameLabel.textColor = [UIColor colorWithRed:41/255.0 green:123/255.0 blue:251/255.0 alpha:1.0];
    
    textView.text = self.opinionString;
}


- (void)textViewDidEndEditing:(UITextView *)textView {
    self.bottomLineImageView.hidden = YES;
    self.nameLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    
    self.opinionString = textView.text;
    
    self.editEndBlock(textView.text);
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
