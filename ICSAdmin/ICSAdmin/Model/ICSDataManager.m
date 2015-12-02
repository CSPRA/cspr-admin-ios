//
//  ICSDataManager.m
//  ICSAdmin
//
//  Created by Susmita Horrow on 28/10/15.
//  Copyright © 2015 GHCI-CSPR. All rights reserved.
//

#import "ICSDataManager.h"
#import "AdminAPIInterface.h"

static ICSDataManager *sharedInstance = nil;

@interface ICSDataManager()

@property (nonatomic,readwrite) User *currentUser;

@end

@implementation ICSDataManager

@synthesize currentUser = _currentUser;

+ (instancetype)shared {
  if(sharedInstance == nil) {
	sharedInstance = [[ICSDataManager alloc] init];
	[sharedInstance initialSetup];
  }
  return sharedInstance;
}

- (User *)currentUser {
  NSError *error;
  return [[self objectsForEntityName:@"User" error:&error] firstObject];
}

- (void)initialSetup{
  sharedInstance.managedObjectContext = [[AdminAPIInterface sharedInstance] managedObjectContext];
//  [sharedInstance updateAuthToken];
}

- (void)loginWithEmailId:(NSString *)emailId password:(NSString *)password completion:(ICSDataManagerCompletionBlock)completion {
  NSDictionary  *params = [NSDictionary dictionaryWithObjectsAndKeys:emailId, @"email",password, @"password", nil];
  [[AdminAPIInterface sharedInstance] postObject:nil
										 path:kAPIPathLogin
								   parameters:params
								   completion:^(BOOL success, NSArray *result, APIError *error) {
									 if (success) {
									   NSLog(@"result = %@",result);
									   NSLog(@"error = %@",error);
									   _currentUser = [result firstObject];
									 }
									 completion(success, [result firstObject], error);
								   }];
}

- (void)signUpWithEmailId:(NSString *)emailId
				 password:(NSString *)password
				 username:(NSString *)username
				firstname:(NSString *)firstname
				 lastname:(NSString *)lastname
			contactNumber:(NSString *)contactNumber
			   completion:(ICSDataManagerCompletionBlock)completion {
  
 NSDictionary  *params = [NSDictionary dictionaryWithObjectsAndKeys:emailId, @"email",password, @"password",username,@"username",firstname,@"firstname",lastname,@"lastname",contactNumber,@"contactNumber",nil];
  [[AdminAPIInterface sharedInstance] postObject:nil
										 path:kAPIPathRegister
								   parameters:params
								   completion:^(BOOL success, NSArray *result, APIError *error) {
									 if (success) {
									   NSLog(@"result = %@",result);
									   NSLog(@"error = %@",error);
									   _currentUser = [result firstObject];
									   _currentUser.firstname = firstname;
									   _currentUser.lastname = lastname;
									   _currentUser.email = emailId;
									   _currentUser.username = username;
									   _currentUser.contactNumber = contactNumber;
									 }
									 completion(success, [result firstObject], error);
								   }];
}

- (void)logoutWithCompletion:(ICSDataManagerCompletionBlock)completion {

}


#pragma mark -

- (void)fetchCancerTypesWithCompletion:(ICSDataManagerCompletionBlock)completion {
 	 [[AdminAPIInterface sharedInstance] getObjectsAtPath:kAPIPathCancerType
  											parameters:@{@"token":self.currentUser.token}
											completion:^(BOOL success, NSArray *result, APIError *error) {
											 completion(success, result, error);
  }];
}

- (void)fetchEventsWithCompletion:(ICSDataManagerCompletionBlock)completion {
  [[AdminAPIInterface sharedInstance] getObjectsAtPath:kAPIPathEvent
  											parameters:@{@"token":self.currentUser.token}
											completion:^(BOOL success, NSArray *result, APIError *error) {
											  completion(success, result, error);
  }];
}

- (void)fetchStatistics:(ICSDataManagerCompletionBlock)completion {
  [[AdminAPIInterface sharedInstance]getObjectsAtPath:kAPIPathStatistics parameters:@{@"token":self.currentUser.token} completion:^(BOOL success, NSArray *result, APIError *error) {
	NSLog(@"count = %lu",(unsigned long)result.count);
  }];
}

- (void)fetchStatisticsForStartDate:(NSDate *)startDate andEndDate:(NSDate *)endDate withCompletion:(ICSDataManagerCompletionBlock)completion {
  NSDateFormatter *format = [[NSDateFormatter alloc] init];
  format.dateFormat = @"dd-MM-yyyy";
  NSLog(@"DATE = %@",[format stringFromDate:startDate] );
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"dd/MM/yyyy"];
  [[RKValueTransformer defaultValueTransformer] insertValueTransformer:dateFormatter atIndex:0];
  NSDictionary *param = @{@"token":self.currentUser.token,
					  @"startDate":startDate,@"endDate":endDate};
  [[AdminAPIInterface sharedInstance]getPath:kAPIPathStatistics
								  parameters:param
								  completion:^(BOOL success, id result, APIError *error) {
									completion(success,result,error);
					 			 }];
}

#pragma mark - Assignments

- (void)fetchAssignmentsForEvent:(NSString *)eventId withCompletion:(ICSDataManagerCompletionBlock)completion {
  NSString *path = [NSString stringWithFormat:@"%@/%@",kAPIPathAssignments, eventId];
  NSDictionary *param = @{@"token":self.currentUser.token};
  [[AdminAPIInterface sharedInstance]getPath:path
								  parameters:param
								  completion:^(BOOL success, id result, APIError *error) {
									completion(success,result,error);
					 			 }];

}

- (void)fetchFreeVolunteersWithCompletion:(ICSDataManagerCompletionBlock)completion {
  NSDictionary *param = @{@"token":self.currentUser.token};
  [[AdminAPIInterface sharedInstance]getPath:kAPIPathFreeVolunteers
								  parameters:param
								  completion:^(BOOL success, id result, APIError *error) {
									completion(success,result,error);
					 			 }];
}

- (void)assignVolunteerToEvent:(NSString *)eventId withParam:(NSDictionary *)param withCompletion:(ICSDataManagerCompletionBlock)completion {
  NSString *path = [NSString stringWithFormat:@"%@/%@?token=%@",kAPIPathCreateAssignment, eventId, self.currentUser.token];
  [[AdminAPIInterface sharedInstance]postPath:path parameters:param completion:^(BOOL success, NSArray *result, APIError *error) {
	completion(success,result,error);
  }];
}
@end
