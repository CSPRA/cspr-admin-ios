//
//  ViewController.m
//  ICSAdmin
//
//  Created by Susmita Horrow on 19/10/15.
//  Copyright (c) 2015 GHCI-CSPR. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)handleTapOnLogin:(id)sender {
  AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
  [appDelegate showHomeFlow];
}

@end
