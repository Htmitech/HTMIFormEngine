//
//  HTMITextView.m
//  自定义输入框
//
//  Created by wlq on 16/7/8.
//  Copyright © 2016年 htmitech.com. All rights reserved.
//

#import "HTMITextView.h"
#import "UIView+Extension.h"

#import "UIFont+HTMIFont.h"

@interface HTMITextView()

/**UILabel*/
@property (nonatomic, strong) UILabel *placeholderLabel;

@end

@implementation HTMITextView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.alwaysBounceVertical = YES;
        self.textColor = [UIColor blackColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(texting) name:UITextViewTextDidChangeNotification object:self];
        self.suportCopyAndPast = YES;
    }
    return self;
}

/**
 *  设置自己的属性
 */
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.alwaysBounceVertical = YES;
        self.textColor = [UIColor blackColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(texting) name:UITextViewTextDidChangeNotification object:self];
        self.suportCopyAndPast = YES;

        //        [self addObserver:self forKeyPath:@"contentSize" options:(NSKeyValueObservingOptionNew) context:NULL];
    }
    return self;
}

/*
 //如果设为居中，需要利用属性监听来垂直居中
 #pragma mark - KVO
 -(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void *)context
 {
 HTMITextView *tv = object;
 
 if (tv.textAlignment == NSTextAlignmentCenter) {
 // Center vertical alignment
 CGFloat topCorrect = ([tv bounds].size.height - [tv contentSize].height * [tv zoomScale])/2.0;
 topCorrect = ( topCorrect < 0.0 ? 0.0 : topCorrect );
 tv.contentOffset = (CGPoint){.x = 0, .y = -topCorrect};
 }
 }*/


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.placeholderLabel.x = 20;
    self.placeholderLabel.y = 13;
    self.placeholderLabel.width = self.width - 2 * self.placeholderLabel.x;
    [self.placeholderLabel sizeToFit];//这一步很重要，不能遗忘
}

#pragma mark - 事件

/**
 *  监听有文字输入
 */
-(void)texting
{
    [self setPlaceholderTextShow];
}

#pragma mark - 私有方法

/**
 *  设置占位文字的显示
 */
-(void)setPlaceholderTextShow
{
    self.placeholderLabel.hidden = self.hasText;
}

#pragma mark - Getters And Setters
/**
 *  懒加载属性，并设置属性的值
 */
-(UILabel *)placeholderLabel
{
    if (!_placeholderLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont htmi_systemFontOfSize:14];
        label.textColor = [UIColor grayColor];
        label.numberOfLines = 0;
        _placeholderLabel = label;
        
        [self addSubview:_placeholderLabel];
    }
    return _placeholderLabel;
}

-(void)setPlaceholder:(NSString *)placeholder
{
    self.placeholderLabel.text = placeholder;
    [self setNeedsLayout];
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    self.placeholderLabel.textColor = placeholderColor;
    [self setNeedsLayout];
}

-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    [self setNeedsLayout];
}

-(void)setText:(NSString *)text
{
    [super setText:text];
    [self setPlaceholderTextShow];
    [self setNeedsLayout];
}

-(void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self setPlaceholderTextShow];
    [self setNeedsLayout];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    
    if (menuController) {
        //[UIMenuController sharedMenuController].menuVisible = NO;
        
        if (self.isSuportCopyAndPast) {
            
            if(action ==@selector(copy:) ||
               action ==@selector(selectAll:)||
               action ==@selector(cut:)||
               action ==@selector(select:)||
               action ==@selector(paste:)) {
                
                return [super canPerformAction:action withSender:sender];//
            }
        }
    }
    
    return NO;
}

@end
