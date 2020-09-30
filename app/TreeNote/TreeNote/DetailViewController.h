//
//  DetailViewController.h
//  TreeNote
//
//  Created by deng on 2020/6/5.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSDate *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

