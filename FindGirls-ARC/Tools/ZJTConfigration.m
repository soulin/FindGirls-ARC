//
//  ZJTConfigration.m
//  FindGirls-ARC
//
//  Created by Patrick.Z on 1/3/13.
//  Copyright (c) 2013 ZJTSoft,Inc. All rights reserved.
//

#import "ZJTConfigration.h"

static ZJTConfigration *instance;

@implementation ZJTConfigration

+(ZJTConfigration *) sharedConfigration
{
    @synchronized(self) {
        if (instance == nil) {
            instance = [[ZJTConfigration alloc] init];
        }
    }
    return instance;
}

//getter
-(BOOL)hasAD
{
    return [_userDefault boolForKey:@"hasAD"];
}

//setter
-(void)setHasAD:(BOOL)hasAD
{
    [_userDefault setBool:hasAD forKey:@"hasAD"];
}

@end
