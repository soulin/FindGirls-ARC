//
//  ZJTConfigration.h
//  FindGirls-ARC
//
//  Created by Patrick.Z on 1/3/13.
//  Copyright (c) 2013 ZJTSoft,Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJTConfigration : NSObject
{
    NSUserDefaults *_userDefault;
}

@property (nonatomic,assign) BOOL hasAD;

+(ZJTConfigration *) sharedConfigration;

@end
