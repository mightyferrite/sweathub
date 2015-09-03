//
//  MulticolorPolylineSegment.h
//  SweatHub
//
//  Created by John Reine on 8/30/15.
//  Copyright (c) 2015 John Reine. All rights reserved.
//

#ifndef SweatHub_MulticolorPolylineSegment_h
#define SweatHub_MulticolorPolylineSegment_h

#import <MapKit/MapKit.h>

@interface MulticolorPolylineSegment : MKPolyline

@property (strong, nonatomic) UIColor *color;

@end

#endif
