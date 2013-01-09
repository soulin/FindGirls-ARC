//
//  ZJTSharerStorage.m
//  FindGirls-ARC
//
//  Created by Patrick.Z on 1/7/13.
//  Copyright (c) 2013 ZJTSoft,Inc. All rights reserved.
//

#import "ZJTSharerStorage.h"

@implementation ZJTSharerStorage

-(id)initWithSharerClassName:(NSString*)sharerClassName
             oauthVersion:(NSString*)oauthVersion
{
    self = [super init];
    if (self) {
        self.sharerClassName = sharerClassName;
        self.oauthVersion = oauthVersion;
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.accessToken
                  forKey:@"accessToken"];
    
    [aCoder encodeObject:self.accessKey
                  forKey:@"accessKey"];
    
    [aCoder encodeObject:self.accessSecret
                  forKey:@"accessSecret"];
    
    [aCoder encodeObject:self.refreshToken
                  forKey:@"refreshToken"];
    
    [aCoder encodeObject:self.openID
                  forKey:@"openID"];
    
    [aCoder encodeObject:self.uid
                  forKey:@"uid"];
    
    [aCoder encodeObject:self.MD5
                  forKey:@"MD5"];
    
    [aCoder encodeObject:self.oauthVersion
                  forKey:@"oauthVersion"];
    
    [aCoder encodeObject:self.sharerClassName
                  forKey:@"sharerClassName"];
    
    [aCoder encodeObject:self.expireDate
                  forKey:@"expireDate"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.accessToken     = [aDecoder decodeObjectForKey:@"accessToken"];
        self.accessKey       = [aDecoder decodeObjectForKey:@"accessKey"];
        self.accessSecret    = [aDecoder decodeObjectForKey:@"accessSecret"];
        self.refreshToken    = [aDecoder decodeObjectForKey:@"refreshToken"];
        self.openID          = [aDecoder decodeObjectForKey:@"openID"];
        self.MD5             = [aDecoder decodeObjectForKey:@"MD5"];
        self.uid             = [aDecoder decodeObjectForKey:@"uid"];
        self.oauthVersion    = [aDecoder decodeObjectForKey:@"oauthVersion"];
        self.sharerClassName = [aDecoder decodeObjectForKey:@"sharerClassName"];
        self.expireDate      = [aDecoder decodeObjectForKey:@"expireDate"];
    }
    return self;
}


-(BOOL)isExpired
{
    if ([_oauthVersion isEqualToString:@"1.0"]) {
        if (_accessKey == nil || _accessKey.length == 0) {
            return NO;
        }
    }
    else if([_oauthVersion isEqualToString:@"2.0"]){
        if (_accessToken == nil || _accessToken.length == 0) {
            return NO;
        }
        else if (NSOrderedDescending != [_expireDate compare:[NSDate date]])
        {
            return NO;
        }
    }
    return YES;
}

-(BOOL)isLogined
{
    if ([_oauthVersion isEqualToString:@"1.0"]) {
        if (_accessKey == nil || _accessKey.length == 0) {
            return NO;
        }
    }
    else if([_oauthVersion isEqualToString:@"2.0"]){
        if (_accessToken == nil || _accessToken.length == 0) {
            return NO;
        }
    }
    return YES;
}

@end
