//
//  ZJTAppDelegate.h
//  FindGirls-ARC
//
//  Created by WHZ12038 on 12-12-25.
//  Copyright (c) 2012年 ZJTSoft,Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJTAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
