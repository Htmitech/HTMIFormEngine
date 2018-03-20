//
//  UIScrollView+NoLeftPanGesture.m
//  Express
//
//  Created by admin on 16/2/23.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "UIScrollView+NoLeftPanGesture.h"

@implementation UIScrollView (NoLeftPanGesture)

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
        if ([pan translationInView:self].x > 0.0f && self.contentOffset.x == 0.0f) {
            return NO;
        }
    }
    return [super gestureRecognizerShouldBegin:gestureRecognizer];
}

@end
