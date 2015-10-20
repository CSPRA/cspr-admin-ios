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
//  [self configureMenuButton];
  NSMutableArray *leftBtns = [[NSMutableArray alloc] init];
  
  UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menuButton"] style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonPressed)];
  [leftBtns addObject:leftBtn];
  
  NSLog(@"nav item = %@",self.navigationItem);
  
  
  UIButton *button = [[UIButton alloc] init];
  
  [button setImage:[UIImage imageNamed:@"menuButton"] forState:UIControlStateNormal];
  [button setBackgroundColor:[UIColor blackColor]];
  [button addTarget:self action:@selector(leftButtonPressed)
   forControlEvents:UIControlEventTouchUpInside];
  [button setFrame:CGRectMake(0, 0, 30, 30)];
  
  UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]
									initWithCustomView:button];
  viewController.navigationItem.leftBarButtonItem = barButtonItem;
  NSLog(@"left button = %@",self.navigationItem.leftBarButtonItem);
}
- (void)configureMenuButton {
  NSMutableArray *leftBtns = [[NSMutableArray alloc] init];
  
  UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menuButton"] style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonPressed)];
  [leftBtns addObject:leftBtn];

  NSLog(@"nav item = %@",self.navigationItem);
  
  
  UIButton *button = [[UIButton alloc] init];
  
  [button setImage:[UIImage imageNamed:@"menuButton"] forState:UIControlStateNormal];
  [button setBackgroundColor:[UIColor blackColor]];
  [button addTarget:self action:@selector(leftButtonPressed)
   forControlEvents:UIControlEventTouchUpInside];
  [button setFrame:CGRectMake(0, 0, 30, 30)];
  
  UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]
									initWithCustomView:button];
  self.navigationItem.leftBarButtonItem = barButtonItem;
  NSLog(@"left button = %@",self.navigationItem.leftBarButtonItem);
//  [self.navigationItem setLeftBarButtonItems:leftBtns animated:NO];
}

-(void)leftButtonPressed {
  NSLog(@"Left Button Tapped");
  NSLog(@"self.delegate = %@",self.delegate);
  if ([self.slidingDelegate respondsToSelector:@selector(toggleLeftMenu)]) {
	[self.slidingDelegate toggleLeftMenu];
  }
}

@end
