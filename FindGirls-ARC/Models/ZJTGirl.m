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

- (NSString*)displayTime
{
	NSString *timestamp;
    // Calculate distance time string
    //
    time_t now;
    time(&now);
    
    int distance = (int)difftime(now, [_uploadDate timeIntervalSince1970]);
    if (distance < 0) distance = 0;
    
    if (distance < 60) {
        timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"秒前" : @"秒前"];
    }
    else if (distance < 60 * 60) {
        distance = distance / 60;
        timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"分钟前" : @"分钟前"];
    }
    else if (distance < 60 * 60 * 24) {
        distance = distance / 60 / 60;
        timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"小时前" : @"小时前"];
    }
    else if (distance < 60 * 60 * 24 * 7) {
        distance = distance / 60 / 60 / 24;
        timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"天前" : @"天前"];
    }
    else if (distance < 60 * 60 * 24 * 7 * 4) {
        distance = distance / 60 / 60 / 24 / 7;
        timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"周前" : @"周前"];
    }
    else {
        static NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateStyle:kCFDateFormatterMediumStyle];
            [dateFormatter setTimeStyle:kCFDateFormatterMediumStyle];
        }
        
        timestamp = [dateFormatter stringFromDate:_uploadDate];
    }
    return timestamp;
}

-(CGFloat)heightForWidth:(CGFloat)width
{
    CGFloat height;
    float rate = width / _width;
    height = _height * rate;
    
    return height;
}

-(CGFloat)widthForHeight:(CGFloat)height
{
    CGFloat width;
    float rate = height / _height;
    width = _width * rate;
    
    return width;
}

-(CGSize)sizeForHeight:(CGFloat)height
{
    return CGSizeMake([self widthForHeight:height], height);
}

-(CGSize)sizeForWidth:(CGFloat)width
{
    return CGSizeMake(width, [self heightForWidth:width]);
}

-(CGRect)rectForWidth:(CGFloat)width
{
    return CGRectMake(0, 0, width, [self heightForWidth:width]);
}

-(CGRect)rectForHeight:(CGFloat)height
{
    return CGRectMake(0, 0, [self widthForHeight:height], height);
}

@end
