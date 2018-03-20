//
//  HTMIFormOpinionAutographView.h
//  MXClient
//
//  Created by 赵志国 on 2017/8/25.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import "HTMIFormBaseView.h"

@protocol HTMIFormOpinionAutographViewDelegate <NSObject>

@end

@interface HTMIFormOpinionAutographView : HTMIFormBaseView

@property (nonatomic, weak) id <HTMIFormOpinionAutographViewDelegate> opinionDelegate;


@end
