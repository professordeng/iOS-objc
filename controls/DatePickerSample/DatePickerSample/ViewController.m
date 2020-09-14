//
//  ViewController.m
//  DatePickerSample
//
//  Created by deng on 2020/6/10.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)onclick:(id)sender {
    NSDate *theDate = self.datePicker.date;
    NSLog(@"the date picked is : %@", [theDate descriptionWithLocale:[NSLocale currentLocale]]);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    NSLog(@"the date formate is : %@", [dateFormatter stringFromDate:theDate]);
    self.label.text = [dateFormatter stringFromDate:theDate];
}

@end
