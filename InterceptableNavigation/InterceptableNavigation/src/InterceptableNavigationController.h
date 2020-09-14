//
//  InterceptableNavigationController.h
//  InterceptableNavigation
//
//  Created by leon on 03/07/2020.
//  Copyright © 2020 Maimemo Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InterceptableNavigationController;

typedef BOOL (^INCShouldBlock)(InterceptableNavigationController *navigationController, UINavigationItem *item);
typedef void (^INCDidBlock)(InterceptableNavigationController *navigationController, UINavigationItem *item);


@interface InterceptableNavigationController : UINavigationController

@property (nonatomic, copy) INCDidBlock onPop; // set this block if you want to intercept navigation pop event

/* more options
@property (nonatomic, copy) INCShouldBlock shouldPop;
@property (nonatomic, copy) INCShouldBlock shouldPush;
@property (nonatomic, copy) INCDidBlock didPush;
@property (nonatomic, copy) INCDidBlock didPop;
 */

@end

