//
//  ViewController.m
//  TestTableViewCellUI
//
//  Created by Pongsakorn Cherngchaosil on 10/10/15.
//  Copyright © 2015 Pongsakorn Cherngchaosil. All rights reserved.
//

#import "ViewController.h"
#import "MGSwipeButton.h"
#import "MGSwipeTableCell.h"
#import <Parse/Parse.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@end

@implementation ViewController
{
   NSArray *pendingCustomers;
   NSArray *approvedCustomers;
   PFQuery *query;
   BOOL pendingTabbed;
}

- (void)viewDidLoad {
   [super viewDidLoad];
   query = [PFQuery queryWithClassName:@"CustomerObject"];
   pendingCustomers = [NSArray arrayWithObjects:[query findObjects], nil];
   NSLog(@"Printing pendingCustomers: %@", pendingCustomers);
   
   // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)indexChanged:(id)sender {
   switch (self.segmentedControl.selectedSegmentIndex) {
      case 0:
         NSLog(@"Pending");
         query = [PFQuery queryWithClassName:@"CustomerObject"];
         pendingCustomers = [NSMutableArray arrayWithObjects:[query findObjects], nil];
         pendingTabbed = true;
         [_tableView reloadData];
         break;
      case 1:
         NSLog(@"Approved");
         pendingTabbed = false;
         [_tableView reloadData];
         break;
      default:
         break;
   }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return [pendingCustomers count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   static NSString *reuseIdentifier = @"programmaticCell";
   MGSwipeTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
   if (!cell) {
      cell = [[MGSwipeTableCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
   }
   
   [pendingCustomers objectAtIndex:indexPath.row];
   NSLog(@"Printing pendingCustomers Class: %@", [[pendingCustomers objectAtIndex:indexPath.row] class]);
   cell.textLabel.text = @"Yolo";
   cell.detailTextLabel.text = @"Yolo";
   cell.delegate = self;
   
   cell.leftButtons = @[[MGSwipeButton buttonWithTitle:@"" icon:[UIImage imageNamed:@"check1-img.png"] backgroundColor:[UIColor greenColor]],
                        [MGSwipeButton buttonWithTitle:@"" icon:[UIImage imageNamed:@"delete1-img.png"] backgroundColor:[UIColor blueColor]]];
   cell.leftSwipeSettings.transition = MGSwipeTransition3D;
   
  return cell;
   
   
}



- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}

@end
