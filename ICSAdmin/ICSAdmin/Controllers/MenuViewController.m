//
//  MenuViewController.m
//  ICSAdmin
//
//  Created by Susmita Horrow on 20/10/15.
//  Copyright (c) 2015 GHCI-CSPR. All rights reserved.
//

#import "MenuViewController.h"
#import "AppDelegate.h"
#import "CustomNavigationController.h"

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
  CustomNavigationController *navVC = (CustomNavigationController *)appDelegate.slidingMenuContainer.mainViewController;

  UIViewController *selectedController;
  switch (indexPath.row) {
	case 0: {
	  selectedController =  [self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
	  break;
	}
	  
	case 1: {
	  selectedController =  [self.storyboard instantiateViewControllerWithIdentifier:@"EventVC"];
	  break;
	}
	
	case 2: {
	  selectedController =  [self.storyboard instantiateViewControllerWithIdentifier:@"VolunteerVC"];
	  break;
	}
	
	default:
	  break;
   }
	
	[navVC setViewControllers:@[selectedController]];
  
	if ([navVC.slidingDelegate respondsToSelector:@selector(toggleLeftMenu)]) {
	  [navVC.slidingDelegate toggleLeftMenu];
	}
}
@end
