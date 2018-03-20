//
//  UITableViewCell+GetCell.m
//  MXClient
//
//  Created by 赵志国 on 2017/8/25.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import "UITableViewCell+GetCell.h"

@implementation UITableViewCell (GetCell)

/**
 *  获取View所属的TableViewCell
 *
 *  @param view 当前视图
 *
 *  @return UITableViewCell
 */
+ (UITableViewCell *)getCellBy:(id)view {
    
    
    UITableViewCell *cell = nil;
    if ([[[view superview] superview] isKindOfClass:[UITableViewCell class]]) {
        cell = (UITableViewCell *)[[view superview] superview];
    }
    else if ([[[[view superview] superview] superview] isKindOfClass:[UITableViewCell class]]) {
        cell = (UITableViewCell *)[[[view superview] superview] superview];
    }
    else if ([[[[[view superview] superview] superview] superview] isKindOfClass:[UITableViewCell class]]) {
        cell = (UITableViewCell *)[[[[view superview] superview] superview] superview];
    }
    else if ([[[[[[view superview] superview] superview] superview] superview] isKindOfClass:[UITableViewCell class]]) {
        cell = (UITableViewCell *)[[[[[view superview] superview] superview] superview] superview];
    }
    else if ([[[[[[[view superview] superview] superview] superview] superview] superview] isKindOfClass:[UITableViewCell class]]) {
        cell = (UITableViewCell *)[[[[[[view superview] superview] superview] superview] superview] superview];
    }
    else if ([[[[[[[[view superview] superview] superview] superview] superview] superview] superview] isKindOfClass:[UITableViewCell class]]) {
        cell = (UITableViewCell *)[[[[[[[view superview] superview] superview] superview] superview] superview] superview];
    }
    
    return cell;
}

@end
