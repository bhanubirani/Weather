//
//  WeatherData.m
//  Weather
//
//  Created by Bhanu Birani on 22/07/15.
//  Copyright (c) 2015 Bhanu Birani. All rights reserved.
//

#import "WeatherData.h"

@implementation WeatherData

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        NSNumber *timestamp = [dict objectForKey:@"dt"];
        self.date = [self dateFromMillis:timestamp];
        self.temprature = [[dict objectForKey:@"temp"] objectForKey:@"day"];
        self.humidity = [dict objectForKey:@"humidity"];
        self.desc = [[[dict objectForKey:@"weather"] objectAtIndex:0] objectForKey:@"description"];
        self.iconURLString = [NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png", [[[dict objectForKey:@"weather"] objectAtIndex:0] objectForKey:@"icon"]];
        self.origDictionary = dict;
    }
    return self;
}

- (NSDate *)dateFromMillis:(NSNumber *)number {
    return [NSDate dateWithTimeIntervalSince1970:[number longLongValue]];
}

@end
