//
//  ViewController.m
//  SearchBar
//
//  Created by deng on 2020/7/1.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"
#import "SearchBar.h"

@interface ViewController () <UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    NSLog(@"开始编辑搜索框");
    [self.searchBar setShowsCancelButton:YES];
    self.navigationController.navigationBarHidden = YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"文本发生改变");
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar setShowsCancelButton:NO];
    [self.searchBar resignFirstResponder];
    self.navigationController.navigationBarHidden = NO;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar setShowsCancelButton:NO];
    [self.searchBar resignFirstResponder];
    self.navigationController.navigationBarHidden = NO;
}



@end
