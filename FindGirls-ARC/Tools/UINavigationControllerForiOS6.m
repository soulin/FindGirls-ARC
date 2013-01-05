//
//  UINavigationControllerForiOS6.m
//  FindGirls-ARC
//
//  Created by Patrick.Z on 1/5/13.
//  Copyright (c) 2013 ZJTSoft,Inc. All rights reserved.
//

#import "UINavigationControllerForiOS6.h"

@interface UINavigationControllerForiOS6 ()

@end

@implementation UINavigationControllerForiOS6

-(BOOL)shouldAutorotate
{
    return [self.topViewController shouldAutorotate];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return [self.topViewController supportedInterfaceOrientations];
}

@end
