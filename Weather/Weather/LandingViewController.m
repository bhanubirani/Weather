//
//  LandingViewController.m
//  Weather
//
//  Created by Bhanu Birani on 22/07/15.
//  Copyright (c) 2015 Bhanu Birani. All rights reserved.
//

#import "LandingViewController.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "WeatherData.h"
#import "WeatherDetailViewController.h"

#define API_URL @"http://api.openweathermap.org/data/2.5/forecast/daily?q=Philadelphia&mode=json&units=metric&cnt=16"

#define TEMP_LABEL_TAG 101
#define DAY_LABEL_TAG 102
#define MONTH_LABEL_TAG 103
#define DESC_LABEL_TAG 104
#define IMAGEVIEW_LABEL_TAG 105
#define HUMIDITY_LABEL_TAG 106

@interface LandingViewController () {
    IBOutlet UITableView *tv;
    NSMutableArray *weatherDataArray;
}

@end

@implementation LandingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Weather";
    weatherDataArray = [[NSMutableArray alloc] init];
    tv.rowHeight = 100.0f;
    [self downloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)downloadData {
    NSURL *url = [NSURL URLWithString:API_URL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        for (NSDictionary *dict in [responseObject objectForKey:@"list"]) {
            WeatherData *data = [[WeatherData alloc] initWithDict:dict];
            [weatherDataArray addObject:data];
            [tv reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error receiving data from API"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    [operation start];
}

- (NSString *)dayString:(NSDate *)date {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd"];
    return [NSString stringWithFormat:@"%@", [dateFormat stringFromDate:date]];
}

- (NSString *)monthString:(NSDate *)date {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM"];
    return [[dateFormat stringFromDate:date] capitalizedString];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return weatherDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"weather_cell" forIndexPath:indexPath];
    WeatherData *data = [weatherDataArray objectAtIndex:indexPath.row];
    
    UILabel *day = (UILabel *)[cell viewWithTag:DAY_LABEL_TAG];
    day.text = [self dayString:data.date];
    
    UILabel *month = (UILabel *)[cell viewWithTag:MONTH_LABEL_TAG];
    month.text = [self monthString:data.date];
    
    UILabel *temp = (UILabel *)[cell viewWithTag:TEMP_LABEL_TAG];
    temp.text = [data.temprature stringValue];
    
    UILabel *desc = (UILabel *)[cell viewWithTag:DESC_LABEL_TAG];
    desc.text = [data.desc capitalizedString];
    
    UILabel *humidity = (UILabel *)[cell viewWithTag:HUMIDITY_LABEL_TAG];
    humidity.text = [NSString stringWithFormat:@"%@%%", [data.humidity stringValue]];
    
    UIImageView *iv = (UIImageView *)[cell viewWithTag:IMAGEVIEW_LABEL_TAG];
    __weak UIImageView *weakImageView = iv;
    [iv setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:data.iconURLString]]
              placeholderImage:nil
                       success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                  [weakImageView setImage:image];
                              }
                       failure:nil];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WeatherDetailViewController *wdVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WeatherDetailViewController"];
    wdVC.data = [weatherDataArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:wdVC animated:YES];
}

@end
