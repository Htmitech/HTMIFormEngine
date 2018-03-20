//
//  UIView+PrintSubviews.m
//  MXClient
//
//  Created by wlq on 16/5/22.
//  Copyright © 2016年 MXClient. All rights reserved.
//

#import "UIView+PrintSubviews.h"

@implementation UIView (PrintSubviews)

- (void)printSubviewsWithIndentation:(int)indentation {
    
    NSArray *subviews = [self subviews];
    
    for (int i = 0; i < [subviews count]; i++) {
        
        UIView *currentSubview = [subviews objectAtIndex:i];
        NSMutableString *currentViewDescription = [[NSMutableString alloc] init];
        
        for (int j = 0; j <= indentation; j++) {
            [currentViewDescription appendString:@"   "];
        }
        
        [currentViewDescription appendFormat:@"[%d]: class: '%@', frame=(%.1f, %.1f, %.1f, %.1f), opaque=%i, hidden=%i, userInterfaction=%i", i, NSStringFromClass([currentSubview class]), currentSubview.frame.origin.x, currentSubview.frame.origin.y, currentSubview.frame.size.width, currentSubview.frame.size.height, currentSubview.opaque, currentSubview.hidden, currentSubview.userInteractionEnabled];
        
        
        fprintf(stderr,"%s\n", [currentViewDescription UTF8String]);
        
        [currentSubview printSubviewsWithIndentation:indentation+1];
    }
}

//设置按钮抖动动画
-(void)setUI
{
    CAKeyframeAnimation *scaleX = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
    scaleX.values = @[[NSNumber numberWithFloat:1.0],[NSNumber numberWithFloat:1.1],[NSNumber numberWithFloat:1.0]];
    scaleX.keyTimes = @[[NSNumber numberWithFloat:0.0],[NSNumber numberWithFloat:0.5],[NSNumber numberWithFloat:1.0]];
    scaleX.repeatCount = MAXFLOAT;
    scaleX.autoreverses = YES;
    scaleX.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    scaleX.duration = 6;
    [self.layer addAnimation:scaleX forKey:@"scaleXAnimation"];
    CAKeyframeAnimation *scaleY = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
    scaleY.values = @[[NSNumber numberWithFloat:1.0],[NSNumber numberWithFloat:1.1],[NSNumber numberWithFloat:1.0]];
    scaleY.keyTimes = @[[NSNumber numberWithFloat:0.0],[NSNumber numberWithFloat:0.5],[NSNumber numberWithFloat:1.0]];
    scaleY.repeatCount = MAXFLOAT;
    scaleY.autoreverses = YES;
    scaleY.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    scaleY.duration = 6;
    [self.layer addAnimation:scaleX forKey:@"scaleYAnimation"];
    
}

@end
