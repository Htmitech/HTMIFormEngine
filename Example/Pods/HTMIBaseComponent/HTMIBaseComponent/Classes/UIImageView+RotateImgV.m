//
//  UIImageView+RotateImgV.m
//  RotateImgV
//
//  Created by Ashen on 15/11/10.
//  Copyright © 2015年 Ashen. All rights reserved.
//

#import "UIImageView+RotateImgV.h"

@implementation UIImageView (RotateImgV)

- (void)rotate360DegreeWithImageView {
    CABasicAnimation *rotationAnimation= [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    //它设定开始值到结束值花费的时间。期间会被速度的属性所影响。
    rotationAnimation.duration = 2.0;
    rotationAnimation.cumulative = YES;
    //默认的是 0,意味着动画只会播放一次。如果指定一个无限大的重复次数,使用 1e100f。这个不应该和 repeatDration 属性一块使用。
    rotationAnimation.repeatCount = 100;
    
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)stopRotate {
    [self.layer removeAllAnimations];
}

/**
 画水印
 
 @param image 图片
 @param mark 水印图片
 @param rect 位置
 */
- (void)setImage:(UIImage *)image withWaterMark:(UIImage *)mark inRect:(CGRect)rect
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0)
    {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    }
    //原图
    [image drawInRect:self.bounds];
    //水印图
    [mark drawInRect:rect];
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.image = newPic;
}

@end
