//
//  ViewController.m
//  CustomCell
//
//  Created by deng on 2020/6/11.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"

@interface ViewController ()

@property (strong, nonatomic) NSArray *listTeams;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"team" ofType:@"plist"];
    // 获取所有数据
    self.listTeams = [[NSArray alloc] initWithContentsOfFile:plistPath];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listTeams count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    
    NSUInteger row = [indexPath row];
    
    NSDictionary *rowDict = self.listTeams[row];
    cell.name.text = rowDict[@"name"];
    
    NSString *imageFile = rowDict[@"image"];
    NSString *imagePath = [[NSString alloc] initWithFormat:@"%@.png", imageFile];
    
    cell.image.image = [UIImage imageNamed:imagePath];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

@end
