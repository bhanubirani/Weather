//
//  WeatherData.h
//  Weather
//
//  Created by Bhanu Birani on 22/07/15.
//  Copyright (c) 2015 Bhanu Birani. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherData : NSObject

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSNumber *temprature;
@property (nonatomic, strong) NSNumber *humidity;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *iconURLString;
@property (nonatomic, strong) NSDictionary *origDictionary;

- (id)initWithDict:(NSDictionary *)dict;

@end
