//
//  NSDate+FormattedDate.m
//  ICSAdmin
//
//  Created by Susmita Horrow on 20/10/15.
//  Copyright (c) 2015 GHCI-CSPR. All rights reserved.
//

#import "NSDate+FormattedDate.h"

@implementation NSDate (FormattedDate)

- (NSString *)formattedDateString {
  	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
  	[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
  	return [dateFormatter stringFromDate:self];
}

@end
