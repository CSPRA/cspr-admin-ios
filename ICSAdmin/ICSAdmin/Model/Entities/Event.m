//
//  Event.m
//  ICSAdmin
//
//  Created by Susmita Horrow on 29/10/15.
//  Copyright © 2015 GHCI-CSPR. All rights reserved.
//

#import "Event.h"

@implementation Event

- (void)setEventTypeString:(NSString *)eventTypeString {
  _eventTypeString = eventTypeString;
  if ([eventTypeString isEqualToString:@"screen"]) {
	_eventType = kEventTypeScreening;
  }
  if ([eventTypeString isEqualToString:@"register"]) {
	_eventType = kEventTypeRegister;
  }
  if ([eventTypeString isEqualToString:@"register_screen"]) {
	_eventType = kEventTypeBoth;
  }
}

- (void)setStartDate:(NSDate *)startDate {
  _startDate = startDate;
  [self updateStatus];
}

- (void)setEndDate:(NSDate *)endDate {
  _endDate = endDate;
  [self updateStatus];
}

- (void)updateStatus {
  BOOL endDateInPast = [_endDate compare:[NSDate date]] == NSOrderedAscending;
  BOOL startDateInPast = [_startDate compare:[NSDate date]] == NSOrderedAscending;
  
  if (endDateInPast && startDateInPast) {
	_status = kEventStatusClosed;
  }
  
  if (!startDateInPast) {
	_status = kEventStatusNotStarted;
  }
  
  if (startDateInPast && !endDateInPast) {
	_status = kEventStatusOpen;
  }
}

@end
