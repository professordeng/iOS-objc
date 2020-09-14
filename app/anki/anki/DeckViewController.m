//
//  DeckViewController.m
//  anki
//
//  Created by deng on 2020/7/17.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "DeckViewController.h"

@interface DeckViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *myCards;

@property (strong, nonatomic) NSArray *officialCards;

@end

@implementation DeckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myCards = @[@"こんにちは", @"さようなら"];
    
    self.officialCards = @[@"あなたのことが好きです", @"おはよう", @"ランニング"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [self.myCards count];
    } else if (section == 1) {
        return [self.officialCards count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        cell.textLabel.text = self.myCards[indexPath.row];
    } else if (indexPath.section == 1) {
        cell.textLabel.text = self.officialCards[indexPath.row];
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"章节一";
    } else if (section == 1) {
        return @"章节二";
    }
    return nil;
}

@end
