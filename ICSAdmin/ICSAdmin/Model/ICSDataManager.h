//
//  ICSDataManager.h
//  ICSAdmin
//
//  Created by Susmita Horrow on 28/10/15.
//  Copyright © 2015 GHCI-CSPR. All rights reserved.
//

#import "CoreDataManager.h"
#import "APIError.h"
#import "User.h"

@interface ICSDataManager : CoreDataManager

typedef void (^ICSDataManagerCompletionBlock)(BOOL success, id result, APIError *error);

@property (nonatomic, strong, readonly) User  *currentUser;

#pragma mark - User login/signup flow

- (void)signUpWithEmailId:(NSString *)emailId
				 password:(NSString *)password
				 username:(NSString *)username
				firstname:(NSString *)firstname
				 lastname:(NSString *)lastname
			contactNumber:(NSString *)contactNumber
			   completion:(ICSDataManagerCompletionBlock)completion;

- (void)loginWithEmailId:(NSString *)emailId
				password:(NSString *)password
			  completion:(ICSDataManagerCompletionBlock)completion;

- (void)logoutWithCompletion: (ICSDataManagerCompletionBlock)completion;

#pragma mark -

- (void)fetchCancerTypesWithCompletion:(ICSDataManagerCompletionBlock)completion;
- (void)fetchEventsWithCompletion:(ICSDataManagerCompletionBlock)completion;
- (void)fetchStatisticsForStartDate:(NSDate *)startDate andEndDate:(NSDate *)endDate withCompletion:(ICSDataManagerCompletionBlock)completion;
- (void)fetchAssignmentsForEvent:(NSString *)eventId withCompletion:(ICSDataManagerCompletionBlock)completion;

@end
