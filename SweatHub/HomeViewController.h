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

@interface GeekImageView : UIImageView
@property CGPoint translation;
@end

@interface HomeViewController : UIViewController <UIScrollViewDelegate>
{
    UIButton *startRunButton;
    UIButton *pastRunsButton;
    UIButton *loginButton;
    UIImage *backgroundImage;
    UIProgressView *progressBar;
    GeekImageView *backgroundImageView;
    RunsTableViewController *runsTableViewController;
    MapViewController *mapViewController;
}
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;

#define MINIMUM_SCALE 0.5
#define MAXIMUM_SCALE 6.0
@property CGPoint translation;

@property (nonatomic, retain) NSString *imageLink;
@property (nonatomic, retain) UIImage *theImage;
@property (nonatomic, retain) UILabel *theLabel;
@property (nonatomic, retain) NSMutableData *resourceData;
@property (nonatomic, retain) NSNumber *filesize;

@end
