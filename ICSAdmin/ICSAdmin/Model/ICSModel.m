//
//  ICSModel.m
//  ICSAdmin
//
//  Created by Susmita Horrow on 19/10/15.
//  Copyright (c) 2015 GHCI-CSPR. All rights reserved.
//

#import "ICSModel.h"


static ICSModel *sharedInstance;

@implementation ICSModel

+ (ICSModel *)sharedModel {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
	sharedInstance = [ICSModel new];
	
  });
  return sharedInstance;
}

- (BOOL)loggedInUserPresent {
  return YES;
}

@end
