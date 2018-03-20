//
//  HTMIWorkFlowExtAudioView.m
//  MXClient
//
//  Created by 赵志国 on 2017/5/5.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import "HTMIWorkFlowExtAudioView.h"

#import "UtilsMacros.h"

@interface HTMIWorkFlowExtAudioView ()<AVAudioPlayerDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIButton *deleteButton;

/**
 播放图片
 */
@property (nonatomic, strong) UIImageView *audioPlayImageView;

@end

@implementation HTMIWorkFlowExtAudioView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.isClick = YES;
    }
    return self;
}

- (void)setAudioUrlString:(NSString *)audioUrlString {
    
}

- (void)setAudioPathString:(NSString *)audioPathString {
    _audioPathString = audioPathString;
    
    [self addSubview:self.audioPlayImageView];
    
    [self addSubview:self.deleteButton];
}

#pragma mark ------ 播放音乐文件
- (BOOL)playMusicWithUrl:(NSURL *)fileUrl {
    //其他播放器停止播放
    //    [self stopAllMusic];
    
    //    if (!fileUrl) return NO;
    
    AVAudioSession *session=[AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];  //此处需要恢复设置回放标志，否则会导致其它播放声音也会变小
    [session setActive:YES error:nil];
    
    self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:fileUrl error:nil];//[self musices][fileUrl];
    
    //    if (!player) {
    //        //2.2创建播放器
    //        player=[[AVAudioPlayer alloc]initWithContentsOfURL:fileUrl error:nil];
    //    }
    
    self.audioPlayer.delegate = self;
    
    if (![self.audioPlayer prepareToPlay]){
        NSLog(@"缓冲失败--");
        //[self myToast:@"播放器缓冲失败"];
        return NO;
    }
    
    [self.audioPlayer play];
    
    //2.4存入字典
    //[self musices][fileUrl]=player;
    
    //NSLog(@"musices:%@ musices",self.musices);
    
    return YES;//正在播放，那么就返回YES
}

- (void)audioPlayImageViewStopAnimating {
    
    //停止动画
    [self.audioPlayImageView stopAnimating];
    
    self.isClick = !self.isClick;
}

#pragma mark ------ AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    
    [self.audioPlayImageView stopAnimating];
    
    self.isClick = !self.isClick;
    
}

#pragma mark ------ 懒加载
- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(W(self)/8*5, 0, W(self)/8*3, H(self)/8*3)];
        [_deleteButton setBackgroundImage:[UIImage imageNamed:@"btn_operation_audio_delete"] forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

- (UIImageView *)audioPlayImageView {
    if (!_audioPlayImageView) {
        _audioPlayImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _audioPlayImageView.image = [UIImage imageNamed:@"btn_operation_audio_play"];
        _audioPlayImageView.tag = self.tag;
        _audioPlayImageView.userInteractionEnabled = YES;
        
        NSArray *picArray = @[[UIImage imageNamed:@"btn_operation_audio_play_1"],
                              [UIImage imageNamed:@"btn_operation_audio_play_2"],
                              [UIImage imageNamed:@"btn_operation_audio_play_3"],];
        //imageView的动画图片是数组images
        _audioPlayImageView.animationImages = picArray;
        //按照原始比例缩放图片，保持纵横比
        _audioPlayImageView.contentMode = UIViewContentModeScaleAspectFit;
        //切换动作的时间3秒，来控制图像显示的速度有多快，
        _audioPlayImageView.animationDuration = 1;
        //动画的重复次数，想让它无限循环就赋成0
        _audioPlayImageView.animationRepeatCount = 0;
        [self addSubview:_audioPlayImageView];
        
        UITapGestureRecognizer *audioPlay = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(audioPlaying:)];
        audioPlay.delegate = self;
        [_audioPlayImageView addGestureRecognizer:audioPlay];
    }
    
    return _audioPlayImageView;
}


#pragma mark ------ 点击事件
- (void)deleteButtonClick:(UIButton *)btn {
    
    [self.audioPlayer stop];
    
    self.deleteBlock(self);
}

- (void)audioPlaying:(UITapGestureRecognizer *)playTap {
    
    if (self.isClick) {
        [self playMusicWithUrl:[NSURL fileURLWithPath:self.audioPathString]];
        
        self.audioPlayBlock(self);
        
        [self.audioPlayImageView startAnimating];
    } else {
        
        [self.audioPlayer stop];
        
        [self.audioPlayImageView stopAnimating];
    }
    
    self.isClick = !self.isClick;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
