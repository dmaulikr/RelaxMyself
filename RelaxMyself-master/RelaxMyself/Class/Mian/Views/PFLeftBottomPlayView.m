//
//  PFLeftBottonPlayView.m
//  RelaxMyself
//
//  Created by 周坤磊 on 16/1/21.
//  Copyright © 2016年 周坤磊. All rights reserved.
//


#import "PFLeftBottomPlayView.h"
#import "UIImageView+WebCache.h"

#import "DOUAudioStreamer.h"


@interface PFLeftBottomPlayView ()

{
    UIImageView *_iconView;
    UILabel *_nameLab;
    UIButton *_playButton;
    BOOL _isPause;
}

@end
@implementation PFLeftBottomPlayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _iconView = [[UIImageView alloc] init];
        [self addSubview:_iconView];
        
        _nameLab = [[UILabel alloc] init];
        _nameLab.font = [UIFont systemFontOfSize:12.0];
        _nameLab.textColor = [UIColor whiteColor];
        [self addSubview:_nameLab];
        
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setBackgroundImage:[UIImage imageNamed:@"radarStop"] forState:UIControlStateNormal];
        [_playButton addTarget:self action:@selector(playClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_playButton];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat margin = 5;
    
    _playButton.size = CGSizeMake(30, 30);
    _playButton.centerY = self.height * 0.5;
    _playButton.x = margin;
    
    
    CGFloat iconH = self.height;
    CGFloat iconW = iconH;
    CGFloat iconX = CGRectGetMaxX(_playButton.frame) + margin;
    CGFloat iconY = 0;
    _iconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    _nameLab.width = 200;
    _nameLab.height = _nameLab.font.lineHeight;
    _nameLab.centerY = self.height * 0.5;
    _nameLab.x = CGRectGetMaxX(_iconView.frame) + margin;
    
}


- (void)playClick:(UIButton *)button
{
    if (_isPause) {
        _isPause = NO;
        [_playButton setBackgroundImage:[UIImage imageNamed:@"radarStop"] forState:UIControlStateNormal];
        [self.streamer play];
        
    }else{
        _isPause = YES;
        [_playButton setBackgroundImage:[UIImage imageNamed:@"radarPlay"] forState:UIControlStateNormal];
        [self.streamer pause];
    }
}

@end
