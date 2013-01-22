//
//  ZJTBaseSharer.h
//  FindGirls-ARC
//
//  Created by Patrick.Z on 1/7/13.
//  Copyright (c) 2013 ZJTSoft,Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZJTSharerConfig.h"
#import "ZJTSharerStorage.h"
#import "ZJTSharerTool.h"

//avoid loop delegating.
//***************************************************************************

@protocol ZJTShareLoginViewControllerDelegate <NSObject>

@optional
-(void)webview:(UIWebView*)webview willLoadURL:(NSString*)url;

@end

//***************************************************************************
//ZJTBaseSharer
@protocol ZJTBaseSharerDelegate;

@interface ZJTBaseSharer : NSObject
<ZJTShareLoginViewControllerDelegate,ASIHTTPRequestDelegate,MBProgressHUDDelegate>
{
}

@property (nonatomic,strong) ZJTSharerConfig *config;
@property (nonatomic,strong) ZJTSharerStorage *storage;

@property (nonatomic,strong) NSString *sharerClassName;
@property (nonatomic,strong) NSDictionary *authorizationParams;

@property (nonatomic,strong) NSURL *loginURL;
@property (nonatomic,strong) MBProgressHUD *HUD;

@property (nonatomic,weak) id<ZJTBaseSharerDelegate> delegate;

@end


@protocol ZJTBaseSharerDelegate <NSObject>

//2.0
@optional
-(void)sharer:(ZJTBaseSharer*)sharer didGetAccessToken:(NSString*)token;

@end