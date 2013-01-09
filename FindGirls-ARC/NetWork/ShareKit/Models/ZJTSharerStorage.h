//
//  ZJTSharerStorage.h
//  FindGirls-ARC
//
//  Created by Patrick.Z on 1/7/13.
//  Copyright (c) 2013 ZJTSoft,Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJTSharerStorage : NSObject <NSCoding>
{
    
}

@property (nonatomic,strong) NSString *accessToken;
@property (nonatomic,strong) NSString *accessKey;
@property (nonatomic,strong) NSString *accessSecret;
@property (nonatomic,strong) NSString *refreshToken;
@property (nonatomic,strong) NSString *openID;
@property (nonatomic,strong) NSString *uid;
@property (nonatomic,strong) NSString *MD5;
@property (nonatomic,strong) NSString *oauthVersion;
@property (nonatomic,strong) NSString *sharerClassName;

@property (nonatomic,strong) NSDate *expireDate;

@property (nonatomic,assign) BOOL isExpired;
@property (nonatomic,assign) BOOL isLogined;

-(id)initWithSharerClassName:(NSString*)sharerClassName
             oauthVersion:(NSString*)oauthVersion;

@end
