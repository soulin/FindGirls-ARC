//
//  UINavigationController_OritationNo.m
//  FindGirls-ARC
//
//  Created by Patrick.Z on 1/5/13.
//  Copyright (c) 2013 ZJTSoft,Inc. All rights reserved.
//

#import "UINavigationController_OritationNo.h"

@interface UINavigationController_OritationNo ()

@end

@implementation UINavigationController_OritationNo

-(BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationPortrait | UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight;
}

@end
