//
//  SearchBar.m
//  SearchBar
//
//  Created by deng on 2020/7/1.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "SearchBar.h"

@implementation SearchBar


- (void)drawRect:(CGRect)rect {
//    self.barTintColor = [UIColor grayColor];
     
//    self.searchTextField.backgroundColor = [UIColor whiteColor];
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitle:@"取消"];
    self.backgroundImage = [UIImage new];
}

@end
