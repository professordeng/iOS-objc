//
//  NoteViewController.h
//  CoreData
//
//  Created by deng on 2020/6/16.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"
#import "NoteDAO.h"

NS_ASSUME_NONNULL_BEGIN

@interface NoteViewController : UIViewController

@property (strong, nonatomic) Note *note;

@end

NS_ASSUME_NONNULL_END
