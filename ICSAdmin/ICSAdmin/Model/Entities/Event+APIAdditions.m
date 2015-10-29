//
//  Event+APIAdditions.m
//  ICSAdmin
//
//  Created by Susmita Horrow on 29/10/15.
//  Copyright © 2015 GHCI-CSPR. All rights reserved.
//

#import "Event+APIAdditions.h"

@implementation Event (APIAdditions)

+(RKObjectMapping *)restkitObjectMapping {
  RKObjectMapping* eventMapping = [RKObjectMapping mappingForClass:[Event class]];
  [eventMapping addAttributeMappingsFromDictionary:@{  @"id": @"eventId",
													   @"name": @"eventName",
													   @"startDate": @"startDate",
													   @"endDate": @"endDate",
													   @"formId": @"detectionFormId",
													   @"created_at":@"createdAt",
													   @"eventType" : @"eventTypeString"
													   }];
  
  return eventMapping;
}

@end

