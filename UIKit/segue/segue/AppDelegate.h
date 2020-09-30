//
//  AppDelegate.h
//  segue
//
//  Created by deng on 2020/6/15.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

