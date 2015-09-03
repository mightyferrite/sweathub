//
//  MathController.h
//  sweat hub
//
//  Created by John Reine on 8/16/15.
//  Copyright (c) 2015 John Reine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MathController : NSObject

+ (NSString *)stringifyDistance:(float)meters;
+ (NSString *)stringifySecondCount:(int)seconds usingLongFormat:(BOOL)longFormat;
+ (NSString *)stringifyAvgPaceFromDist:(float)meters overTime:(int)seconds;

+ (NSArray *)colorSegmentsForLocations:(NSArray *)locations;

@end
