//
//  CreateEventViewController.m
//  ICSAdmin
//
//  Created by Susmita Horrow on 26/10/15.
//  Copyright (c) 2015 GHCI-CSPR. All rights reserved.
//

#import "CreateEventViewController.h"
#import "SelectorView.h"

@interface CreateEventViewController()
@property (weak, nonatomic) IBOutlet SelectorView *typeSelectorView;
@property (weak, nonatomic) IBOutlet SelectorView *formSelectorView;
@property (weak, nonatomic) IBOutlet UIButton *typeSelectorButton;
@property (weak, nonatomic) IBOutlet UIButton *formSelectorButton;
@property (weak, nonatomic) IBOutlet UILabel *cancerTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *formLabel;

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
	 [self showCancerTypes:NO];
   }
  withDetailTapHandler:nil];
  [self.formSelectorView configureWithDataSource:forms
  withCellTapHandler:^(NSIndexPath *indexPath){
	self.formLabel.text = [forms objectAtIndex:indexPath.row];
	[self showForms:NO];
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

	self.typeSelectorView.hidden = !show;
	self.typeSelectorButton.selected = show;
}

- (void)showForms:(BOOL)show {
  self.formSelectorButton.selected = show;
  self.formSelectorView.hidden = !show;
}

- (IBAction)chooseDetectionForm:(UIButton *)sender {
  BOOL shouldShow = !sender.selected;
  [self showCancerTypes:NO];
  [self showForms:shouldShow];
}

@end
