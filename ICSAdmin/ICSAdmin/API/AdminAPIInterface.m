//
//  AdminAPIInterface.m
//  ICSAdmin
//
//  Created by Susmita Horrow on 28/10/15.
//  Copyright © 2015 GHCI-CSPR. All rights reserved.
//

#import "AdminAPIInterface.h"
#import "User.h"
#import "User+APIAdditions.h"

@interface AdminAPIInterface()

@property(nonatomic, strong)NSIndexSet *successSet;

@end

@implementation AdminAPIInterface

+ (instancetype)sharedInstance {
  static dispatch_once_t onceToken;
  static AdminAPIInterface *sharedInstance = nil;
  
  dispatch_once(&onceToken, ^{
	sharedInstance = [[AdminAPIInterface alloc] init];
  });
  return sharedInstance;
}

#pragma mark APIInterface protocol methods

- (void)setupRestkitConfigurations {
  
  [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
  NSURL *baseURL = [NSURL URLWithString:kApiBaseUrl];
  AFHTTPClient* client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
  [client setDefaultHeader:@"Accept" value:RKMIMETypeJSON];
  
  _objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
  
  _objectManager.managedObjectStore = self.objectStore;
  _objectManager.requestSerializationMIMEType = RKMIMETypeJSON;
  
  [[RKValueTransformer defaultValueTransformer] addValueTransformer:[RKValueTransformer iso8601TimestampToDateValueTransformer]];
  
//#if DEBUG
  RKLogConfigureByName("*", RKLogLevelTrace);
//#endif
  
}

-(RKManagedObjectStore *)objectStore{
  if (!_objectStore) {
	NSManagedObjectModel *managedObjectModel =
	[NSManagedObjectModel mergedModelFromBundles:nil];
	_objectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
	[_objectStore createPersistentStoreCoordinator];
	
	NSString *storePath = [RKApplicationDataDirectory()
						   stringByAppendingPathComponent:@"ICSAdmin.sqlite"];
	NSError *error = nil;
	[_objectStore addSQLitePersistentStoreAtPath:storePath
						  fromSeedDatabaseAtPath:nil
							   withConfiguration:nil
										 options:nil
										   error:&error];
	if (error) {
	  NSLog(@"unresolved error %@, %@", error, [error userInfo]);
	  abort();
	}
	[_objectStore createManagedObjectContexts];
	[RKManagedObjectStore setDefaultStore:_objectStore];
  }
  return _objectStore;
}


- (void)setupObjectMappings {
  
  //User Mappings
  RKEntityMapping * userMapping = [User restkitObjectMappingForStore:self.objectStore];
  RKResponseDescriptor *responseDescriptor =
  [RKResponseDescriptor responseDescriptorWithMapping:userMapping
											   method:RKRequestMethodPOST
										  pathPattern:kAPIPathRegister
											  keyPath:nil
										  statusCodes:self.successSet];
  [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
  
  responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:userMapping
																	method:RKRequestMethodPOST
															   pathPattern:kAPIPathLogin
																   keyPath:@"result"
															   statusCodes:self.successSet];
  [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
  /*
  responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:userMapping
																	method:RKRequestMethodPOST
															   pathPattern:kAPIPathAvatarUpload
																   keyPath:nil
															   statusCodes:self.successSet];
  [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
  
  responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:userMapping
																	method:RKRequestMethodPATCH
															   pathPattern:kAPIPathUserProfile
																   keyPath:nil
															   statusCodes:self.successSet];
  [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
  
  //Groups Mapping
  RKEntityMapping *groupMapping = [Group restkitObjectMappingForStore:self.objectStore];
  responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:groupMapping
																	method:RKRequestMethodGET
															   pathPattern:kApiPathGroupSearch
																   keyPath:@"results"
															   statusCodes:self.successSet];
  [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
  
  groupMapping = [Group restkitObjectMappingForStore:self.objectStore];
  responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:groupMapping
																	method:RKRequestMethodGET
															   pathPattern:kApiPathUserGroups
																   keyPath:@"results"
															   statusCodes:self.successSet];
  [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
  
  groupMapping = [Group restkitObjectMappingForStore:self.objectStore];
  responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:groupMapping
																	method:RKRequestMethodGET
															   pathPattern:kAPiPathGroupEveryone
																   keyPath:nil
															   statusCodes:self.successSet];
  [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
  
  groupMapping = [Group restkitObjectMappingForStore:self.objectStore];
  responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:groupMapping
																	method:RKRequestMethodGET
															   pathPattern:kAPiPathGroupDetailPattern
																   keyPath:nil
															   statusCodes:self.successSet];
  [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
  
  
  RKEntityMapping *userProfileMapping = [Profile restkitObjectMappingForStore:self.objectStore];
  responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:userProfileMapping
																	method:RKRequestMethodPOST
															   pathPattern:kApiPathGroupJoinPattern
																   keyPath:nil
															   statusCodes:self.successSet];
  [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
  
  responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:userProfileMapping
																	method:RKRequestMethodPATCH
															   pathPattern:kApiPathGroupUserProfileUpdatePattern
																   keyPath:nil
															   statusCodes:self.successSet];
  [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
  
  responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:userProfileMapping
																	method:RKRequestMethodGET
															   pathPattern:kApiPathGroupUserProfilesPattern
																   keyPath:@"results"
															   statusCodes:self.successSet];
  [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
  
  responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:userProfileMapping
																	method:RKRequestMethodPOST
															   pathPattern:kAPiPathGroupEveryoneJoin
																   keyPath:nil
															   statusCodes:self.successSet];
  [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
  
  responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:userProfileMapping
																	method:RKRequestMethodPOST
															   pathPattern:kAPIPathBlockUserPattern
																   keyPath:nil
															   statusCodes:self.successSet];
  [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
  
  responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:userProfileMapping
																	method:RKRequestMethodPOST
															   pathPattern:kAPIPathUnBlockUserPattern
																   keyPath:nil
															   statusCodes:self.successSet];
  [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
  
  responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:userProfileMapping
																	method:RKRequestMethodGET
															   pathPattern:kAPiPathPatternMootUsers
																   keyPath:@"results"
															   statusCodes:self.successSet];
  [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
  
  responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:userProfileMapping
																	method:RKRequestMethodGET
															   pathPattern:kAPIPathFetchUserProfilePattern
																   keyPath:nil
															   statusCodes:self.successSet];
  [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
  
  RKEntityMapping *mootMapping = [Moot restkitObjectMappingForStore:self.objectStore];
  responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mootMapping
																	method:RKRequestMethodPOST
															   pathPattern:kApiPathGroupCreateMootPattern
																   keyPath:nil
															   statusCodes:self.successSet];
  [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
  
  mootMapping = [Moot restkitObjectMappingForStore:self.objectStore];
  responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mootMapping
																	method:RKRequestMethodPOST
															   pathPattern:kAPIPathPrivateChatPattern
																   keyPath:nil
															   statusCodes:self.successSet];
  [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
  
  mootMapping = [Moot restkitObjectMappingForStore:self.objectStore];
  responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mootMapping
																	method:RKRequestMethodGET
															   pathPattern:kAPiPathGroupMootsPattern
																   keyPath:@"results"
															   statusCodes:self.successSet];
  [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
  
  RKObjectMapping *paginatorMapping = [MTPaginator restkitObjectMapping];
  responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:paginatorMapping
																	method:RKRequestMethodGET
															   pathPattern:kAPiPathGroupMootsPattern
																   keyPath:nil
															   statusCodes:self.successSet];
  [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
  
  responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:paginatorMapping
																	method:RKRequestMethodGET
															   pathPattern:kApiPathGroupUserProfilesPattern
																   keyPath:nil
															   statusCodes:self.successSet];
  [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
  
  mootMapping = [Moot restkitObjectMappingForStore:self.objectStore];
  responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mootMapping
																	method:RKRequestMethodGET
															   pathPattern:kAPIPathInbox
																   keyPath:@"results"
															   statusCodes:self.successSet];
  [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
  
  responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:paginatorMapping
																	method:RKRequestMethodGET
															   pathPattern:kAPIPathInbox
																   keyPath:nil
															   statusCodes:self.successSet];
  [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
  
  mootMapping = [Moot restkitObjectMappingForStore:self.objectStore];
  responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mootMapping
																	method:RKRequestMethodGET
															   pathPattern:kAPiPathGetMootDetailsPattern
																   keyPath:nil
															   statusCodes:self.successSet];
  [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
  
  RKObjectMapping *chatMessageMapping = [MTChatMessage restkitObjectMapping];
  responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:chatMessageMapping
																	method:RKRequestMethodGET
															   pathPattern:kAPIPathMootMessagesPattern
																   keyPath:@"results"
															   statusCodes:self.successSet];
  [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
  
  RKObjectMapping *announcementMapping = [Announcement restkitObjectMappingForStore:self.objectStore];
  responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:announcementMapping
																	method:RKRequestMethodGET
															   pathPattern:kAPIPathAnnouncements
																   keyPath:@"results"
															   statusCodes:self.successSet];
  [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
  
  paginatorMapping = [MTPaginator restkitObjectMapping];
  responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:paginatorMapping
																	method:RKRequestMethodGET
															   pathPattern:kAPIPathAnnouncements
																   keyPath:nil
															   statusCodes:self.successSet];
  [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
  
  paginatorMapping = [MTPaginator restkitObjectMapping];
  responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:paginatorMapping
																	method:RKRequestMethodGET
															   pathPattern:kApiPathGroupSearch
																   keyPath:nil
															   statusCodes:self.successSet];
  [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];*/
  
}

- (NSManagedObjectContext *)managedObjectContext {
  return self.objectStore.persistentStoreManagedObjectContext;
}

- (id<APIErrorProtocol>)errorForOperation: (AFHTTPRequestOperation*)operation
							 withResponse:(NSDictionary *)response
								 andError:(NSError *)error  {
  __block NSString * domain = [response objectForKey:@"_error_type"];
  __block NSString *message = [response objectForKey:@"_error_message"];
  
  if (!message) {
	[response enumerateKeysAndObjectsUsingBlock:^(NSString* key, NSArray* obj, BOOL *stop) {
	  domain = key;
	  message = [obj firstObject];
	  *stop = YES;
	}];
  }
  
  NSInteger statusCode = operation.response.statusCode;
  APIError *apiError;
  if (domain && message) {
	apiError = [[APIError alloc] initWithDomain:domain
										message:message
										andCode:statusCode];
  }
  return apiError;
}

- (void)setupAuthToken:(NSString *)authToken {
  if (authToken) {
	NSString  *userAuthToken = [NSString stringWithFormat:@"Bearer %@", authToken];
	[self.objectManager.HTTPClient setDefaultHeader:@"Authorization" value:userAuthToken];
  } else {
	[self.objectManager.HTTPClient setDefaultHeader:@"Authorization" value:nil];
  }
}


@end
