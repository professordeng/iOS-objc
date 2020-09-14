//
//  ViewController.m
//  DynamicTableView
//
//  Created by leon on 08/07/2020.
//  Copyright © 2020 Maimemo Inc. All rights reserved.
//

#import "ViewController.h"
#import "DynamicCell.h"
#import "DynamicCell2.h"
#import "RandomTextGenerator.h"


@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak  ) UITableView *tableView;
@property (nonatomic, strong) DynamicCell2 *prototypeCell;  // prototype cell for calculating manual layout cell height
@property (nonatomic, copy  ) NSArray <NSString *> *contents;
@property (nonatomic, copy  ) NSArray <NSArray <NSString *> *> *tags;
@property (nonatomic, strong) NSMutableDictionary <NSNumber *, NSNumber *> *cellHeights;   // cell heights cache

@end


@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self generateDummyData];

    UITableView *tableView = UITableView.new;
    [self.view addSubview:tableView];
    [self setTableView:tableView];

    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass(DynamicCell.class) bundle:nil]
    forCellReuseIdentifier:NSStringFromClass(DynamicCell.class)];
    [tableView registerClass:DynamicCell2.class forCellReuseIdentifier:NSStringFromClass(DynamicCell2.class)];
    [tableView setTableFooterView:UIView.new];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [tableView setInsetsContentViewsToSafeArea:YES];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    tableView.hidden = YES;

    self.cellHeights = NSMutableDictionary.dictionary;
    self.prototypeCell =
        [[DynamicCell2 alloc] initWithStyle:UITableViewCellStyleDefault
                            reuseIdentifier:NSStringFromClass(DynamicCell2.class)];

}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    /*
     *  The estimation of cell height is based on intrinsic contentsize of TagView inside a cell,
     *  its calculation in the very first pass of UI layout is wrong due to incorrect view width.
     *  Reloading table view after constraints being satisfied will correct the intrinsic contentsize
     *  of TagView thus provide an accurate estimate of cell height.
     *  viewDidAppear seems to be the most appropriate place to reload tableview, but should only do so
     *  for the first time view did appear for performance reason.
     */
    if (self.tableView.isHidden) {
        [self reloadTable];
        self.tableView.hidden = NO;
    }
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}


- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    /*
     *  When rotation is detected, reload tableview to invalidate intrinsic contentsize of TagViews
     *  (through -prepareForReuse in a cell).
     *  Cell height will be then re-estimated before layout.
     */
    [self reloadTable];
}


- (void)reloadTable {
    /*
     *  clear cell heights cache on table reload
     *  call this method insteal of [self.tableView reloadData]
     */
    [self.cellHeights removeAllObjects];
    [self.tableView reloadData];
}


#pragma mark -


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contents.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 == 0) {
        DynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(DynamicCell.class)
                                                            forIndexPath:indexPath];
        [cell setContent:self.contents[indexPath.row]];
        [cell setTags:self.tags[indexPath.row]];
        return cell;
    } else {
        DynamicCell2 *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(DynamicCell2.class)
                                                             forIndexPath:indexPath];
        [cell setContent:self.contents[indexPath.row]];
        [cell setTags:self.tags[indexPath.row]];
        return cell;
    }
}


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 == 0) {
        return UITableViewAutomaticDimension;
    }
    if (!self.cellHeights[@(indexPath.row)]) {
        // calculate and cache cell height if needed
        [self.prototypeCell setContent:self.contents[indexPath.row]];
        [self.prototypeCell setTags:self.tags[indexPath.row]];
        // be careful of safeAreaInsets
        [self.prototypeCell setBounds:CGRectMake(0,
                                                 0,
                                                 tableView.frame.size.width - self.view.safeAreaInsets.left -
                                                    self.view.safeAreaInsets.right,
                                                 self.prototypeCell.frame.size.height)];
        [self.prototypeCell setNeedsLayout];
        [self.prototypeCell layoutIfNeeded];
        self.cellHeights[@(indexPath.row)] = @(self.prototypeCell.contentView.frame.size.height);
    }
    return [self.cellHeights[@(indexPath.row)] floatValue];
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // be careful of safeAreaInsets
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 10 + self.view.safeAreaInsets.left, 0, 10 + self.view.safeAreaInsets.right);
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:insets];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:insets];
    }
}


#pragma mark -


- (void)generateDummyData {
    int count = 12;
    NSMutableArray *contents = NSMutableArray.array;
    for (int i = 0; i < count; i++) {
        [contents addObject:[RandomTextGenerator text:arc4random_uniform(1000) + 50]];
    }
    self.contents = contents.copy;

    NSMutableArray *tags = NSMutableArray.array;
    for (int i = 0; i < count; i++) {
        NSMutableArray *tag = NSMutableArray.array;
        for (int j = 0; j < arc4random_uniform(10) + 5; j++) {
            [tag addObject:[NSString stringWithFormat:@"%ld. %@",
                            (long)j + 1,
                            [RandomTextGenerator text:arc4random_uniform(20) + 5]]];
        }
        [tags addObject:tag.copy];
    }
    self.tags = tags.copy;
}


@end
