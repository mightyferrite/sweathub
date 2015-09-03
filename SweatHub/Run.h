//
//  Run.h
//  SweatHub
//
//  Created by John Reine on 8/21/15.
//  Copyright (c) 2015 John Reine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface Run : NSManagedObject

@property (nonatomic, retain) NSNumber * distance;
@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSSet *locations;
@end

@interface Run (CoreDataGeneratedAccessors)

- (void)addLocationsObject:(NSManagedObject *)value;
- (void)removeLocationsObject:(NSManagedObject *)value;
- (void)addLocations:(NSSet *)values;
- (void)removeLocations:(NSSet *)values;

@end
