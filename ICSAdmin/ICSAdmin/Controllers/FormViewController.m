//
//  FormViewController.m
//  ICSAdmin
//
//  Created by Susmita Horrow on 27/10/15.
//  Copyright (c) 2015 GHCI-CSPR. All rights reserved.
//

#import "FormViewController.h"
//#import "DateAndTimeValueTrasformer.h"

@interface FormViewController ()

@end

@implementation FormViewController

- (void)viewDidLoad {
  [super viewDidLoad];
//  [self formToCreateQuestionnaire];
  [self formToCreateSection];
  self.tableView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelPressed)];
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(savePressed)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)formToCreateQuestionnaire {
  XLFormDescriptor * form;
  XLFormSectionDescriptor * section;
  XLFormRowDescriptor * row;
  
  form = [XLFormDescriptor formDescriptorWithTitle:@"Create Questionnaire"];
  section = [XLFormSectionDescriptor formSection];
  [form addFormSection:section];
  
  row = [XLFormRowDescriptor formRowDescriptorWithTag:@"Name" rowType:XLFormRowDescriptorTypeText];
  [row.cellConfigAtConfigure setObject:@"Name" forKey:@"textField.placeholder"];
  row.required = YES;
  [section addFormRow:row];
  
  
  //Description
  row = [XLFormRowDescriptor formRowDescriptorWithTag:@"Description" rowType:XLFormRowDescriptorTypeTextView];
  [row.cellConfigAtConfigure setObject:@"Description" forKey:@"textView.placeholder"];
  row.required = YES;
  [section addFormRow:row];
  self.form = form;
  
  //Cancer Type
  row = [XLFormRowDescriptor formRowDescriptorWithTag:@"Cancer Type" rowType:XLFormRowDescriptorTypeSelectorPush title:@"Cancer Type"];
  row.value = [XLFormOptionsObject formOptionsObjectWithValue:@(0) displayText:@"Throat"];
  row.selectorTitle = @"Cancer Type";
  row.selectorOptions = @[[XLFormOptionsObject formOptionsObjectWithValue:@(0) displayText:@"Throat"],
						  [XLFormOptionsObject formOptionsObjectWithValue:@(1) displayText:@"Skin"],
						  [XLFormOptionsObject formOptionsObjectWithValue:@(2) displayText:@"Mouth"]
						  ];
  [section addFormRow:row];

  self.form = form;
}

- (void)formToCreateSection {
  XLFormDescriptor * form;
  XLFormSectionDescriptor * section;
  XLFormRowDescriptor * row;
  
  form = [XLFormDescriptor formDescriptorWithTitle:@"Create Questionnaire"];
  section = [XLFormSectionDescriptor formSection];
  [form addFormSection:section];
  
  row = [XLFormRowDescriptor formRowDescriptorWithTag:@"Name" rowType:XLFormRowDescriptorTypeText];
  [row.cellConfigAtConfigure setObject:@"Name" forKey:@"textField.placeholder"];
  row.required = YES;
  [section addFormRow:row];
  
  
  //Description
  row = [XLFormRowDescriptor formRowDescriptorWithTag:@"Description" rowType:XLFormRowDescriptorTypeTextView];
  [row.cellConfigAtConfigure setObject:@"Description" forKey:@"textView.placeholder"];
  row.required = YES;
  [section addFormRow:row];
  
  self.form = form;
}


- (void)cancelPressed {
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)savePressed {

}
- (void)initializeForm
{
  XLFormDescriptor * form;
  XLFormSectionDescriptor * section;
  XLFormRowDescriptor * row;
  
  form = [XLFormDescriptor formDescriptorWithTitle:@"Add Event"];
  section = [XLFormSectionDescriptor formSection];
  [form addFormSection:section];
  
  // Title
  row = [XLFormRowDescriptor formRowDescriptorWithTag:@"Title" rowType:XLFormRowDescriptorTypeText];
  [row.cellConfigAtConfigure setObject:@"Title" forKey:@"textField.placeholder"];
  row.required = YES;
  [section addFormRow:row];
  
  // Location
  row = [XLFormRowDescriptor formRowDescriptorWithTag:@"location" rowType:XLFormRowDescriptorTypeText];
  [row.cellConfigAtConfigure setObject:@"Location" forKey:@"textField.placeholder"];
  [section addFormRow:row];
  
  section = [XLFormSectionDescriptor formSection];
  [form addFormSection:section];
  
  // All-day
  row = [XLFormRowDescriptor formRowDescriptorWithTag:@"all-day" rowType:XLFormRowDescriptorTypeBooleanSwitch title:@"All-day"];
  [section addFormRow:row];
  
  // Starts
  row = [XLFormRowDescriptor formRowDescriptorWithTag:@"starts" rowType:XLFormRowDescriptorTypeDateTimeInline title:@"Starts"];
  row.value = [NSDate dateWithTimeIntervalSinceNow:60*60*24];
  [section addFormRow:row];
  
  // Ends
  row = [XLFormRowDescriptor formRowDescriptorWithTag:@"ends" rowType:XLFormRowDescriptorTypeDateTimeInline title:@"Ends"];
  row.value = [NSDate dateWithTimeIntervalSinceNow:60*60*25];
  [section addFormRow:row];
  
  section = [XLFormSectionDescriptor formSection];
  [form addFormSection:section];
  
  // Repeat
  row = [XLFormRowDescriptor formRowDescriptorWithTag:@"repeat" rowType:XLFormRowDescriptorTypeSelectorPush title:@"Repeat"];
  row.value = [XLFormOptionsObject formOptionsObjectWithValue:@(0) displayText:@"Never"];
  row.selectorTitle = @"Repeat";
  row.selectorOptions = @[[XLFormOptionsObject formOptionsObjectWithValue:@(0) displayText:@"Never"],
						  [XLFormOptionsObject formOptionsObjectWithValue:@(1) displayText:@"Every Day"],
						  [XLFormOptionsObject formOptionsObjectWithValue:@(2) displayText:@"Every Week"],
						  [XLFormOptionsObject formOptionsObjectWithValue:@(3) displayText:@"Every 2 Weeks"],
						  [XLFormOptionsObject formOptionsObjectWithValue:@(4) displayText:@"Every Month"],
						  [XLFormOptionsObject formOptionsObjectWithValue:@(5) displayText:@"Every Year"],
						  ];
  [section addFormRow:row];
  
  
  
  section = [XLFormSectionDescriptor formSection];
  [form addFormSection:section];
  
  // Alert
  row = [XLFormRowDescriptor formRowDescriptorWithTag:@"alert" rowType:XLFormRowDescriptorTypeSelectorPush title:@"Alert"];
  row.value = [XLFormOptionsObject formOptionsObjectWithValue:@(0) displayText:@"None"];
  row.selectorTitle = @"Event Alert";
  row.selectorOptions = @[[XLFormOptionsObject formOptionsObjectWithValue:@(0) displayText:@"None"],
						  [XLFormOptionsObject formOptionsObjectWithValue:@(1) displayText:@"At time of event"],
						  [XLFormOptionsObject formOptionsObjectWithValue:@(2) displayText:@"5 minutes before"],
						  [XLFormOptionsObject formOptionsObjectWithValue:@(3) displayText:@"15 minutes before"],
						  [XLFormOptionsObject formOptionsObjectWithValue:@(4) displayText:@"30 minutes before"],
						  [XLFormOptionsObject formOptionsObjectWithValue:@(5) displayText:@"1 hour before"],
						  [XLFormOptionsObject formOptionsObjectWithValue:@(6) displayText:@"2 hours before"],
						  [XLFormOptionsObject formOptionsObjectWithValue:@(7) displayText:@"1 day before"],
						  [XLFormOptionsObject formOptionsObjectWithValue:@(8) displayText:@"2 days before"],
						  ];
  [section addFormRow:row];
  
  
  section = [XLFormSectionDescriptor formSection];
  [form addFormSection:section];
  
  // Show As
  row = [XLFormRowDescriptor formRowDescriptorWithTag:@"showAs" rowType:XLFormRowDescriptorTypeSelectorPush title:@"Show As"];
  row.value = [XLFormOptionsObject formOptionsObjectWithValue:@(0) displayText:@"Busy"];
  row.selectorTitle = @"Show As";
  row.selectorOptions = @[[XLFormOptionsObject formOptionsObjectWithValue:@(0) displayText:@"Busy"],
						  [XLFormOptionsObject formOptionsObjectWithValue:@(1) displayText:@"Free"]];
  [section addFormRow:row];
  
  section = [XLFormSectionDescriptor formSection];
  [form addFormSection:section];
  
  // URL
  row = [XLFormRowDescriptor formRowDescriptorWithTag:@"url" rowType:XLFormRowDescriptorTypeURL];
  [row.cellConfigAtConfigure setObject:@"URL" forKey:@"textField.placeholder"];
  [section addFormRow:row];
  
  // Notes
  row = [XLFormRowDescriptor formRowDescriptorWithTag:@"notes" rowType:XLFormRowDescriptorTypeTextView];
  [row.cellConfigAtConfigure setObject:@"Notes" forKey:@"textView.placeholder"];
  [section addFormRow:row];
  
  
  self.form = form;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)didTapCancel:(id)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
