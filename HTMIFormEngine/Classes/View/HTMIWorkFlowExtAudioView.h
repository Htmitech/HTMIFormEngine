//
//  HTMIWorkFlowExtAudioView.h
//  MXClient
//
//  Created by 赵志国 on 2017/5/5.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>

@class HTMIWorkFlowExtAudioView;

typedef void(^HTMIWorkFlowExtAudioPlayBlock)(HTMIWorkFlowExtAudioView *extAudioView);

typedef void(^HTMIWorkFlowEstAudioDeleteBlock)(HTMIWorkFlowExtAudioView *extAudioView);

@interface HTMIWorkFlowExtAudioView : UIView

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

/**
 音频 url 路径
 */
@property (nonatomic, copy) NSString *audioUrlString;

/**
 音频 本地 路径
 */
@property (nonatomic, copy) NSString *audioPathString;

/**
 播放
 */
@property (nonatomic, copy) HTMIWorkFlowExtAudioPlayBlock audioPlayBlock;

/**
 删除
 */
@property (nonatomic, copy) HTMIWorkFlowEstAudioDeleteBlock deleteBlock;

/**
 是否播放中
 */
@property (nonatomic, assign) BOOL isClick;

/**
 停止播放动画
 */
- (void)audioPlayImageViewStopAnimating;

@end
