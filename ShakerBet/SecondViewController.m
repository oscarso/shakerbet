//
//  SecondViewController.m
//  ShakerBet
//
//  Created by Oscar So on 7/12/14.
//  Copyright (c) 2014 OscarSoft.co. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelYear;
@property (weak, nonatomic) IBOutlet UIDatePicker *pickerDate;
@property (weak, nonatomic) IBOutlet UIButton *timeNow;
@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pickerDate.date = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:self.pickerDate.date];
    
    [self.labelYear setText: [NSString stringWithFormat:@"%ld", ((long)[components year])]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressed:(id)sender {
    self.pickerDate.date = [NSDate date];
}

@end
