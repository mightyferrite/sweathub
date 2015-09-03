//
//  HomeViewController.m
//  SweatHub
//
//  Created by John Reine on 8/29/15.
//  Copyright (c) 2015 John Reine. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

-(void) viewWillAppear:(BOOL)animated
{
    self.title = @"chasing.sammee";
    self.navigationController.navigationBarHidden = NO;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"shoes_post_running_Sammee" ofType:@"jpg"];
    //NSURL *url = [NSURL fileURLWithPath:path];
    backgroundImage =  [UIImage imageWithContentsOfFile:path];
    backgroundImageView = [[UIImageView alloc] initWithImage:backgroundImage];
   // [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width)
    backgroundImageView.frame = CGRectMake(0,0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    [self.view addSubview:backgroundImageView];
    
    // Do any additional setup after loading the view from its nib.
    [self addButtons];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addButtons
{
    float w = 0.0;
    float h = 0.0;
    
    startRunButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    [startRunButton setTitle:@"go for a run!" forState:UIControlStateNormal];
    [startRunButton addTarget:self action:@selector(startRunClicked:) forControlEvents:UIControlEventTouchUpInside];
    [startRunButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [[startRunButton layer] setCornerRadius:8.0f];
    [[startRunButton layer] setMasksToBounds:YES];
    [[startRunButton layer] setBorderWidth:1.0f];
    [startRunButton setBackgroundColor:[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:0.6]];
    //hideButton.translatesAutoresizingMaskIntoConstraints = NO;
    startRunButton.autoresizingMask = UIViewAutoresizingNone;
    w = 100.0;
    h = 40.0;
    startRunButton.frame = CGRectMake([self getX:50.0] - (w/2), [self getY:20.0] - h/2, w, h);
    [self.view addSubview:startRunButton];
    
    pastRunsButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    [pastRunsButton setTitle:@"view previous runs" forState:UIControlStateNormal];
    [pastRunsButton addTarget:self action:@selector(pastRunsClicked:) forControlEvents:UIControlEventTouchUpInside];
    [pastRunsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [[pastRunsButton layer] setCornerRadius:8.0f];
    [[pastRunsButton layer] setMasksToBounds:YES];
    [[pastRunsButton layer] setBorderWidth:1.0f];
    [pastRunsButton setBackgroundColor:[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:0.6]];

    //hideButton.translatesAutoresizingMaskIntoConstraints = NO;
    pastRunsButton.autoresizingMask = UIViewAutoresizingNone;
    w = 140.0;
    h = 40.0;
    pastRunsButton.frame = CGRectMake([self getX:50.0] - (w/2), [self getY:30.0] - h/2, w, h);
    [self.view addSubview:pastRunsButton];
    
}

- (IBAction)startRunClicked:(id)sender
{
    mapViewController = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil andContext:self.managedObjectContext];
    [self.navigationController pushViewController:mapViewController animated:YES];
}

- (IBAction)pastRunsClicked:(id)sender
{
    runsTableViewController = [[RunsTableViewController alloc] initWithNibName:@"RunsTableViewController" bundle:nil andContext:self.managedObjectContext];
    [self.navigationController pushViewController:runsTableViewController animated:YES];

    //[self.view addSubview:runsTableViewController.view];
}

-(NSInteger)getY:(float)percentage
{
    return [[UIScreen mainScreen] bounds].size.height*(percentage/100);
}

-(NSInteger)getX:(float)percentage
{
    return [[UIScreen mainScreen] bounds].size.width*(percentage/100);
}

@end
