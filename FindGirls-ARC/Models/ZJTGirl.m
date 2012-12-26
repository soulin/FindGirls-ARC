//
//  ZJTGirl.m
//  FindGirls-ARC
//
//  Created by Patrick.Z on 12/26/12.
//  Copyright (c) 2012 ZJTSoft,Inc. All rights reserved.
//

#import "ZJTGirl.h"

@implementation ZJTGirl

//{
//    "cmzt_id":"4548",
//    "cmzt_gsc_id":"1",
//    "cmzt_update_username":"sein",
//    "cmzt_out_id":"1425145",
//    "cmzt_lou_num":"11182",
//    "cmzt_text":"",
//    "cmzt_img_url":"http:\/\/ww4.sinaimg.cn\/mw600\/66b3de17gw1dvto6iidgkj.jpg",
//    "cmzt_img_local_url":"",
//    "cmzt_img_width":"500",
//    "cmzt_img_height":"697",
//    "cmzt_status":"1",
//    "cmzt_add_time":"1344737434"
//}

-(id)initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    if (self) {
        [self updateWithDictionary:dict];
    }
    return self;
}

-(void)updateWithDictionary:(NSDictionary*)dict
{
    if (dict) {
        NSString *url = [dict objectForKey:@"cmzt_img_url"];
        _imageURL = [NSURL URLWithString:url];
        
        NSNumber *dateNumber = [dict objectForKey:@"cmzt_add_time"];
        _uploadDate = [NSDate dateWithTimeIntervalSince1970:dateNumber.integerValue];
        
        _uploadUserName = [dict objectForKey:@"cmzt_update_username"];
        
        NSString *width = [dict objectForKey:@"cmzt_img_width"];
        _width = width.floatValue;
        
        NSString *height = [dict objectForKey:@"cmzt_img_height"];
        _height = height.floatValue;
    }
}

@end
