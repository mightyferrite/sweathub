//
//  MathController.m
//  sweat hub
//
//  Created by John Reine on 8/16/15.
//  Copyright (c) 2015 John Reine. All rights reserved.
//

#import "MathController.h"
#import "MulticolorPolylineSegment.h"
#import "Location.h"

@implementation MathController

static bool const isMetric = NO;
static float const metersInKM = 1000;
static float const metersInMile = 1609.344;

+ (NSString *)stringifyDistance:(float)meters
{
    float unitDivider;
    NSString *unitName;
    
    // metric
    if (isMetric) {
        unitName = @"km";
        // to get from meters to kilometers divide by this
        unitDivider = metersInKM;
        // U.S.
    } else {
        unitName = @"mi";
        // to get from meters to miles divide by this
        unitDivider = metersInMile;
    }
    
    return [NSString stringWithFormat:@"%.2f %@", (meters / unitDivider), unitName];
}

+ (NSString *)stringifySecondCount:(int)seconds usingLongFormat:(BOOL)longFormat
{
    int remainingSeconds = seconds;
    int hours = remainingSeconds / 3600;
    remainingSeconds = remainingSeconds - hours * 3600;
    int minutes = remainingSeconds / 60;
    remainingSeconds = remainingSeconds - minutes * 60;
    
    if (longFormat) {
        if (hours > 0) {
            return [NSString stringWithFormat:@"%ihr %imin %isec", hours, minutes, remainingSeconds];
        } else if (minutes > 0) {
            return [NSString stringWithFormat:@"%imin %isec", minutes, remainingSeconds];
        } else {
            return [NSString stringWithFormat:@"%isec", remainingSeconds];
        }
    } else {
        if (hours > 0) {
            return [NSString stringWithFormat:@"%02i:%02i:%02i", hours, minutes, remainingSeconds];
        } else if (minutes > 0) {
            return [NSString stringWithFormat:@"%02i:%02i", minutes, remainingSeconds];
        } else {
            return [NSString stringWithFormat:@"00:%02i", remainingSeconds];
        }
    }
}

+ (NSString *)stringifyAvgPaceFromDist:(float)meters overTime:(int)seconds
{
    if (seconds == 0 || meters == 0) {
        return @"0";
    }
    
    float avgPaceSecMeters = seconds / meters;
    
    float unitMultiplier;
    NSString *unitName;
    
    // metric
    if (isMetric) {
        unitName = @"min/km";
        unitMultiplier = metersInKM;
        // U.S.
    } else {
        unitName = @"min/mi";
        unitMultiplier = metersInMile;
    }
    
    int paceMin = (int) ((avgPaceSecMeters * unitMultiplier) / 60);
    int paceSec = (int) (avgPaceSecMeters * unitMultiplier - (paceMin*60));
    
    return [NSString stringWithFormat:@"%i:%02i %@", paceMin, paceSec, unitName];
}

+ (NSArray *)colorSegmentsForLocations:(NSArray *)locations
{
    NSMutableArray *speeds = [NSMutableArray array];
    double slowestSpeed = DBL_MAX;
    double fastestSpeed = 0.0;
    
    for(int i=1; i < [locations count]; i++)
    {
        Location *first = [locations objectAtIndex:i-1];
        Location *second = [locations objectAtIndex:i];
        CLLocation *firstLocation = [[CLLocation alloc] initWithLatitude:first.latitude.doubleValue longitude:first.longitude.doubleValue];
        CLLocation *secondLocation = [[CLLocation alloc] initWithLatitude:second.latitude.doubleValue longitude:second.longitude.doubleValue];
        CLLocationDistance meters = [firstLocation distanceFromLocation:secondLocation];
        
        NSDate *firstTimeStamp = first.timestamp;
        NSDate *secondTimeStamp = second.timestamp;
        double diff = [firstTimeStamp timeIntervalSinceDate:secondTimeStamp];
        
        double speed = meters/diff;
        
        if(speed < slowestSpeed)
        {
            slowestSpeed = speed;
        }
        if(speed > fastestSpeed)
        {
            fastestSpeed = speed;
        }
        
        [speeds addObject:[NSNumber numberWithDouble:speed]];
    }

    // RGB for red (slowest)
    CGFloat r_red = 1.0f;
    CGFloat r_green = 20/255.0f;
    CGFloat r_blue = 44/255.0f;
    
    // RGB for yellow (middle)
    CGFloat y_red = 1.0f;
    CGFloat y_green = 215/255.0f;
    CGFloat y_blue = 0.0f;
    
    // RGB for green (fastest)
    CGFloat g_red = 0.0f;
    CGFloat g_green = 146/255.0f;
    CGFloat g_blue = 78/255.0f;
    
    return speeds;
    
}

@end
