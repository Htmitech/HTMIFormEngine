//
//  UITableViewCell+GetCell.h
//  MXClient
//
//  Created by 赵志国 on 2017/8/25.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (GetCell)

/**
 *  获取View所属的TableViewCell
 *
 *  @param view 当前视图
 *
 *  @return UITableViewCell
 */
+ (UITableViewCell *)getCellBy:(id)view;

@end
