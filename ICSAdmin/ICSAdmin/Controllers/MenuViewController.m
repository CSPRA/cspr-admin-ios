//
//  MenuViewController.m
//  ICSAdmin
//
//  Created by Susmita Horrow on 20/10/15.
//  Copyright (c) 2015 GHCI-CSPR. All rights reserved.
//

#import "MenuViewController.h"
#import "AppDelegate.h"

@interface MenuViewController()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property (strong, nonatomic) NSArray *menuArray;

@end

@implementation MenuViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self configureDataSource];
}

- (void)configureDataSource {
  self.menuArray = [NSArray arrayWithObjects:@"Dashboard",@"Create Event", @"Approve Volunteers",@"Approve Doctors",
  @"Assign Volunteers",@"Assign Doctors",@"Profile",@"Logout", nil];
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.menuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menuCell"];
  cell.textLabel.text = [self.menuArray objectAtIndex:indexPath.row];
  return cell;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
  UINavigationController *navVC = (UINavigationController *)appDelegate.slidingMenuContainer.mainViewController;


  switch (indexPath.row) {
	case 0: {
	  UIViewController *vc =  [self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
	  [navVC setViewControllers:@[vc]];
	 	  break;
	  }
	  
	case 1: {
	  UIViewController *vc =  [self.storyboard instantiateViewControllerWithIdentifier:@"EventVC"];
	  [navVC setViewControllers:@[vc]];
	  break;
	}
	case 2: {
	  UIViewController *vc =  [self.storyboard instantiateViewControllerWithIdentifier:@"VolunteerVC"];
	  [navVC setViewControllers:@[vc]];

	}
	default:
	  break;
  }
}
@end
