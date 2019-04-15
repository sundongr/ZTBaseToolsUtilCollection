//
//  AppDelegate.h
//  ZTBaseToolsUtilCollection
//
//  Created by 孙东日 on 10/4/2019.
//  Copyright © 2019 孙东日. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

