//
//  ZJTShareLoginViewController.h
//  FindGirls-ARC
//
//  Created by Patrick.Z on 1/7/13.
//  Copyright (c) 2013 ZJTSoft,Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJTBaseSharer.h"

//ZJTShareLoginViewController
@protocol ZJTShareLoginViewControllerDelegate;

@interface ZJTShareLoginViewController : UIViewController<UIWebViewDelegate,ZJTBaseSharerDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic,strong) NSURL *loadURL;
@property (nonatomic,weak) id<ZJTShareLoginViewControllerDelegate> delegate;

-(id)initWithURL:(NSURL*)url
        delegate:(id<ZJTShareLoginViewControllerDelegate>)delegate;

@end
