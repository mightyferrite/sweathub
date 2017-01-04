//
//  ViewController.m
//  SweatHub
//
//  Created by John Reine on 8/21/15.
//  Copyright (c) 2015 John Reine. All rights reserved.
//

#import "MapViewController.h"
#import "MathController.h"

@interface MapViewController () <MGLMapViewDelegate>
@property (nonatomic) MGLMapView *mapView;

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andContext:(NSManagedObjectContext *)ctx
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        _managedObjectContext = ctx;
        displayPreviousRun = false;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andContext:(NSManagedObjectContext *)ctx andTimeStamp:(NSString *)timestamp
{
    self = [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil andContext:ctx];
    if (self)
    {
        timeStampForCurrentRun = timestamp;
        [self loadRun:timestamp];
        displayPreviousRun = true;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.title = @"current.run";
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    running = false;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    _mapView = [[MGLMapView alloc] initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    NSLog(@"resolution is: x=%f  y=%f", [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width);
    NSLog(@"middle is : x=%ld  y=%ld", (long)[self getX:50.0], (long)[self getY:50.0]);
    [_mapView setUserTrackingMode:MGLUserTrackingModeFollow];
    [self.view addSubview:self.mapView];
    [self addButtons];
    

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(displayPreviousRun)
    {
        [self drawCurrentRunOnMap];
    }
}

-(NSInteger)getY:(float)percentage
{
    return [[UIScreen mainScreen] bounds].size.height*(percentage/100);
}

-(NSInteger)getX:(float)percentage
{
    return [[UIScreen mainScreen] bounds].size.width*(percentage/100);
}

-(void)addButtons
{
    hideMapButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    [hideMapButton setTitle:@"hide map" forState:UIControlStateNormal];
    [hideMapButton addTarget:self action:@selector(hideButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [[hideMapButton layer] setCornerRadius:8.0f];
    [[hideMapButton layer] setMasksToBounds:YES];
    [[hideMapButton layer] setBorderWidth:1.0f];

    //hideButton.translatesAutoresizingMaskIntoConstraints = NO;
    hideMapButton.autoresizingMask = UIViewAutoresizingNone;
    float w = 100.0;
    float h = 30.0;
    hideMapButton.hidden = true;
    hideMapButton.frame = CGRectMake([self getX:50.0] - (w/2), [self getY:97.0] - h/2, w, h);;
    [self.view addSubview:hideMapButton];

    startRunButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    [startRunButton setTitle:@"start run" forState:UIControlStateNormal];
    [startRunButton addTarget:self action:@selector(startRunClicked:) forControlEvents:UIControlEventTouchUpInside];
    [startRunButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [[startRunButton layer] setCornerRadius:8.0f];
    [[startRunButton layer] setMasksToBounds:YES];
    [[startRunButton layer] setBorderWidth:1.0f];
    [startRunButton setBackgroundColor:[UIColor greenColor]];
    //hideButton.translatesAutoresizingMaskIntoConstraints = NO;
    startRunButton.autoresizingMask = UIViewAutoresizingNone;
    w = 100.0;
    h = 40.0;
    startRunButton.frame = CGRectMake([self getX:50.0] - (w/2), [self getY:20.0] - h/2, w, h);
    [self.view addSubview:startRunButton];
    
    pastRunsButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    [pastRunsButton setTitle:@"previous runs" forState:UIControlStateNormal];
    [pastRunsButton addTarget:self action:@selector(pastRunsClicked:) forControlEvents:UIControlEventTouchUpInside];
    [pastRunsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [[pastRunsButton layer] setCornerRadius:8.0f];
    [[pastRunsButton layer] setMasksToBounds:YES];
    [[pastRunsButton layer] setBorderWidth:1.0f];
    [pastRunsButton setBackgroundColor:[UIColor greenColor]];
    //hideButton.translatesAutoresizingMaskIntoConstraints = NO;
    pastRunsButton.autoresizingMask = UIViewAutoresizingNone;
    pastRunsButton.hidden = false;
    w = 120.0;
    h = 40.0;
    pastRunsButton.frame = CGRectMake([self getX:50.0] - (w/2), [self getY:90.0] - h/2, w, h);
    [self.view addSubview:pastRunsButton];

    runTimeLabel = [[UILabel alloc] init];
    w = 200.0;
    h = 40.0;
    runTimeLabel.frame = CGRectMake([self getX:50.0] - (w/2), [self getY:30.0] - h/2, w, h);;
    [runTimeLabel setText:@""];//Set text in label.
    [runTimeLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:36]];
    [runTimeLabel setTextColor:[UIColor blackColor]];//Set text color in label.
    [runTimeLabel setTextAlignment:NSTextAlignmentCenter];//Set text alignment in label.
    [runTimeLabel setClipsToBounds:YES];//Set its to YES for Corner radius to work.
    [self.view addSubview:runTimeLabel];//Add it to the view of your choice.
    
    runDistanceLabel = [[UILabel alloc] init];
    w = 300.0;
    h = 40.0;
    runDistanceLabel.frame = CGRectMake([self getX:50.0] - (w/2), [self getY:40.0] - h/2, w, h);;
    [runDistanceLabel setText:@""];//Set text in label.
    [runDistanceLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:36]];
    [runDistanceLabel setTextColor:[UIColor blackColor]];//Set text color in label.
    [runDistanceLabel setTextAlignment:NSTextAlignmentCenter];//Set text alignment in label.
    [runDistanceLabel setClipsToBounds:YES];//Set its to YES for Corner radius to work.
    [self.view addSubview:runDistanceLabel];//Add it to the view of your choice.
    
    runPaceLabel = [[UILabel alloc] init];
    w = 300.0;
    h = 40.0;
    runPaceLabel.frame = CGRectMake([self getX:50.0] - (w/2), [self getY:35.0] - h/2, w, h);;
    [runPaceLabel setText:@""];//Set text in label.
    [runPaceLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:36]];
    [runPaceLabel setTextColor:[UIColor blackColor]];//Set text color in label.
    [runPaceLabel setTextAlignment:NSTextAlignmentCenter];//Set text alignment in label.
    [runPaceLabel setClipsToBounds:YES];//Set its to YES for Corner radius to work.
    [self.view addSubview:runPaceLabel];//Add it to the view of your choice.
}

-(void)runningTimerTick:(NSTimer*)timer
{
    [self updateRunTimeDisplay];
}

-(void)updateRunTimeDisplay
{
    seconds++;
    NSInteger minutesRunning = seconds / 60;
    if(minutesRunning > 60)
    {
        NSInteger hoursRunning = minutesRunning / 60;
        minutesRunning = minutesRunning % 60;
        NSInteger remainingSeconds = seconds % 60;
        runTimeLabel.text = [NSString stringWithFormat:@"%ld:%.02ld:%.02ld",(long)hoursRunning,(long)minutesRunning, (long)remainingSeconds];
    }
    else
    {
        NSInteger remainingSeconds = seconds % 60;
        runTimeLabel.text = [NSString stringWithFormat:@"%.02ld:%.02ld",(long)minutesRunning, (long)remainingSeconds];
    }
    runDistanceLabel.text = [NSString stringWithFormat:@"%@", [MathController stringifyDistance:distance]];
    runPaceLabel.text = [NSString stringWithFormat:@"%@",  [MathController stringifyAvgPaceFromDist:distance overTime:(int)seconds]];
}

- (IBAction)hideButtonClicked:(id)sender
{
    _mapView.hidden = !_mapView.hidden;
}

- (IBAction)pastRunsClicked:(id)sender
{
    runsTableViewController = [[RunsTableViewController alloc] initWithNibName:@"RunsTableViewController" bundle:nil andContext:self.managedObjectContext];
    [self.view addSubview:runsTableViewController.view];
}

- (IBAction)startRunClicked:(id)sender
{
    if(running)
    {
        running = false;
        [runningDisplayUpdateTimer invalidate];
        [startRunButton setBackgroundColor:[UIColor greenColor]];
        [startRunButton setTitle:@"start run" forState:UIControlStateNormal];
        [self saveRun];
        [self drawCurrentRunOnMap];
    }
    else
    {
        running = true;
        [startRunButton setBackgroundColor:[UIColor redColor]];
        [startRunButton setTitle:@"end run" forState:UIControlStateNormal];
        _locations = [NSMutableArray array];
        seconds = 0;
        distance = 0;
        runningDisplayUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                                     target:self
                                                                   selector:@selector(runningTimerTick:)
                                                                   userInfo:nil
                                                                    repeats:YES];
        
        runPaceLabel.hidden = false;
        runTimeLabel.hidden = false;
        runDistanceLabel.hidden = false;
        [self updateRunTimeDisplay];
    }
}

- (BOOL)mapView:(MGLMapView *)mapView annotationCanShowCallout:(id <MGLAnnotation>)annotation
{
    return YES;
}

- (void)mapView:(MGLMapView *)mapView didChangeUserTrackingMode:(MGLUserTrackingMode)mode animated:(BOOL)animated
{
    
}

- (void)mapViewWillStartLocatingUser:(MGLMapView *)mapView
{
    debugLabelString = [NSString stringWithFormat:@"%@%@", debugLabelString,
                        @"mapViewWillStartLocatingUser\n"];
    //_debugLabel.text = debugLabelString;
}

- (void)mapViewDidStopLocatingUser:(MGLMapView *)mapView
{
    debugLabelString = [NSString stringWithFormat:@"%@%@", debugLabelString,
                        @"mapViewDidStopLocatingUser\n"];
    //_debugLabel.text = debugLabelString;
}
- (nullable MGLAnnotationImage *)mapView:(MGLMapView *)mapView imageForAnnotation:(id <MGLAnnotation>)annotation
{
    return nil;
}
- (UIColor *)mapView:(MGLMapView *)mapView fillColorForPolygonAnnotation:(MGLPolygon *)annotation
{
    return [UIColor grayColor];
}
- (CGFloat)mapView:(MGLMapView *)mapView lineWidthForPolylineAnnotation:(MGLPolyline *)annotation
{
    return 3.0;
}
- (UIColor *)mapView:(MGLMapView *)mapView strokeColorForShapeAnnotation:(MGLShape *)annotation
{
    return [UIColor blackColor];
}

- (CGFloat)mapView:(MGLMapView *)mapView alphaForShapeAnnotation:(MGLShape *)annotation;
{
    return 1.0;
}

- (void)mapView:(MGLMapView *)mapView didUpdateUserLocation:(nullable MGLUserLocation *)userLocation
{
    debugLabelString = [NSString stringWithFormat:@"lat=%f long=%f\n",
                        userLocation.coordinate.latitude, userLocation.coordinate.longitude];
    //NSLog(@"%@", debugLabelString);
    if(running && userLocation.location.horizontalAccuracy < 20)
    {
        [self.mapView setCenterCoordinate:userLocation.coordinate zoomLevel:16 animated:NO];
        if (_locations.count > 0)
        {
            distance += [userLocation.location distanceFromLocation:_locations.lastObject];
        }
        else  //it's the first time running
        {
            previousCoordinate = userLocation.coordinate;
        }
        
        [_locations addObject:userLocation.location];
        
        CLLocationCoordinate2D coordinates[2];
        coordinates[0] = userLocation.coordinate;
        coordinates[1] = previousCoordinate;
        
        [self.mapView addAnnotation:[MGLPolyline polylineWithCoordinates:coordinates count:2]];
        
        previousCoordinate = userLocation.coordinate;
    }
}

- (void)mapView:(MGLMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    debugLabelString = [NSString stringWithFormat:@"%@%@%@", debugLabelString,
                        @"didFailToLocateUserWithError:  \n", [error userInfo]];
    //_debugLabel.text = debugLabelString;
}

- (void)saveRun
{
    Run *newRun = [NSEntityDescription insertNewObjectForEntityForName:@"Run"
                                                inManagedObjectContext:_managedObjectContext];
    newRun.distance = [NSNumber numberWithFloat:distance];
    newRun.duration = [NSNumber numberWithInt:(int)seconds];
    newRun.timestamp = [NSDate date];
    
    NSMutableArray *locationArray = [NSMutableArray array];
    for (CLLocation *location in _locations)
    {
        Location *locationObject = [NSEntityDescription insertNewObjectForEntityForName:@"Location"
                                                                 inManagedObjectContext:self.managedObjectContext];
        
        locationObject.timestamp = location.timestamp;
        locationObject.latitude = [NSNumber numberWithDouble:location.coordinate.latitude];
        locationObject.longitude = [NSNumber numberWithDouble:location.coordinate.longitude];
        [locationArray addObject:locationObject];
    }
    //NSSet *tempSet = [NSSet setByAddingObjectsFromArray:locationArray];
    NSSet *tempSet = [NSSet setWithArray:locationArray];
    
    newRun.locations = tempSet;
    run = newRun;
    
    // Save the context.
    NSError *error = nil;
    if (![self.managedObjectContext save:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

- (MGLPolyline *)polyLine
{
    NSArray *locationsArray = [run.locations allObjects];
    // unpacking an array of NSValues into memory
    CLLocationCoordinate2D *points = malloc([locationsArray count] * sizeof(CLLocationCoordinate2D));
    for(int i = 0; i < [locationsArray count]; i++)
    {
        Location *location = [locationsArray objectAtIndex:i];
        double lat = location.latitude.doubleValue;
        double lon = location.longitude.doubleValue;
        points[i] = CLLocationCoordinate2DMake(lat, lon);
    }
    
    return [MGLPolyline polylineWithCoordinates:points count:[locationsArray count]];

}

- (void)loadRun:(NSString*)timeStampID
{
    NSManagedObjectContext *context = _managedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Run" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSPredicate *p=[NSPredicate predicateWithFormat:@"timestamp == %@", timeStampID];
    [fetchRequest setPredicate:p];
    
    //... add sorts if you want them
    
    NSError *fetchError;
    NSArray *fetchedProducts=[context executeFetchRequest:fetchRequest error:&fetchError];
    if([fetchedProducts count] > 1)
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:@"more than 1 result from timestamp lookup"
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
    else if([fetchedProducts count] == 0)
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:@"no results from timestamp lookup"
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];

    }
    else
    {
        run = [fetchedProducts objectAtIndex:0];
        seconds = [[run valueForKey:@"duration"] integerValue];
        distance = [[run valueForKey:@"distance"] floatValue];
        
        locations = [NSMutableArray arrayWithArray:[[run valueForKey:@"locations"] allObjects]];
    }
}

- (void)drawCurrentRunOnMap
{
    
   // NSArray *locationsArray = [run.locations allObjects];
    if (run.locations.count > 0)
    {
        self.mapView.hidden = NO;
        
        NSArray *locationsArray = [run.locations allObjects];
        NSUInteger numPoints = [locationsArray count];
        // unpacking an array of NSValues into memory
        CLLocationCoordinate2D *points = malloc(numPoints * sizeof(CLLocationCoordinate2D));
        
        NSSortDescriptor *sortDescriptor;
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timestamp"
                                                     ascending:YES];
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        NSArray *sortedArray;
        sortedArray = [locationsArray sortedArrayUsingDescriptors:sortDescriptors];
        
        for(int i = 0; i < numPoints; i++)
        {
            Location *location = [sortedArray objectAtIndex:i];
            points[i] = CLLocationCoordinate2DMake(location.latitude.doubleValue, location.longitude.doubleValue);
        }
        MGLPolyline *lines = [MGLPolyline polylineWithCoordinates:points count:[locationsArray count]];
        free(points);
        [self.mapView addAnnotation:lines];
        
    }
    else
    {
        
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:@"Sorry, this run has no locations saved."
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
     
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
