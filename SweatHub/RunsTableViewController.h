//
//  RunsTableViewController.h
//  SweatHub
//
//  Created by John Reine on 8/29/15.
//  Copyright (c) 2015 John Reine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Run.h"
#import "Location.h"

@interface RunsTableViewController : UITableViewController
{
    NSManagedObjectContext *managedObjectContext;
    NSArray *fetchedObjects;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andContext:(NSManagedObjectContext *)ctx;

@end
