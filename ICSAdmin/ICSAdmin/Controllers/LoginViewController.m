//
//  ViewController.m
//  ICSAdmin
//
//  Created by Susmita Horrow on 19/10/15.
//  Copyright (c) 2015 GHCI-CSPR. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "ICSDataManager.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

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
  [self validateAndLogin];
}

#pragma mark - UITextFieldDelegate Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
  if ([textField isEqual:self.emailField]) {
	[self.passwordField becomeFirstResponder];
  }else if ([textField isEqual:self.passwordField]){
	[self validateAndLogin];
  }
  return YES;
}

- (void)validateAndLogin {
	[[ICSDataManager shared] loginWithEmailId:self.emailField.text password:self.passwordField.text completion:^(BOOL success, id result, APIError *error) {
	  NSLog(@"result = %@",result);
	  NSLog(@"error = %@",error);
	  if (success) {
		AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
 		 [appDelegate showHomeFlow];
	  }
	}];
}

@end
