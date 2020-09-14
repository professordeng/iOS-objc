//
//  NoteListViewController.m
//  CustomSearchBar
//
//  Created by deng on 2020/7/14.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "NoteListViewController.h"

@interface NoteListViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightSearchTextField;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation NoteListViewController

- (void)dealloc {
    NSLog(@"__%@__dealloc__", self.class);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%f", self.view.safeAreaInsets.bottom);
}

- (IBAction)clickCancelButton:(id)sender {
    self.rightSearchTextField.constant = 8;
    [self.searchTextField resignFirstResponder];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.rightSearchTextField.constant = 56;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"%f", self.view.safeAreaInsets.bottom);
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, self.view.safeAreaInsets.bottom, 0);
}

@end
