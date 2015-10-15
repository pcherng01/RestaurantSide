//
//  ReservationTableViewController.m
//  TestTableViewCellUI
//
//  Created by Monte's Pro 13" on 10/11/15.
//  Copyright © 2015 Pongsakorn Cherngchaosil. All rights reserved.
//

#import "ReservationTableViewController.h"
#import <Parse/Parse.h>
#import "Reservation.h"
#import "DetailViewController.h"

@interface ReservationTableViewController ()
@property NSMutableArray *reservationArray;
@end

@implementation ReservationTableViewController
{
<<<<<<< HEAD
    
=======
  
>>>>>>> 9c077ef92b8c5a3396938b5944d71794a9f12ff1
    int currentObjectCounts;
}

- (IBAction)referesh:(id)sender {
    [self loadInitialData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.reservationArray = [[NSMutableArray alloc] init];
    [self loadInitialData];
}



- (void)loadInitialData {
    PFQuery *query = [PFQuery queryWithClassName:@"ReservationList"];
    [query selectKeys:@[@"customerName"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *namesArray, NSError *error) {
        [self.reservationArray removeAllObjects];
        for (PFObject *object in namesArray) {
            currentObjectCounts = [namesArray count];
            Reservation *resvr= [[Reservation alloc]init];
            NSString *name =[object objectForKey:@"customerName"];
            resvr.name = name;
            NSLog(@"The name is: %@", resvr.name);
            [self.reservationArray addObject:resvr];
        }
        [self.tableView reloadData];
    }];
    
    query = [PFQuery queryWithClassName:@"ReservationList"];
    [query selectKeys:@[@"deviceToken"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *tokenArray, NSError *error) {
        
        for (PFObject *object in tokenArray) {
            Reservation *resvr= [[Reservation alloc]init];
            NSData *token =[object objectForKey:@"deviceToken"];
            resvr.deviceToken = token;
            NSLog(@"The token is: %@", resvr.deviceToken);
            [self.reservationArray addObject:resvr];
        }
        [self.tableView reloadData];
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [self.reservationArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ListPrototypeCell" forIndexPath:indexPath];
    
    if ( cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ListPrototypeCell"];
    }
    Reservation *resvr = [self.reservationArray objectAtIndex:indexPath.row];
    cell.textLabel.text = resvr.name;
    
    
    if (resvr.approved) {
        NSLog(@"This::%d", resvr.approved);
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    //    Reservation *resvr= [self.reservationArray objectAtIndex:indexPath.row];
    //    resvr.approved = YES;
    //    NSLog(@"This::%d", resvr.approved);
    ////    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
    //
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    if (selectedCell.accessoryType == UITableViewCellAccessoryCheckmark) {
        
        UIStoryboard *mainStry = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        DetailViewController *detailVC = [mainStry instantiateViewControllerWithIdentifier:@"DetailVC"];
        [self presentViewController:detailVC animated:YES completion:nil];
    }else {
        selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        
        //PFQuery *query = [PFQuery queryWithClassName:@"ReservationList"];
        PFInstallation *currentInstallation = [PFInstallation currentInstallation];
        NSLog(@"No error 1");
        Reservation *resvr = [self.reservationArray objectAtIndex:indexPath.row];
        NSLog(@"No error 2");
        NSData *theDeviceToken = resvr.deviceToken;
        NSLog(@"toekn: %@", theDeviceToken);
        NSLog(@"No error 3");
        NSString *dataString = [[NSString alloc]initWithData:theDeviceToken encoding:NSUTF8StringEncoding];
        [currentInstallation setDeviceToken:dataString];
        NSLog(@"No error 4");
        currentInstallation.channels = @[@"global"];
        [currentInstallation saveInBackground];
        PFQuery *pushQuery = [PFInstallation query];
<<<<<<< HEAD
        //   NSLog(@"toekn: %@", theDeviceToken);
=======
     //   NSLog(@"toekn: %@", theDeviceToken);
>>>>>>> 9c077ef92b8c5a3396938b5944d71794a9f12ff1
        [pushQuery whereKey:@"deviceType" equalTo:@"ios"];
        [PFPush sendPushMessageToQueryInBackground:pushQuery withMessage:@"Your reservation has been confirmed!"];
        NSLog(@"No error");
        
        selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //remove the deleted object from your data source.
        PFObject *object = [PFObject objectWithClassName:@"ReservationList"];
        
        [object deleteEventually];
        //If your data source is an NSMutableArray, do this
        [self.reservationArray removeObjectAtIndex:indexPath.row];
        [tableView reloadData]; // tell table to refresh now
    }
}

@end
