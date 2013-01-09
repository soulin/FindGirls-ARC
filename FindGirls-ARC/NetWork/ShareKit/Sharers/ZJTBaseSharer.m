//
//  ZJTBaseSharer.m
//  FindGirls-ARC
//
//  Created by Patrick.Z on 1/7/13.
//  Copyright (c) 2013 ZJTSoft,Inc. All rights reserved.
//

#import "ZJTBaseSharer.h"

@implementation ZJTBaseSharer

-(ZJTSharerConfig*)config
{
    if (_config == nil) {
        _config = [ZJTSharerTool loadSharerConfigWithName:self.sharerClassName];
    }
    return _config;
}

-(NSString*)sharerClassName
{
    if (_sharerClassName == nil) {
        _sharerClassName = NSStringFromClass([self class]);
    }
    return _sharerClassName;
}

-(NSURL*)loginURL
{
    if (_loginURL == nil) {
        NSString *urlStr = [ZJTSharerTool generateURL:self.config.authorizationURL
                                              params:self.authorizationParams];
        _loginURL = [[NSURL alloc] initWithString:urlStr];
    }
    return _loginURL;
}

-(void)webview:(UIWebView*)webview willLoadURL:(NSString*)url
{
    if ([url hasPrefix:self.config.callbackURL])
	{
        //sina
        if ([self.sharerClassName isEqualToString:@"ZJTSharerSina"])
        {
//            url = http://ok.com/#access_token=2.00dNqO_Cle_LBE1fb5a644447gGELD&remind_in=103616&expires_in=103616&uid=2116553373
            ZJTSharerStorage *storage = nil;
            
			NSString *token     = [ZJTSharerTool getStringFromUrl:url
                                                           needle:@"access_token"];
            
            NSString *expiresIn = [ZJTSharerTool getStringFromUrl:url
                                                           needle:@"expires_in"];
            
            NSString *uid       = [ZJTSharerTool getStringFromUrl:url
                                                           needle:@"uid"];
            
            if (token && token.length) {
                storage = [[ZJTSharerStorage alloc] initWithSharerClassName:self.sharerClassName
                                                               oauthVersion:self.config.oauthVersion];
                
                storage.accessToken = token;
                storage.uid = uid;
                storage.expireDate = [NSDate dateWithTimeIntervalSince1970:expiresIn.longLongValue];
                
                self.storage = storage;
                [ZJTSharerTool saveStorage:storage
                       withsharerClassName:self.sharerClassName];
                
                if ([_delegate respondsToSelector:@selector(sharer:didGetAccessToken:)]) {
                    [_delegate sharer:self didGetAccessToken:token];
                }
            }
            
            
            
//			NSString *token = [ZJTSharerTool getStringFromUrl:url needle:@"oauth_token"];
//			NSString *token = [ZJTSharerTool getStringFromUrl:url needle:@"oauth_token"];
//			NSString *token = [ZJTSharerTool getStringFromUrl:url needle:@"oauth_token"];
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
		if ([self.sharerClassName isEqualToString:@"WSKFlickrSharer"]||
            [self.sharerClassName isEqualToString:@"WSKTwitterSharer"]||
            [self.sharerClassName isEqualToString:@"WSKTumblrSharer"])
		{
			NSString *token = [ZJTSharerTool getStringFromUrl:url needle:@"oauth_token"];
			NSString *verifier = [ZJTSharerTool getStringFromUrl:url needle:@"oauth_verifier"];
			if (token.length >0 && verifier.length > 0 )
			{
//				self.responseData = [NSDictionary dictionaryWithObjectsAndKeys:
//									 token,@"token",
//									 verifier,@"verifier", nil];
			}
		}
//		if ([self.sharerClassName isEqualToString:@"WSKTXSharer"])
//		{
//			NSString *openid = [ZJTSharerTool getStringFromUrl:url needle:@"openid"];
//			NSString *openKey = [ZJTSharerTool getStringFromUrl:url needle:@"openkey"];
//			NSString *code = [ZJTSharerTool getStringFromUrl:url needle:@"code"];
//			
//			if (code.length >0 & openid.length > 0)
//			{
////				self.responseData = [NSDictionary dictionaryWithObjectsAndKeys:
////									 openid,@"openid",
////									 openKey,@"openkey",
////									 code,@"code", nil];
//			}
//		}
		else
		{
			NSString *code = [ZJTSharerTool getStringFromUrl:url needle:@"code"];
			
			if (code.length >0 )
			{
//				self.responseData = [NSDictionary dictionaryWithObjectsAndKeys:code,@"code", nil];
			}
		}
		
//		if (self.responseData && _oauthDelegate && [_oauthDelegate respondsToSelector:@selector(oauthViewDidReceiveData:)])
//		{
//			[_oauthDelegate oauthViewDidReceiveData:self];
//		}
		
	}

}


@end
