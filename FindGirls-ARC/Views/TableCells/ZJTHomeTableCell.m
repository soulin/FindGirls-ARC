//
//  ZJTHomeTableCell.m
//  FindGirls-ARC
//
//  Created by Patrick.Z on 12/26/12.
//  Copyright (c) 2012 ZJTSoft,Inc. All rights reserved.
//

#import "ZJTHomeTableCell.h"
#import "ZJTGirl.h"
#import "YLProgressBar.h"

@interface ZJTHomeTableCell ()

@end

@implementation ZJTHomeTableCell

-(void)setup
{
    _BGImageView.image = [[UIImage imageNamed:@"image_placeholdere@2x.png"] stretchableImageWithLeftCapWidth:150 topCapHeight:50];
    _progressBar.progressTintColor = [UIColor whiteColor];
    
    _contentImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTaped:)];
    [_contentImageView addGestureRecognizer:tap];
}

-(void)updateWithGirl:(ZJTGirl*)girl index:(NSInteger)row
{
    self.timeLabel.text = girl.displayTime;
    self.rowLabel.text  = [NSString stringWithFormat:@"#%d",row + 1];
    
    CGRect frame = self.contentImageView.frame;
    frame.size.height = [girl heightForWidth:280];
    self.contentImageView.frame = frame;
    
    frame = self.BGImageView.frame;
    frame.size.height = self.contentImageView.frame.size.height + 24;
    self.BGImageView.frame = frame;
    NSLog(@"contentImageView = %@",NSStringFromCGRect(_contentImageView.frame));
    
    NSLog(@"BGImageView = %@",NSStringFromCGRect(_BGImageView.frame));
}

-(void)setProgress:(float)progress
{
    if (progress == -0) {
        progress = 0;
    }
    _progressBar.progress = progress;
    _progressLabel.text = [NSString stringWithFormat:@"%.0f%%", (progress * 100)];
    if (progress == 1.0) {
        _progressBar.hidden = YES;
        _progressLabel.hidden = YES;
    }
    else {
        _progressBar.hidden = NO;
        _progressLabel.hidden = NO;
    }    
}

-(void)imageTaped:(id)sender
{
    if ([_delegate respondsToSelector:@selector(homeCell:imageTaped:)]) {
        [_delegate homeCell:self imageTaped:sender];
    }
}

@end
