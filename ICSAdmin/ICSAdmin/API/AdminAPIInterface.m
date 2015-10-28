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
											  keyPath:@"result"
										  statusCodes:self.successSet];
  [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
  
  responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:userMapping
																	method:RKRequestMethodPOST
															   pathPattern:kAPIPathLogin
																   keyPath:@"result"
															   statusCodes:self.successSet];
  [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
  

  RKObjectMapping *errorMapping = [RKObjectMapping mappingForClass:[APIError class]];
  [errorMapping mappingForDestinationKeyPath:@"error"];
  responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:errorMapping
																	method:RKRequestMethodPOST
															   pathPattern:kAPIPathLogin
																   keyPath:@"error"
															   statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassClientError)];

  [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
  
  responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:errorMapping
																	method:RKRequestMethodPOST
															   pathPattern:kAPIPathRegister
																   keyPath:@"error"
															   statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassClientError)];
  
  [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
  
}

- (NSManagedObjectContext *)managedObjectContext {
  return self.objectStore.persistentStoreManagedObjectContext;
}

- (id<APIErrorProtocol>)errorForOperation: (AFHTTPRequestOperation*)operation
							 withResponse:(NSDictionary *)response
								 andError:(NSError *)error  {
  __block NSString * domain = [response objectForKey:@"_error_type"];
  __block NSString *message = [response objectForKey:@"_error_message"];
  __block NSInteger statusCode = 200;
  if (!message) {
	[response enumerateKeysAndObjectsUsingBlock:^(NSString* key, NSDictionary* obj, BOOL *stop) {
	  domain = key;
//	  message = [obj firstObject];
	  message = [obj objectForKey:@"message"];
	  statusCode = [[obj objectForKey:@"code"]integerValue];
	  *stop = YES;
	}];
  }
  
//  NSInteger statusCode = operation.response.statusCode;
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
