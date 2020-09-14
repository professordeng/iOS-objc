//
//  DetailViewController.m
//  JSON
//
//  Created by deng on 2020/6/16.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureView];
}

- (void)setDetailItem:(id)detailItem
{
    if (_detailItem != detailItem) {
        _detailItem = detailItem;
                
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.detailItem) {
        NSMutableDictionary *dict = self.detailItem;
        self.detailDescriptionLabel.text = dict[@"Content"];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
