//
//  HTMISelectTableViewCell.m
//  MXClient
//
//  Created by 赵志国 on 16/8/4.
//  Copyright © 2016年 MXClient. All rights reserved.
//

#import "HTMISelectTableViewCell.h"

#import "UtilsMacros.h"

#import "UIFont+HTMIFont.h"

@implementation HTMISelectTableViewCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellWidth:(CGFloat)cellWidth {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.cellImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kW6(20), kH6(10), kW6(20), kH6(20))];
        [self.contentView addSubview:self.cellImageView];
        
        self.cellLabel = [[UILabel alloc] initWithFrame:CGRectMake(kW6(50), 0, cellWidth-kW6(50), kH6(40))];
        self.cellLabel.font = [UIFont htmi_systemFontOfSize:15.0];
        [self.contentView addSubview:self.cellLabel];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
