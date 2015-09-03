//
//  Location.h
//  SweatHub
//
//  Created by John Reine on 8/21/15.
//  Copyright (c) 2015 John Reine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Run;

@interface Location : NSManagedObject

@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) Run *run;

@end
