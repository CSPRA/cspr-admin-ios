//
//  CancerType+APIAdditions.m
//  ICSAdmin
//
//  Created by Susmita Horrow on 28/10/15.
//  Copyright © 2015 GHCI-CSPR. All rights reserved.
//

#import "CancerType+APIAdditions.h"

@implementation CancerType (APIAdditions)

+ (RKEntityMapping *)restkitObjectMappingForStore:(RKManagedObjectStore *)store {
  RKEntityMapping *mapping  = [RKEntityMapping mappingForEntityForName:NSStringFromClass([self class])
												  inManagedObjectStore:store];
  [mapping setIdentificationAttributes:@[@"id"]];
  [mapping addAttributeMappingsFromDictionary:
   @{
	 @"name": @"name",
	 @"description": @"about",
	}];
  return mapping;
}


@end
