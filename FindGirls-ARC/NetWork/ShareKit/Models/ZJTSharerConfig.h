//
//  ZJTSharerConfig.h
//  FindGirls-ARC
//
//  Created by Patrick.Z on 1/7/13.
//  Copyright (c) 2013 ZJTSoft,Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJTSharerConfig : NSObject

@property (nonatomic,strong) NSString *appKey;
@property (nonatomic,strong) NSString *appSecret;
@property (nonatomic,strong) NSString *callbackURL;
@property (nonatomic,strong) NSString *cancelURL;
@property (nonatomic,strong) NSString *sharerClassName;
@property (nonatomic,strong) NSString *oauthVersion;

@property (nonatomic,strong) NSString *requestURL;
@property (nonatomic,strong) NSString *authorizationURL;
@property (nonatomic,strong) NSString *accessURL;

-(id)initWithDict:(NSDictionary*)dict;

@end
