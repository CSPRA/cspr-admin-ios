//
//  CustomNavigationController.m
//  ICSAdmin
//
//  Created by Susmita Horrow on 20/10/15.
//  Copyright (c) 2015 GHCI-CSPR. All rights reserved.
//

#import "CustomNavigationController.h"

@implementation CustomNavigationController

@synthesize slidingDelegate = _slidingDelegate;

- (void)viewDidLoad {
  [super viewDidLoad];
  self.delegate = self;
  self.slidingDelegate = self;
}

- (void)navigationController:(UINavigationController *)navigationController
	  willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
  if ([[navigationController.viewControllers objectAtIndex:0] isEqual:viewController]) {
	NSMutableArray *leftBtns = [[NSMutableArray alloc] init];
	
	UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menuButton"] style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonPressed)];
	[leftBtns addObject:leftBtn];
	  viewController.navigationItem.leftBarButtonItem = leftBtn;
	}
}

-(void)leftButtonPressed {
  if ([self.slidingDelegate respondsToSelector:@selector(toggleLeftMenu)]) {
	[self.slidingDelegate toggleLeftMenu];
  }
}

@end
