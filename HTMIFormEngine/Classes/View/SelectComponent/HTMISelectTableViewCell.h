//
//  HTMISelectTableViewCell.h
//  MXClient
//
//  Created by 赵志国 on 16/8/4.
//  Copyright © 2016年 MXClient. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTMISelectTableViewCell : UITableViewCell

/**
 *  图片
 */
@property (nonatomic, strong) UIImageView *cellImageView;

/**
 *  字
 */
@property (nonatomic, strong) UILabel *cellLabel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellWidth:(CGFloat)cellWidth;

@end
