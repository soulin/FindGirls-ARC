//
//  ZJTSharerTool.m
//  FindGirls-ARC
//
//  Created by Patrick.Z on 1/9/13.
//  Copyright (c) 2013 ZJTSoft,Inc. All rights reserved.
//

#import "ZJTSharerTool.h"

@implementation ZJTSharerTool

+(ZJTSharerConfig*)loadSharerConfigWithName:(NSString*)sharerClassName
{
    ZJTSharerConfig *config = nil;
    
    NSString *configPath = [[NSBundle mainBundle] pathForResource:@"SharersConfig"
                                                           ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:configPath];
    NSArray *sharers = [dict objectForKey:@"shares"];
    
    if (sharers && sharers.count)
    {
        for (NSDictionary *eachDict in sharers)
        {
            if ([[eachDict objectForKey:@"sharer class name"] isEqualToString:sharerClassName])
            {
                config = [[ZJTSharerConfig alloc] initWithDict:eachDict];
                return config;
            }
        }
    }
    
    return config;
}

+ (NSString *)getPrivateDocumentsDirectory
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"Private Documents"];
    
    NSError *error;
    [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:&error];
    
    return documentsDirectory;    
}

+(NSString*)getPathWithSharerClassName:(NSString*)sharerClassName
{
    NSString *path = [[ZJTSharerTool getPrivateDocumentsDirectory] stringByAppendingPathComponent:sharerClassName];
    NSError *error;
    [[NSFileManager defaultManager] createDirectoryAtPath:path
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:&error];
    return [path stringByAppendingFormat:@"/sharer.archive"];
}

+(ZJTSharerStorage *)loadStorageWithSharerClassName:(NSString*)sharerClassName
                                       oauthVersion:(NSString*)oauthVersion
{
    NSString *filePath = [ZJTSharerTool getPathWithSharerClassName:sharerClassName];
    
    ZJTSharerStorage *storage = nil;
    if (filePath == nil || [filePath length] == 0 ||
        [[NSFileManager defaultManager] fileExistsAtPath:filePath] == NO)
    {
        storage = [[ZJTSharerStorage alloc] initWithSharerClassName:sharerClassName
                                                  oauthVersion:oauthVersion];
    }
    else
    {
        NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
        NSKeyedUnarchiver *vdUnarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        storage = [vdUnarchiver decodeObjectForKey:sharerClassName];
        [vdUnarchiver finishDecoding];
        
        if (storage.sharerClassName == nil) {
            storage = [[ZJTSharerStorage alloc] initWithSharerClassName:sharerClassName
                                                      oauthVersion:oauthVersion];
        }
    }
    return storage;
}

+ (void)saveStorage:(ZJTSharerStorage *)storage
     withsharerClassName:(NSString*)sharerClassName
{
    NSString *filePath = [ZJTSharerTool getPathWithSharerClassName:sharerClassName];
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *vdArchiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [vdArchiver encodeObject:storage forKey:storage.sharerClassName];
    [vdArchiver finishEncoding];
    
    BOOL sucsess = [data writeToFile:filePath atomically:YES];
    NSLog(@"sucsess = %d",sucsess);
}

+(NSString *) generateURL:(NSString *) baseURL params:(NSDictionary *)params
{
	if (params)
	{
		NSMutableArray* pairs = [NSMutableArray array];
		for (NSString* key in params.keyEnumerator)
			
		{
			NSString* value = [params objectForKey:key];
			NSString* escaped_value = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(
																						  NULL, /* allocator */
																						  (CFStringRef)value,
																						  NULL, /* charactersToLeaveUnescaped */
																						  (CFStringRef)@"!*'();:@&=+$,/?%#[]",
																						  kCFStringEncodingUTF8);
			
			[pairs addObject:[NSString stringWithFormat:@"%@=%@", key, escaped_value]];
		}
		
		NSString* query = [pairs componentsJoinedByString:@"&"];
		NSString* url = [NSString stringWithFormat:@"%@?%@", baseURL, query];
		return url;
	}
	else
		return baseURL;
}


//包含“=”
+ (NSString *) getStringFromUrl: (NSString*) url needle:(NSString *) needle
{
	NSString * str = nil;
    needle = [needle stringByAppendingString:@"="];
	NSRange start = [url rangeOfString:needle];
	if (start.location != NSNotFound) {
		NSRange end = [[url substringFromIndex:start.location+start.length] rangeOfString:@"&"];
		NSUInteger offset = start.location+start.length;
        
		str = end.location == NSNotFound
		? [url substringFromIndex:offset]
		: [url substringWithRange:NSMakeRange(offset, end.location)];
        
		str = [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	}
	return str;
}

// 不包含“=”
+ (NSString *) getOpenidFromUrl:(NSString*) url needle:(NSString *)needle
{
	NSString * str = nil;
	NSRange start = [url rangeOfString:needle];
	NSRange start2 = NSMakeRange(start.location+9, 32);
	str = [url substringWithRange:start2];
	return str;
}

@end
