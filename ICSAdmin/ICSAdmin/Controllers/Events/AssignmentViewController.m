//
//  AssignmentViewController.m
//  ICSAdmin
//
//  Created by Susmita Horrow on 02/12/15.
//  Copyright © 2015 GHCI-CSPR. All rights reserved.
//

#import "AssignmentViewController.h"
#import "ICSDataManager.h"

@interface AssignmentViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *assignedVolunteers;
@property (nonatomic, strong) NSMutableArray *freeVolunteers;
@property (weak, nonatomic) IBOutlet UITableView *volunteerTableView;
@property (nonatomic, strong) UIBarButtonItem *barButton;

@end

@implementation AssignmentViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupFavoriteButton];
  self.assignedVolunteers = [NSMutableArray array];
  self.freeVolunteers = [NSMutableArray array];

  	__block AssignmentViewController *weakSelf = self;
	[[ICSDataManager shared] fetchAssignmentsForEvent:self.event.eventId withCompletion:^(BOOL success, NSArray *result, APIError *error) {
	  NSArray *info = [result.firstObject objectForKey:@"result"];
	 [info enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
	   NSDictionary *volunteer = [obj objectForKey:@"volunteer"];
	   [weakSelf.assignedVolunteers addObject:volunteer];
	   [weakSelf.volunteerTableView reloadData];
	 }];
	}];

	[[ICSDataManager shared] fetchFreeVolunteersWithCompletion:^(BOOL success, NSArray *result, APIError *error) {
	  NSArray *info = [result.firstObject objectForKey:@"result"];
	  [info enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
		NSDictionary *volunteer = [obj objectForKey:@"volunteer"];
		[weakSelf.freeVolunteers addObject:volunteer];
		[weakSelf.volunteerTableView reloadData];
	  }];
	}];
}

- (void)setupFavoriteButton {
  UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithTitle:@"Assign" style:UIBarButtonItemStylePlain target:self action:@selector(assign)];
  self.navigationItem.rightBarButtonItem = barButton;
}

//- (void)assign {
//  NSIndexPath *selectedPath = [self.volunteerTableView indexPathForSelectedRow];
//  if (selectedPath.section == 1) {
//	NSDictionary *info = [self.freeVolunteers objectAtIndex:selectedPath.row];
//	NSDictionary *param = @{@"eventId": self.event.eventId, @"volunteerId": [info objectForKey:@"id"], @"startingDate" };
//  }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  switch (section) {
	case 0:
	  return self.assignedVolunteers.count;
	case 1:
	  return self.freeVolunteers.count;
	default:
	  return 0;
  }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"volunteerCell"];
  NSDictionary *info;
  switch (indexPath.section) {
	case 0: {
	 	info = [self.assignedVolunteers objectAtIndex:indexPath.row];
		break;
		}
	case 1: {
	 	info = [self.freeVolunteers objectAtIndex:indexPath.row];
		break;
	}
	default:
	  break;
  }
  NSString *name = [info objectForKey:@"name"];
  cell.textLabel.text = name;
  return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  switch (section) {
	case 0:
		return @"Volunteers Assigned";
	case 1:
		return @"Volunteers Not Assigned";
	default:
	  	return @"";
  }
}

@end
