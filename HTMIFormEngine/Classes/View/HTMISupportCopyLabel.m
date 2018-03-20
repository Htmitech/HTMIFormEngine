//
//  HTMISupportCopyLabel.m
//  MXClient
//
//  Created by wlq on 2017/6/9.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import "HTMISupportCopyLabel.h"

#import "UIColor+Hex.h"

//#import "NSString+Extention.h"

#import "HTMIFormComponentHeader.h"

//#import "HTMIMatterFormModel.h"

#import "UIFont+HTMIFont.h"

#import "HTMITabFormModel.h"

@interface HTMISupportCopyLabel ()<UIGestureRecognizerDelegate>

@end

@implementation HTMISupportCopyLabel

+ (void)inputNoEditFieldItem:(HTMIFieldItemModel *)fieldItem nameString:(NSString *)nameString valueString:(NSString *)valueString width:(CGFloat)width cellHeight:(CGFloat)cellHeight superView:(UIView *)superView fontSize:(CGFloat)fontSize {
    if (fieldItem.nameVisible) {
        HTMISupportCopyLabel *allLabel = [HTMISupportCopyLabel creatLabelWithFrame:CGRectMake(stringLeftWidth, 0, width, cellHeight) text:[NSString stringWithFormat:@"%@%@",nameString,valueString] alingment:fieldItem.alignString textColor:fieldItem.nameFontColor fontSize:fontSize];
        [superView addSubview:allLabel];
    } else {
        HTMISupportCopyLabel *allLabel = [HTMISupportCopyLabel creatLabelWithFrame:CGRectMake(stringLeftWidth, 0, width, cellHeight) text:valueString alingment:fieldItem.alignString textColor:fieldItem.valueFontColor fontSize:fontSize];
        [superView addSubview:allLabel];
    }
}

#pragma mark  ------ 不可编辑时的namelabel  or  valuelabel
+ (HTMISupportCopyLabel *)creatLabelWithFrame:(CGRect)frame text:(NSString *)text alingment:(NSString *)alignment textColor:(NSInteger)textColor fontSize:(CGFloat)fontSize {
    HTMISupportCopyLabel *label = [[HTMISupportCopyLabel alloc] initWithFrame:frame];
    label.text = text;
    label.textAlignment = [self alignmentWithString:alignment];
    label.font = [UIFont htmi_systemFontOfSize:fontSize];
    label.numberOfLines = 0;
    label.adjustsFontSizeToFitWidth = YES;
    label.userInteractionEnabled = YES;
    label.textColor = [UIColor colorWithHex:[NSString stringWithFormat:@"%x",(int)textColor] alpha:1.0f isWhite:0];
    
    return label;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self pressAction];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self pressAction];
    }
    return self;
}

// 初始化设置
- (void)pressAction {
    self.userInteractionEnabled = YES;
    [self setMultipleTouchEnabled:YES];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    longPress.minimumPressDuration = 1;
    longPress.cancelsTouchesInView = YES;
    longPress.delegate = self;
    [self addGestureRecognizer:longPress];
}

// 使label能够成为响应事件
- (BOOL)canBecomeFirstResponder {
    return YES;
}

//// 控制响应的方法
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    
    if (menuController) {
        
        if(action ==@selector(customCopy:)
           ) {
            
            return [super canPerformAction:action withSender:sender];//
        }
    }
    
    return NO;
}

- (void)customCopy:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.text;
}

- (void)longPressAction:(UIGestureRecognizer *)recognizer {
    
    [self becomeFirstResponder];
    UIMenuItem *copyItem = [[UIMenuItem alloc] initWithTitle:@"拷贝" action:@selector(customCopy:)];
    
    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:copyItem,nil]];
    [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
}

//允许多手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

#pragma mark  ------ 对齐方式
+ (NSTextAlignment)alignmentWithString:(NSString *)string {
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

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    return [super hitTest:point withEvent:event];
//}

//UIResponderStandardEditActions：这是苹果给NSObject写的一个分类，其中包含了我们常用的复制，粘贴，全选等方法
//- (void)cut:(nullable id)sender  NS_AVAILABLE_IOS(3_0);
//- (void)copy:(nullable id)sender  NS_AVAILABLE_IOS(3_0);
//- (void)paste:(nullable id)sender  NS_AVAILABLE_IOS(3_0);
//- (void)select:(nullable id)sender  NS_AVAILABLE_IOS(3_0);
//- (void)selectAll:(nullable id)sender  NS_AVAILABLE_IOS(3_0);
//- (void)delete:(nullable id)sender   NS_AVAILABLE_IOS(3_2);

/*
 // 重写label的textRectForBounds方法
 - (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
 CGRect rect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
 
 switch (self.textAlignmentType) {
 case WZBTextAlignmentTypeLeftTop: {
 rect.origin = bounds.origin;
 }
 break;
 case WZBTextAlignmentTypeRightTop: {
 rect.origin = CGPointMake(CGRectGetMaxX(bounds) - rect.size.width, bounds.origin.y);
 }
 break;
 case WZBTextAlignmentTypeLeftBottom: {
 rect.origin = CGPointMake(bounds.origin.x, CGRectGetMaxY(bounds) - rect.size.height);
 }
 break;
 case WZBTextAlignmentTypeRightBottom: {
 rect.origin = CGPointMake(CGRectGetMaxX(bounds) - rect.size.width, CGRectGetMaxY(bounds) - rect.size.height);
 }
 break;
 case WZBTextAlignmentTypeTopCenter: {
 rect.origin = CGPointMake((CGRectGetWidth(bounds) - CGRectGetWidth(rect)) / 2, CGRectGetMaxY(bounds) - rect.origin.y);
 }
 break;
 case WZBTextAlignmentTypeBottomCenter: {
 rect.origin = CGPointMake((CGRectGetWidth(bounds) - CGRectGetWidth(rect)) / 2, CGRectGetMaxY(bounds) - CGRectGetMaxY(bounds) - rect.size.height);
 }
 break;
 case WZBTextAlignmentTypeLeft: {
 rect.origin = CGPointMake(0, rect.origin.y);
 }
 break;
 case WZBTextAlignmentTypeRight: {
 rect.origin = CGPointMake(rect.origin.x, 0);
 }
 break;
 case WZBTextAlignmentTypeCenter: {
 rect.origin = CGPointMake((CGRectGetWidth(bounds) - CGRectGetWidth(rect)) / 2, (CGRectGetHeight(bounds) - CGRectGetHeight(rect)) / 2);
 }
 break;
 
 default:
 break;
 }
 return rect;
 }
 
 - (void)drawTextInRect:(CGRect)rect {
 CGRect textRect = [self textRectForBounds:rect limitedToNumberOfLines:self.numberOfLines];
 [super drawTextInRect:textRect];
 }
 */

@end
