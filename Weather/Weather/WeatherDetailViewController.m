//
//  WeatherDetailViewController.m
//  Weather
//
//  Created by Bhanu Birani on 22/07/15.
//  Copyright (c) 2015 Bhanu Birani. All rights reserved.
//

#import "WeatherDetailViewController.h"

@interface WeatherDetailViewController () {
    IBOutlet UILabel *dictDataLabel;
    IBOutlet UILabel *dateLabel;
}

@end

@implementation WeatherDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Weather Detail";
    dateLabel.text = [self dateAndMonth:self.data.date];
    
    NSString *data = [NSString stringWithFormat:@"TEMP: Morning %@, Evening %@, Night %@, Max %@, Min %@\n\n Pressure: %@\n\nWind Speed: %@\n\n", [[self.data.origDictionary objectForKey:@"temp"] objectForKey:@"morn"], [[self.data.origDictionary objectForKey:@"temp"] objectForKey:@"eve"], [[self.data.origDictionary objectForKey:@"temp"] objectForKey:@"night"], [[self.data.origDictionary objectForKey:@"temp"] objectForKey:@"max"], [[self.data.origDictionary objectForKey:@"temp"] objectForKey:@"min"], [self.data.origDictionary objectForKey:@"pressure"], [self.data.origDictionary objectForKey:@"speed"]];
    dictDataLabel.text = data;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (NSString *)dateAndMonth:(NSDate *)date {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM"];
    NSString *monthName = [[dateFormat stringFromDate:date] uppercaseString];
    [dateFormat setDateFormat:@"dd"];
    return [NSString stringWithFormat:@"%@ %@", [dateFormat stringFromDate:date], monthName];
}

@end
