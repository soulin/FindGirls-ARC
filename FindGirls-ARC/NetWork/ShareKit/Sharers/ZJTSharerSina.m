//
//  ZJTSharerSina.m
//  FindGirls-ARC
//
//  Created by Patrick.Z on 1/9/13.
//  Copyright (c) 2013 ZJTSoft,Inc. All rights reserved.
//

#import "ZJTSharerSina.h"
#import "AFHTTPRequestOperation.h"

@implementation ZJTSharerSina

-(id)init
{
    self = [super init];
    if (self) {
        self.storage = [ZJTSharerTool loadStorageWithSharerClassName:self.sharerClassName oauthVersion:@"2.0"];
//        self.storage.MD5 = @"12345";
        NSLog(@"self.storage.MD5 = %@",self.storage.MD5);
//        [ZJTSharerTool saveStorage:self.storage withsharerClassName:self.sharerClassName];
        self.authorizationParams = [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"token",                  @"response_type",
                                    self.config.appKey,        @"client_id",
                                    self.config.callbackURL,   @"redirect_uri",
                                    @"mobile",                 @"display",nil];
    }
    return self;
}

-(void)postText:(NSString*)text image:(UIImage*)image
{
    
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/2/statuses/upload.json"];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    
    [item setPostValue:self.storage.accessToken    forKey:@"access_token"];
    [item setPostValue:text         forKey:@"status"];
    [item addData:data              forKey:@"pic"];
    
    item.tag = 1.0;
    item.delegate = self;
    [item startAsynchronous];
    
    
    UIView *window = [UIApplication sharedApplication].keyWindow;
    self.HUD = [[MBProgressHUD alloc] initWithView:window];
	[window addSubview:self.HUD];
	
    self.HUD.delegate = self;
    self.HUD.labelText = NSLocalizedString(@"Sending", nil);
    
    [self.HUD show:YES];
}

-(void)completedWithString:(NSString*)string
{
	self.HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
	self.HUD.mode = MBProgressHUDModeCustomView;
	self.HUD.labelText = string;
    
    [self.HUD performSelector:@selector(hide:)
                   withObject:[NSNumber numberWithBool:YES]
                   afterDelay:2.0];
}

-(void)myTask
{
    sleep(2);
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = request.responseString;
    NSLog(@"responseString = %@",responseString);
    [self completedWithString:NSLocalizedString(@"Completed", nil)];
    
    //认证失败
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    id  returnObject = [parser objectWithString:responseString];
    if ([returnObject isKindOfClass:[NSDictionary class]]) {
        NSString *errorString = [returnObject  objectForKey:@"error"];
        if (errorString != nil && ([errorString isEqualToString:@"auth faild!"] ||
                                   [errorString isEqualToString:@"expired_token"] ||
                                   [errorString isEqualToString:@"invalid_access_token"])) {
            
            NSLog(@"detected auth faild!");
        }
    }
    
    NSDictionary *userInfo = nil;
    NSArray *userArr = nil;
    if ([returnObject isKindOfClass:[NSDictionary class]]) {
        userInfo = (NSDictionary*)returnObject;
    }
    else if ([returnObject isKindOfClass:[NSArray class]]) {
        userArr = (NSArray*)returnObject;
    }
    else {
        return;
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{    
    [self completedWithString:NSLocalizedString(@"Sent Failed", nil)];
}

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [self.HUD removeFromSuperview];
	self.HUD = nil;
}

@end
