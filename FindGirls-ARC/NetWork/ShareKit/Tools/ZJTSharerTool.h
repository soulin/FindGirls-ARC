//
//  ZJTSharerTool.h
//  FindGirls-ARC
//
//  Created by Patrick.Z on 1/9/13.
//  Copyright (c) 2013 ZJTSoft,Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJTSharerConfig.h"
#import "ZJTSharerStorage.h"

@interface ZJTSharerTool : NSObject
{
    
}

+(ZJTSharerConfig*)loadSharerConfigWithName:(NSString*)sharerClassName;

+(void)saveStorage:(ZJTSharerStorage *)storage
    withsharerClassName:(NSString*)sharerClassName;

+(ZJTSharerStorage *)loadStorageWithSharerClassName:(NSString*)sharerClassName
                                       oauthVersion:(NSString*)oauthVersion;

+(NSString*)getPathWithSharerClassName:(NSString*)sharerClassName;

+(NSString *)getPrivateDocumentsDirectory;

+(NSString *)generateURL:(NSString *) baseURL params:(NSDictionary *)params;

//包含“=”
+(NSString *) getStringFromUrl: (NSString*) url needle:(NSString *) needle;

// 不包含“=”
+(NSString *) getOpenidFromUrl:(NSString*) url needle:(NSString *)needle;

@end
