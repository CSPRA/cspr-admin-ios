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

@implementation EventsViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"Events";
  [[ICSDataManager shared]fetchEventsWithCompletion:^(BOOL success, NSArray *result, APIError *error) {
	NSLog(@"result count = %@",result);
	[result enumerateObjectsUsingBlock:^(Event *obj, NSUInteger idx, BOOL * _Nonnull stop) {
	  NSLog(@"event = %@",obj.description);
	}];
  }];
}

@end
