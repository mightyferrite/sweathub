//
//  RunsTableViewController.m
//  SweatHub
//
//  Created by John Reine on 8/29/15.
//  Copyright (c) 2015 John Reine. All rights reserved.
//

#import "RunsTableViewController.h"
#import "MathController.h"
#import "MapViewController.h"

@interface RunsTableViewController ()

@end

@implementation RunsTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andContext:(NSManagedObjectContext *)ctx
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        managedObjectContext = ctx;
        [self initDataFromManagedObject];
    }
        return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.title = @"previous.runs";
    self.navigationController.navigationBarHidden = NO;
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"new"
                                                                    style:UIBarButtonItemStyleDone target:nil action:@selector(clearAllRuns:)];
    self.navigationItem.rightBarButtonItem = rightButton;
     
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)initDataFromManagedObject
{
    NSManagedObjectContext *context = managedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Run" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    /*
    for (NSManagedObject *info in fetchedObjects)
    {
        NSLog(@"Timestamp: %@ \ndistance: %@  Duration: %@", [info valueForKey:@"timestamp"], [MathController stringifyDistance:(NSInteger)[info valueForKey:@"distance"]],[MathController stringifySecondCount:(int)[info valueForKey:@"duration"] usingLongFormat:true]);
        
        //NSManagedObject *runs = [info valueForKey:@"locations"];
        //NSLog(@"Runs: %@", [runs valueForKey:@"runs"]);
    }
    */
}

- (IBAction)clearAllRuns:(id)sender
{
   
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [fetchedObjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    
    cell.backgroundView = [[UIView alloc] init];
    [cell.backgroundView setBackgroundColor:[UIColor clearColor]];
    [[[cell contentView] subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // NSLog(@"Timestamp: %@ \ndistance: %@  Duration: %@", [info valueForKey:@"timestamp"], [MathController stringifyDistance:(NSInteger)[info valueForKey:@"distance"]],[MathController stringifySecondCount:(int)[info valueForKey:@"duration"] usingLongFormat:true]);
    
    NSManagedObject *info = [fetchedObjects objectAtIndex:indexPath.row];
    NSDate *timeStamp = [info valueForKey:@"timestamp"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [dateFormatter setDateFormat:@"EEE, d MMM yyyy hh:mm a"];
    NSString *dateString = [dateFormatter stringFromDate:timeStamp];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", dateString];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", [MathController stringifyDistance:[[info valueForKey:@"distance"] floatValue]],[MathController stringifySecondCount:[[info valueForKey:@"duration"] intValue] usingLongFormat:true]];
    //cell.detailTextLabel.text = [NSString stringWithFormat:@"Distance: %f Duration:%d", [[info valueForKey:@"distance"] floatValue],[[info valueForKey:@"duration"] intValue]];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSManagedObject *info = [fetchedObjects objectAtIndex:indexPath.row];
        [self DeleteRun:[info valueForKey:@"timestamp"]];
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView reloadData];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    NSManagedObject *info = [fetchedObjects objectAtIndex:indexPath.row];
    NSString *timeStamp = [info valueForKey:@"timestamp"];
    
    MapViewController *mapViewController = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil andContext:managedObjectContext andTimeStamp:timeStamp];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:mapViewController animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)DeleteRun:(NSString*)runID
{
    NSManagedObjectContext *context = managedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Run" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSPredicate *p=[NSPredicate predicateWithFormat:@"timestamp == %@", runID];
    [fetchRequest setPredicate:p];
    
    //... add sorts if you want them
    
    NSError *fetchError;
    NSArray *fetchedProducts=[context executeFetchRequest:fetchRequest error:&fetchError];
    
    for (NSManagedObject *product in fetchedProducts)
    {
        [context deleteObject:product];
    }
    NSError *error;
    [context save:&error];
    [self initDataFromManagedObject];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
