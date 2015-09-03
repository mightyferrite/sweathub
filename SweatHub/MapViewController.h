//
//  ViewController.h
//  SweatHub
//
//  Created by John Reine on 8/21/15.
//  Copyright (c) 2015 John Reine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapboxGL/MapboxGL.h>
#import "Run.h"
#import "Location.h"
#import "RunsTableViewController.h"

@interface MapViewController : UIViewController <MGLMapViewDelegate>
{
    UIButton *hideMapButton;
    UIButton *startRunButton;
    UIButton *pastRunsButton;
    UILabel *runTimeLabel;
    UILabel *runDistanceLabel;
    UILabel *runPaceLabel;
    UILabel *debugLabel;
    
    RunsTableViewController *runsTableViewController;
    
    NSTimer *runningDisplayUpdateTimer;
    NSInteger seconds;
    float distance;
    bool running;
    bool displayPreviousRun;
    NSString *debugLabelString;
    CLLocationCoordinate2D previousCoordinate;
    Run *run;
    NSMutableArray *locations;
    NSString *timeStampForCurrentRun;
}

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSMutableArray *locations;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andContext:(NSManagedObjectContext *)ctx;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andContext:(NSManagedObjectContext *)ctx andTimeStamp:(NSString *)timestamp;
@end

