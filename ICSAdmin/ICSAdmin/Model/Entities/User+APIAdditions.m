//
//  User+APIAdditions.m
//  ICSAdmin
//
//  Created by Susmita Horrow on 28/10/15.
//  Copyright © 2015 GHCI-CSPR. All rights reserved.
//

#import "User+APIAdditions.h"
#import <RestKit/RestKit.h>

@implementation User (APIAdditions)

+ (RKEntityMapping *)restkitObjectMappingForStore:(RKManagedObjectStore *)store {
  RKEntityMapping *mapping  = [RKEntityMapping mappingForEntityForName:NSStringFromClass([self class])
												  inManagedObjectStore:store];
  [mapping setIdentificationAttributes:@[@"id"]];
  [mapping addAttributeMappingsFromDictionary:
   @{
	 @"id": @"id",
	 @"username": @"username",
	 @"email": @"email",
	 @"firstname": @"firstname",
	 @"lastname": @"lastname",
	 @"contactNumber": @"contactNumber",
	 @"token": @"token",
	}];
  return mapping;
}

@end
