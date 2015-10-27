//
//  CreateEventViewController.m
//  ICSAdmin
//
//  Created by Susmita Horrow on 26/10/15.
//  Copyright (c) 2015 GHCI-CSPR. All rights reserved.
//

#import "CreateEventViewController.h"
#import "SelectorView.h"
#import <THDatePickerViewController.h>
#import "NSDate+FormattedDate.h"

@interface CreateEventViewController()<THDatePickerDelegate>
@property (weak, nonatomic) IBOutlet SelectorView *typeSelectorView;
@property (weak, nonatomic) IBOutlet SelectorView *formSelectorView;
@property (weak, nonatomic) IBOutlet UIButton *typeSelectorButton;
@property (weak, nonatomic) IBOutlet UIButton *formSelectorButton;
@property (weak, nonatomic) IBOutlet UILabel *cancerTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *formLabel;
@property (strong, nonatomic) THDatePickerViewController *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *endDateLabel;
@property (weak, nonatomic) IBOutlet UIButton *startDateButton;
@property (weak, nonatomic) IBOutlet UIButton *endDateButton;
@property (nonatomic, strong) UIButton *currentlySelectedButton;

@end

@implementation CreateEventViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"Create Event";
  NSArray *types = @[@"Throat",@"Skin",@"Mouth"];
  NSArray *forms = @[@"Short Screening Form",@"Detailed Screening Form"];

  [self.typeSelectorView configureWithDataSource:types
   withCellTapHandler:^(NSIndexPath *indexPath){
	 self.cancerTypeLabel.text = [types objectAtIndex:indexPath.row];
//	 [self showCancerTypes:NO];
   }
  withDetailTapHandler:nil];
  [self.formSelectorView configureWithDataSource:forms
  withCellTapHandler:^(NSIndexPath *indexPath){
	self.formLabel.text = [forms objectAtIndex:indexPath.row];
//	[self showForms:NO];
  }
 withDetailTapHandler:^(NSIndexPath *indexPath) {
	NSLog(@"tapped index = %d",indexPath.row);
	
  }];
}

- (IBAction)chooseCancerType:(UIButton *)sender {
  BOOL shouldShow = !sender.selected;
  [self showCancerTypes:shouldShow];
  [self showForms:NO];
}

- (void)showCancerTypes:(BOOL)show {
  [UIView animateWithDuration:0.5 animations:^{
	self.typeSelectorView.alpha = show ? 1: 0;
	self.typeSelectorButton.selected = show;
  } completion:^(BOOL finished) {
	
  }];
  
}

- (void)showForms:(BOOL)show {
  [UIView animateWithDuration:0.5 animations:^{
	self.formSelectorButton.selected = show;
	self.formSelectorView.alpha = show ? 1: 0;
  }completion:^(BOOL finished) {
	
  }];
  
}

- (IBAction)chooseDetectionForm:(UIButton *)sender {
  BOOL shouldShow = !sender.selected;
  [self showCancerTypes:NO];
  [self showForms:shouldShow];
}
- (IBAction)didTapStartButton:(UIButton *)sender {
  sender.selected = YES;
  self.currentlySelectedButton = sender;
  if(!self.datePicker)
	self.datePicker = [THDatePickerViewController datePicker];
  self.datePicker.date = [NSDate date];
  self.datePicker.delegate = self;
  [self.datePicker setAllowClearDate:NO];
  [self.datePicker setClearAsToday:YES];
//  [self.datePicker setAutoCloseOnSelectDate:YES];
  [self.datePicker setAllowSelectionOfSelectedDate:YES];
  [self.datePicker setDisableHistorySelection:YES];
  [self.datePicker setDisableFutureSelection:NO];
//  [self.datePicker setSelectedBackgroundColor:[UIColor colorWithRed:125/255.0 green:208/255.0 blue:0/255.0 alpha:1.0]];
  [self.datePicker setSelectedBackgroundColor:[UIColor colorWithRed:149/255.0 green:212/255.0 blue:237/255.0 alpha:1.0]];

  [self.datePicker setCurrentDateColor:[UIColor colorWithRed:242/255.0 green:121/255.0 blue:53/255.0 alpha:1.0]];
  
  [self.datePicker setDateHasItemsCallback:^BOOL(NSDate *date) {
	int tmp = (arc4random() % 30)+1;
	if(tmp % 5 == 0)
	  return YES;
	return NO;
  }];
  //[self.datePicker slideUpInView:self.view withModalColor:[UIColor lightGrayColor]];
  [self presentSemiViewController:self.datePicker withOptions:@{
																KNSemiModalOptionKeys.pushParentBack    : @(NO),
																KNSemiModalOptionKeys.animationDuration : @(0.5),
																KNSemiModalOptionKeys.shadowOpacity     : @(0.3),
																}];
}
-(void)datePickerDonePressed:(THDatePickerViewController *)datePicker {
  if ([self.currentlySelectedButton isEqual:self.startDateButton]) {
  	self.startDateLabel.text = [NSString stringWithFormat:@"%@",[self.datePicker.date formattedDateString]];
  }
  if ([self.currentlySelectedButton isEqual:self.endDateButton]) {
	self.endDateLabel.text = [NSString stringWithFormat:@"%@",[self.datePicker.date formattedDateString]];
  }
 
  [self dismissSemiModalViewWithCompletion:^{
	self.currentlySelectedButton.selected = NO;
	self.currentlySelectedButton = nil;
  }];
}

-(void)datePickerCancelPressed:(THDatePickerViewController *)datePicker {
  [self dismissSemiModalViewWithCompletion:^{
	self.currentlySelectedButton.selected = NO;
	self.currentlySelectedButton = nil;
  }];
}

@end
