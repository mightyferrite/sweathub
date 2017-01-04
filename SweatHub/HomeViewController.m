//
//  HomeViewController.m
//  SweatHub
//
//  Created by John Reine on 8/29/15.
//  Copyright (c) 2015 John Reine. All rights reserved.
//

#import "HomeViewController.h"
#import <LoginWithAmazon/LoginWithAmazon.h>


@interface HomeViewController ()

@end

@implementation HomeViewController

-(void) viewWillAppear:(BOOL)animated
{
    self.title = @"SweatHub";
    self.navigationController.navigationBarHidden = NO;
    self.scrollView.contentSize = _imageView.bounds.size;
    NSLog(@"window size =  %f  %f ", self.view.frame.size.width, self.view.frame.size.height);
    
    
    
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
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"landscape-78058_1280" ofType:@"jpg"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    self.imageView = [[UIImageView alloc] initWithImage:image];
    [self.imageView sizeToFit];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    
    [self.scrollView addSubview:self.imageView];
    [self.view addSubview:self.scrollView];
    
    _scrollView.delegate = self;
    
    [_scrollView setZoomScale:1.0];
    [_scrollView setContentOffset:CGPointMake(783.0, 250.0)];
    
    [_scrollView setScrollEnabled:false];
    
    //_scrollView.contentOffset.x = 795.0;
    //_scrollView.contentOffset.y = 193.0;
    
    /*
    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewDoubleTapped:)];
    doubleTapRecognizer.numberOfTapsRequired = 2;
    doubleTapRecognizer.numberOfTouchesRequired = 1;
    [self.scrollView addGestureRecognizer:doubleTapRecognizer];
    
    UITapGestureRecognizer *twoFingerTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTwoFingerTapped:)];
    twoFingerTapRecognizer.numberOfTapsRequired = 1;
    twoFingerTapRecognizer.numberOfTouchesRequired = 2;
    [self.scrollView addGestureRecognizer:twoFingerTapRecognizer];
    */
    
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
    
    loginButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    [loginButton setTitle:@"login" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginClicked:) forControlEvents:UIControlEventTouchUpInside];
    [loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [[loginButton layer] setCornerRadius:8.0f];
    [[loginButton layer] setMasksToBounds:YES];
    [[loginButton layer] setBorderWidth:1.0f];
    [loginButton setBackgroundColor:[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:0.6]];
    
    //hideButton.translatesAutoresizingMaskIntoConstraints = NO;
    loginButton.autoresizingMask = UIViewAutoresizingNone;
    w = 80.0;
    h = 35.0;
    loginButton.frame = CGRectMake([self getX:83.0] - (w/2), [self getY:95.0] - h/2, w, h);
    [self.view addSubview:loginButton];
    
}
- (IBAction)loginClicked:(id)sender
{

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
}

-(NSInteger)getY:(float)percentage
{
    return [[UIScreen mainScreen] bounds].size.height*(percentage/100);
}

-(NSInteger)getX:(float)percentage
{
    return [[UIScreen mainScreen] bounds].size.width*(percentage/100);
}
/*
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize image:(UIImage*)sourceImage
{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
        {
            scaleFactor = widthFactor; // scale to fit height
        }
        else
        {
            scaleFactor = heightFactor; // scale to fit width
        }
        
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
        {
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
        }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil)
    {
        //NSLog(@"could not scale image");
    }
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    
    return newImage;
}
*/

- (void)centerScrollViewContents
{
    CGSize boundsSize = self.scrollView.bounds.size;
    CGRect contentsFrame = self.imageView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    self.imageView.frame = contentsFrame;
}

/*
- (void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer
{
    // 1
    CGPoint pointInView = [recognizer locationInView:self.imageView];
    
    // 2
    CGFloat newZoomScale = self.scrollView.zoomScale * 1.5f;
    newZoomScale = MIN(newZoomScale, self.scrollView.maximumZoomScale);
    
    // 3
    CGSize scrollViewSize = self.scrollView.bounds.size;
    
    CGFloat w = scrollViewSize.width / newZoomScale;
    CGFloat h = scrollViewSize.height / newZoomScale;
    CGFloat x = pointInView.x - (w / 2.0f);
    CGFloat y = pointInView.y - (h / 2.0f);
    
    CGRect rectToZoomTo = CGRectMake(x, y, w, h);
    
    // 4
    [self.scrollView zoomToRect:rectToZoomTo animated:YES];
}

- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer*)recognizer
{
    // Zoom out slightly, capping at the minimum zoom scale specified by the scroll view
    CGFloat newZoomScale = self.scrollView.zoomScale / 1.5f;
    newZoomScale = MAX(newZoomScale, self.scrollView.minimumZoomScale);
    [self.scrollView setZoomScale:newZoomScale animated:YES];
}
*/
- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    NSLog(@"viewForZoomingInScrollView");
    // Return the view that you want to zoom
    return self.imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    NSLog(@"end zooming scale= %f", scale);
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"scrollViewDidEndDragging %f  %f ",scrollView.contentOffset.x, scrollView.contentOffset.y);
  
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndDecelerating %f  %f ",scrollView.contentOffset.x, scrollView.contentOffset.y);
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndScrollingAnimation");
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidZoom");
}

- (CGRect)centeredFrameForScrollView:(UIScrollView *)scroll andUIView:(UIView *)rView
{
    NSLog(@"centeredFrameForScrollView");
    CGSize boundsSize = scroll.bounds.size;
    CGRect frameToCenter = rView.frame;
    // center horizontally
    if (frameToCenter.size.width < boundsSize.width) {
        frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2;
    }
    else {
        frameToCenter.origin.x = 0;
    }
    // center vertically
    if (frameToCenter.size.height < boundsSize.height) {
        frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2;
    }
    else {
        frameToCenter.origin.y = 0;
    }
    return frameToCenter;
}

@end


@implementation GeekImageView

@end

