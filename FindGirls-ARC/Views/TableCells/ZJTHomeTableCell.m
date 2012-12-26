//
//  ZJTHomeTableCell.m
//  FindGirls-ARC
//
//  Created by Patrick.Z on 12/26/12.
//  Copyright (c) 2012 ZJTSoft,Inc. All rights reserved.
//

#import "ZJTHomeTableCell.h"

@interface ZJTHomeTableCell ()

@end

@implementation ZJTHomeTableCell

-(void)setup
{
    _BGImageView.image = [[UIImage imageNamed:@"image_placeholdere@2x.png"] stretchableImageWithLeftCapWidth:160 topCapHeight:100];
    self.contentView.backgroundColor = [UIColor colorWithRed:245.0/255.0
                                                       green:245.0/255.0
                                                        blue:241.0/255.0
                                                       alpha:1.0];
}

@end
