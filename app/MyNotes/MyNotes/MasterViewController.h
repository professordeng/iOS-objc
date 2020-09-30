//
//  MasterViewController.h
//  MyNotes
//
//  Created by deng on 2020/6/9.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"
#import "NoteDAO.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end

