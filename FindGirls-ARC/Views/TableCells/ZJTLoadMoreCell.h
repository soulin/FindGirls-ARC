//
//  ZJTLoadMoreCell.h
//  FindGirls-ARC
//
//  Created by Patrick.Z on 1/3/13.
//  Copyright (c) 2013 ZJTSoft,Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJTLoadMoreCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
@property (weak, nonatomic) IBOutlet UILabel *label;

-(void)setup;

@end
