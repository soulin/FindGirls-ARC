//
//  ZJTSharerConfig.m
//  FindGirls-ARC
//
//  Created by Patrick.Z on 1/7/13.
//  Copyright (c) 2013 ZJTSoft,Inc. All rights reserved.
//

#import "ZJTSharerConfig.h"

@implementation ZJTSharerConfig

-(id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self updateWithDict:dict];
    }
    
    return self;
}

-(void)updateWithDict:(NSDictionary*)dict
{
    self.appKey             = [dict objectForKey:@"app key"];
    self.appSecret          = [dict objectForKey:@"app secrest"];
    self.callbackURL        = [dict objectForKey:@"callback URL"];
    self.cancelURL          = [dict objectForKey:@"cancel URL"];
    self.sharerClassName    = [dict objectForKey:@"sharer class name"];
    self.oauthVersion       = [dict objectForKey:@"oauth version"];
    self.requestURL         = [dict objectForKey:@"request token URL"];
    self.authorizationURL   = [dict objectForKey:@"authorization URL"];
    self.accessURL          = [dict objectForKey:@"access token URL"];
}

@end
