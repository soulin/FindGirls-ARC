//
//  ZJTHomeTableCell.h
//  FindGirls-ARC
//
//  Created by Patrick.Z on 12/26/12.
//  Copyright (c) 2012 ZJTSoft,Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZJTGirl;
@class YLProgressBar;

@interface ZJTHomeTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet YLProgressBar *progressBar;
@property (weak, nonatomic) IBOutlet UIImageView *BGImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *rowLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (assign,nonatomic) float progress;

-(void)setup;

-(void)updateWithGirl:(ZJTGirl*)girl index:(NSInteger)row;

@end
