//
//  EventViewController.m
//  ICSAdmin
//
//  Created by Susmita Horrow on 20/10/15.
//  Copyright (c) 2015 GHCI-CSPR. All rights reserved.
//

#import "EventsViewController.h"
#import "ICSDataManager.h"
#import "Event.h"
#import	"EventCell.h"

@interface EventsViewController()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *eventTable;
@property (nonatomic, strong) NSArray *eventsList;

@end

@implementation EventsViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"Events";
  UINib *nib = [UINib nibWithNibName:@"EventCell" bundle:[NSBundle mainBundle]];
  [self.eventTable registerNib:nib forCellReuseIdentifier:@"eventCell"];
  self.eventTable.rowHeight = UITableViewAutomaticDimension;
  self.eventTable.estimatedRowHeight = 200.0;
  
  [[ICSDataManager shared]fetchEventsWithCompletion:^(BOOL success, NSArray *result, APIError *error) {
	NSLog(@"result count = %@",result);
	self.eventsList = [NSArray arrayWithArray:result];
	[result enumerateObjectsUsingBlock:^(Event *obj, NSUInteger idx, BOOL * _Nonnull stop) {
	  NSLog(@"event = %@",obj.description);
	}];
	[self.eventTable reloadData];
  }];
}


#pragma mark - UITableViewDatasource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.eventsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  EventCell *cell = (EventCell *)[tableView dequeueReusableCellWithIdentifier:@"eventCell"];
  [cell configureWithEvent:[self.eventsList objectAtIndex:indexPath.row]];
  return cell;
}

@end
