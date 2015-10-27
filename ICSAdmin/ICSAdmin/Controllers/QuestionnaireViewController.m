//
//  CreateFormViewController.m
//  ICSAdmin
//
//  Created by Susmita Horrow on 27/10/15.
//  Copyright (c) 2015 GHCI-CSPR. All rights reserved.
//

#import "QuestionnaireViewController.h"
#import "FormViewController.h"

@interface QuestionnaireViewController ()
@property (weak, nonatomic) IBOutlet UIButton *formNameButton;

@end

@implementation CreateFormViewController

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
- (IBAction)didTapOnNameButton:(id)sender {
  FormViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"formVC"];
  [self presentViewController:vc animated:YES completion:^{
	
  }];

}

@end
