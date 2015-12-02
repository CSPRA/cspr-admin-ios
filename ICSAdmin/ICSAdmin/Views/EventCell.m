//
//  EventCell.m
//  ICSAdmin
//
//  Created by Susmita Horrow on 01/11/15.
//  Copyright © 2015 GHCI-CSPR. All rights reserved.
//

#import "EventCell.h"
#import "CancerType.h"
#import "NSDate+FormattedDate.h"

@interface EventCell()

@property (weak, nonatomic) IBOutlet UILabel *eventType;
@property (weak, nonatomic) IBOutlet UILabel *eventNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cancerName;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *startDate;
@property (weak, nonatomic) IBOutlet UILabel *endDate;

@end

@implementation EventCell

- (void)configureWithEvent:(Event *)event {
  self.eventType.text = event.eventTypeString;
  self.eventNameLabel.text = event.eventName;
  self.startDate.text = [NSString stringWithFormat:@"%@",[event.startDate formattedDateString]];
  self.endDate.text = [NSString stringWithFormat:@"%@",[event.endDate formattedDateString]];

  CancerType *cancerType = event.cancerType;
  self.cancerName.text = cancerType.name;
  self.textView.text = cancerType.about;
  NSLog(@"desc = %@",self.textView.text);

}

@end
