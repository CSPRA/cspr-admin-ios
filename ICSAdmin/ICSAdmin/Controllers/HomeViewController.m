//
//  HomeViewController.m
//  ICSAdmin
//
//  Created by Susmita Horrow on 19/10/15.
//  Copyright (c) 2015 GHCI-CSPR. All rights reserved.
//

#import "HomeViewController.h"
#import "NSDate+FormattedDate.h"
#import "ICSDataManager.h"

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UILabel *fromDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *toDateLabel;
@property (strong, nonatomic) UILabel *selectedLabel;
@property (weak, nonatomic) IBOutlet UILabel *screeningCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *registrationCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventsCountLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *fromDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *toDatePicker;
@end

@implementation HomeViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self configureDateSelector];
  [[ICSDataManager shared]fetchCancerTypesWithCompletion:^(BOOL success, NSArray *result, APIError *error) {
	NSLog(@"result count = %ld",result.count);
	[self fetchStatistics:nil];
  }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureDateSelector {
  UITapGestureRecognizer *tapOnFromLabel = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toggleFromDatePicker:)];
  [self.fromDateLabel addGestureRecognizer:tapOnFromLabel];
  UITapGestureRecognizer *tapOnToLabel = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toggleToDatePicker:)];
  [self.toDateLabel addGestureRecognizer:tapOnToLabel];
  
  self.fromDateLabel.text = [NSString stringWithFormat:@"%@",[self.fromDatePicker.date formattedDateString]];
  self.toDateLabel.text = [NSString stringWithFormat:@"%@",[self.toDatePicker.date formattedDateString]];

}
- (IBAction)handleMenuTap:(id)sender {
//  if ([self.delegate respondsToSelector:@selector(toggleLeftMenu)]) {
//	[self.delegate toggleLeftMenu];
//  }
}

- (void)toggleFromDatePicker:(UIGestureRecognizer *)gesture {
  self.toDatePicker.hidden = YES;
  self.fromDatePicker.hidden = !self.fromDatePicker.hidden;
}

- (void)toggleToDatePicker:(UIGestureRecognizer *)gesture {
  self.fromDatePicker.hidden = YES;
  self.toDatePicker.hidden = !self.toDatePicker.hidden;
}

- (IBAction)updateFromDate:(id)sender {
  self.fromDateLabel.text = [NSString stringWithFormat:@"%@",[self.fromDatePicker.date formattedDateString]];
}

- (IBAction)updateToDate:(id)sender {
  self.toDateLabel.text = [NSString stringWithFormat:@"%@",[self.toDatePicker.date formattedDateString]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)fetchStatistics:(id)sender {
  [[ICSDataManager shared]fetchCancerTypesWithCompletion:^(BOOL success, NSArray *result, APIError *error) {
	NSLog(@"result count = %ld",result.count);
	[[ICSDataManager shared]fetchStatisticsForStartDate:self.fromDatePicker.date andEndDate:self.toDatePicker.date withCompletion:^(BOOL success,  NSArray * result, APIError *error) {
	  self.fromDatePicker.hidden = YES;
	  self.toDatePicker.hidden = YES;
	  NSDictionary *dict =[result firstObject];
	  [self updateSummaryView:[dict objectForKey:@"result"]];
	  
	}];
  }];

}
- (void)updateSummaryView:(NSDictionary *)dictionary {
  
  self.registrationCountLabel.text = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"registrations"]];
  self.screeningCountLabel.text = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"screenings"]];
  self.eventsCountLabel.text = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"events"]];

}
#pragma mark - 

@end