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
//    NSData *data = UIImageJPEGRepresentation(image, 1.0);
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
//                            self.storage.accessToken,   @"access_token",
//                            text,                       @"status",
//                            data,                       @"pic",nil];
//    
//    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com"];
//    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
//    NSString *_path = [NSString stringWithFormat:@"/2/statuses/upload.json"];
//    
//    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
//                                                            path:_path
//                                                      parameters:params];
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
//    [operation setCompletionBlockWithSuccess:
//     ^(AFHTTPRequestOperation *operation, id responseObject)
//    { //下載成功之後，使用JSONKit將字串轉成NSDictionary或NSArray 格式
//        NSLog(@"responseString = %@",operation.responseString);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
//     {
//            //下載失敗之後處理
//        
//     }];
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    [queue addOperation:operation];
}

@end
