//
//  ZJTGirl.h
//  FindGirls-ARC
//
//  Created by Patrick.Z on 12/26/12.
//  Copyright (c) 2012 ZJTSoft,Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJTGirl : NSObject

@property (nonatomic,strong) NSURL *imageURL;
@property (nonatomic,strong) NSString *uploadUserName;
@property (nonatomic,strong) NSDate *uploadDate;

@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;

-(id)initWithDictionary:(NSDictionary*)dict;
-(void)updateWithDictionary:(NSDictionary*)dict;

@end
