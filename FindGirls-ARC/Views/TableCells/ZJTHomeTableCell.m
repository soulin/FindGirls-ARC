//
//  ZJTHomeTableCell.m
//  FindGirls-ARC
//
//  Created by Patrick.Z on 12/26/12.
//  Copyright (c) 2012 ZJTSoft,Inc. All rights reserved.
//

#import "ZJTHomeTableCell.h"
#import "ZJTGirl.h"

@interface ZJTHomeTableCell ()

@end

@implementation ZJTHomeTableCell

-(void)setup
{
    _BGImageView.image = [[UIImage imageNamed:@"image_placeholdere@2x.png"] stretchableImageWithLeftCapWidth:150 topCapHeight:50];
//    self.contentView.backgroundColor = [UIColor colorWithRed:245.0/255.0
//                                                       green:245.0/255.0
//                                                        blue:241.0/255.0
//                                                       alpha:1.0];
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

@end
