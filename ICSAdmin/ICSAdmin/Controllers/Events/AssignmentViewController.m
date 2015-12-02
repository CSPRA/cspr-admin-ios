//
//  AssignmentViewController.m
//  ICSAdmin
//
//  Created by Susmita Horrow on 02/12/15.
//  Copyright © 2015 GHCI-CSPR. All rights reserved.
//

#import "AssignmentViewController.h"
#import "ICSDataManager.h"

@interface AssignmentViewController ()

@end

@implementation AssignmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[[ICSDataManager shared] fetchAssignmentsForEvent:self.event.eventId withCompletion:^(BOOL success, id result, APIError *error) {

	}];
}

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

@end
