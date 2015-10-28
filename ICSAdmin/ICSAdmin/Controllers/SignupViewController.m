//
//  SignupViewController.m
//  ICSAdmin
//
//  Created by Susmita Horrow on 19/10/15.
//  Copyright (c) 2015 GHCI-CSPR. All rights reserved.
//

#import "SignupViewController.h"
#import "ICSDataManager.h"

@interface SignupViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *firstnameField;
@property (weak, nonatomic) IBOutlet UITextField *lastnameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordField;

@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
- (IBAction)handleTapOnView:(id)sender {
  [self.view endEditing:YES];
}

- (IBAction)handleTapOnSignup:(id)sender {
  if ([self isValidationSuccessful]) {
	[[ICSDataManager shared] signUpWithEmailId:self.emailField.text password:self.passwordField.text username:self.usernameField.text firstname:self.firstnameField.text lastname:self.lastnameField.text contactNumber:self.phoneNumberField.text completion:^(BOOL success, id result, APIError *error) {
	  	if (success) {
		  [self.navigationController popViewControllerAnimated:YES];
	  	}
	}];
  }
}

- (BOOL)isValidationSuccessful {
  BOOL completeInput = (self.emailField.text.length > 0) && (self.passwordField.text.length > 0) &&
					   (self.usernameField.text.length > 0) && (self.firstnameField.text.length > 0) &&
					   (self.lastnameField.text.length > 0) && (self.phoneNumberField.text.length > 0);
  
  BOOL doesPasswordMatch = [self.passwordField.text isEqualToString:self.confirmPasswordField.text];
  return completeInput && doesPasswordMatch;
}


@end
