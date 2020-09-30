//
//  ViewController.m
//  Plist
//
//  Created by deng on 2020/6/8.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"NotesList" ofType:@"plist"];
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    
    for (NSDictionary *dict in array) {
        NSLog(@"title  : %@", dict[@"title"]);
        NSLog(@"content: %@", dict[@"content"]);
    }
}


@end
