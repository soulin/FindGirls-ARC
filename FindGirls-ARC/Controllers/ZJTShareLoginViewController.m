//
//  ZJTShareLoginViewController.m
//  FindGirls-ARC
//
//  Created by Patrick.Z on 1/7/13.
//  Copyright (c) 2013 ZJTSoft,Inc. All rights reserved.
//

#import "ZJTShareLoginViewController.h"
#import "ZJTSharerSina.h"

@interface ZJTShareLoginViewController ()

@end

@implementation ZJTShareLoginViewController


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlStr = request.URL.absoluteString;
    NSLog(@"url = %@",urlStr);
    if ([_delegate respondsToSelector:@selector(webview:willLoadURL:)]) {
        [_delegate webview:webView willLoadURL:urlStr];
    }
    return YES;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

-(id)initWithURL:(NSURL*)url
        delegate:(id<ZJTShareLoginViewControllerDelegate>)delegate
{
    self = [super initWithNibName:@"ZJTShareLoginViewController"
                           bundle:nil];
    if (self) {
        self.loadURL = url;
        self.delegate = delegate;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.loadURL]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setWebView:nil];
    [super viewDidUnload];
}

-(void)sharer:(ZJTBaseSharer*)sharer didGetAccessToken:(NSString *)token
{
    if ([sharer isKindOfClass:[ZJTSharerSina class]])
    {
        ZJTSharerSina *sina = (ZJTSharerSina*)sharer;
        if (sina.storage.isLogined && !sina.storage.isExpired) {
            //post
            //        sina
            if (self.shareImage) {
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"HH:mm:ss"];
                NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
                
                [sina postText:[NSString stringWithFormat:@"#妹子图 for iPhone# %@",currentDateStr]
                         image:self.shareImage];
            }
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ZJTSharerDidLoginNotification" object:nil];

}

@end
