//
//  AppDelegate.h
//  CoreData
//
//  Created by deng on 2020/6/13.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

