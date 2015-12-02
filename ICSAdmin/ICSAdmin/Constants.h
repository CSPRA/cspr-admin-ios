//
//  Constants.h
//  ICSAdmin
//
//  Created by Susmita Horrow on 28/10/15.
//  Copyright © 2015 GHCI-CSPR. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

//static NSString * const kApiBaseUrl = @"http://cspr-web-dev.elasticbeanstalk.com/";
static NSString * const kApiBaseUrl = @"http://localhost:8080/";

#pragma mark - API Endpoints

static NSString * const kAPIPathRegister = @"staff/register";
static NSString * const kAPIPathLogin = @"staff/login";
static NSString * const kAPIPathCancerType = @"cancerTypes";
static NSString * const kAPIPathEvent = @"events";
static NSString * const kAPIPathStatistics = @"statistics";
static NSString * const kAPIPathPatternAssignments = @"assignments/:eventId";
static NSString * const kAPIPathAssignments = @"assignments";
static NSString * const kAPIPathFreeVolunteers = @"freeVolunteers";

#endif /* Constants_h */
