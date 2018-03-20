//
//  HTMITextField.m
//  CustomInputView
//
//  Created by wlq on 16/7/11.
//  Copyright © 2016年 wlq. All rights reserved.
//

#import "HTMITextField.h"

@implementation HTMITextField

/**
 *  禁止复制粘贴
 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
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
