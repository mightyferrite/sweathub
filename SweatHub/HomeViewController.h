//
//  HomeViewController.h
//  SweatHub
//
//  Created by John Reine on 8/29/15.
//  Copyright (c) 2015 John Reine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RunsTableViewController.h"
#import "MapViewController.h"

@interface HomeViewController : UIViewController
{
    UIButton *startRunButton;
    UIButton *pastRunsButton;
    UIImage *backgroundImage;
    UIImageView *backgroundImageView;
    RunsTableViewController *runsTableViewController;
    MapViewController *mapViewController;
}
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
