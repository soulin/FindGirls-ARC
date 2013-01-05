//
//  UINavigationController_OritationYes.m
//  FindGirls-ARC
//
//  Created by Patrick.Z on 1/5/13.
//  Copyright (c) 2013 ZJTSoft,Inc. All rights reserved.
//

#import "UINavigationController_OritationYes.h"

@interface UINavigationController_OritationYes ()

@end

@implementation UINavigationController_OritationYes

-(BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

@end
