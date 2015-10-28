//
//  APIInterface.m
//  ICSAdmin
//
//  Created by Susmita Horrow on 28/10/15.
//  Copyright © 2015 GHCI-CSPR. All rights reserved.
//

#import "APIInterface.h"
#import <Reachability/Reachability.h>
#import <CoreData/CoreData.h>


@interface APIInterface()

@property(nonatomic, readwrite)RKObjectManager *objectManager;
@property(nonatomic, readwrite)RKManagedObjectStore *objectStore;

@end

@implementation APIInterface

- (id)init {
  self = [super init];
  if (self != nil) {
	[self setupRestkit];
  }
  return self;
}

- (void)setupRestkit {
  [self setupRestkitConfigurations];
  [self setupObjectMappings];
}

- (void)cancelAllRequestAndMapping {
  [[RKObjectManager sharedManager].operationQueue cancelAllOperations];
}

- (void)handleFailureForHTTPOperation:(AFHTTPRequestOperation *)operation
							withError:(NSError *)error
				  withCompletionBlock:(ApiCompletionHandler)block {
  
  
  __block ApiCompletionHandler requestBlock = block;
  if (![[Reachability reachabilityForInternetConnection]isReachable]) {
	NSString *errorMessage = NSLocalizedString(@"ErrorNoConnectionWithServer", nil);
	NSDictionary  *dict = [NSDictionary dictionaryWithObject:errorMessage forKey:NSLocalizedDescriptionKey];
	NSError *networkError = [NSError errorWithDomain:@"Error" code:1 userInfo:dict];
	if(requestBlock){
	  APIError *apiError = [[APIError alloc] initWithError:networkError];
	  requestBlock(NO,nil,apiError);
	}
	return;
  }
  
  APIError  *apiError;
  apiError = [self apiErrorForHTTPOperation:operation error:error];
  if (block) {
	block(NO, nil, apiError);
  }
}

#pragma mark - RestKit API Methods

- (void)getPath:(NSString *)path
	 parameters:(NSDictionary *)parameters
	 completion:(ApiCompletionHandler)completionBlock {
  [self.objectManager.HTTPClient setParameterEncoding:AFJSONParameterEncoding];
  [self.objectManager.HTTPClient getPath:path
							  parameters:parameters
								 success:
   ^(AFHTTPRequestOperation *operation, id responseObject) {
	 NSDictionary *response =
	 [NSJSONSerialization JSONObjectWithData:responseObject
									 options:NSJSONReadingAllowFragments
									   error:nil];
	 completionBlock(YES, @[response?response:@""], nil);
   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	 [self handleFailureForHTTPOperation:operation
							   withError:error
					 withCompletionBlock:completionBlock];
   }];
}

- (void)postPath:(NSString *)path
	  parameters:(NSDictionary *)parameters
	  completion:(ApiCompletionHandler)completionBlock {
  [self.objectManager.HTTPClient setParameterEncoding:AFJSONParameterEncoding];
  [self.objectManager.HTTPClient postPath:path
							   parameters:parameters
								  success:
   ^(AFHTTPRequestOperation *operation, id responseObject) {
	 NSDictionary *response =
	 [NSJSONSerialization JSONObjectWithData:responseObject
									 options:NSJSONReadingAllowFragments
									   error:nil];
	 completionBlock(YES, @[response?response:@""], nil);
   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	 [self handleFailureForHTTPOperation:operation
							   withError:error
					 withCompletionBlock:completionBlock];
   }];
}

- (void)getObjectsAtPath:(NSString *)path
			  parameters:(NSDictionary *)parameters
			  completion:(ApiCompletionHandler)block {
  [self.objectManager getObjectsAtPath:path
							parameters:parameters
							   success:
   ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
	 [self handleSuccessWithMappingResult:mappingResult withCompletionBlock:block];
	 
   } failure:^(RKObjectRequestOperation *operation, NSError *error) {
	 [self handleFailureForOperation:operation
						   withError:error
				 withCompletionBlock:block];
   }];
}

- (void)getObject:(id)object
			 path:(NSString*)path
	   parameters:(NSDictionary*)params
	   completion:(ApiCompletionHandler)block {
  [self.objectManager getObject:object
						   path:path
					 parameters:nil
						success:
   ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
	 [self handleSuccessWithMappingResult:mappingResult withCompletionBlock:block];
   }failure:
   ^(RKObjectRequestOperation *operation, NSError *error) {
	 [self handleFailureForOperation:operation
						   withError:error
				 withCompletionBlock:block];
   }];
}

- (void)patchObject:(id)object
			   path:(NSString*)path
		 parameters:(NSDictionary*)params
		 completion:(ApiCompletionHandler)block {
  [self.objectManager patchObject:object
							 path:path
					   parameters:params
						  success:
   ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
	 [self handleSuccessWithMappingResult:mappingResult withCompletionBlock:block];
   }
						  failure:
   ^(RKObjectRequestOperation *operation, NSError *error) {
	 [self handleFailureForOperation:operation
						   withError:error
				 withCompletionBlock:block];
   }];
}

- (void)postObject:(id)object
			  path:(NSString*)path
		parameters:(NSDictionary*)params
		completion:(ApiCompletionHandler)block {
  [self.objectManager postObject:object
							path:path
					  parameters:params
						 success:
   ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
	 [self handleSuccessWithMappingResult:mappingResult withCompletionBlock:block];
   }
						 failure:
   ^(RKObjectRequestOperation *operation, NSError *error) {
	 [self handleFailureForOperation:operation
						   withError:error
				 withCompletionBlock:block];
   }];
}

- (void)multipartFormRequestWithObject:(id)object
								method:(RKRequestMethod)method
								  path:(NSString*)path
							parameters:(NSDictionary*)params
			 constructingBodyWithBlock:(void(^)(id<AFMultipartFormData> formData))bodyMakingBlock
							completion:(ApiCompletionHandler)block {
  NSMutableURLRequest *request =
  [self.objectManager multipartFormRequestWithObject:object
											  method:method
												path:path
										  parameters:params
						   constructingBodyWithBlock:bodyMakingBlock];
  
  RKObjectRequestOperation *operation =
  [self.objectManager managedObjectRequestOperationWithRequest:request
										  managedObjectContext:[self managedObjectContext]
   success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
	 [self handleSuccessWithMappingResult:mappingResult withCompletionBlock:block];
   } failure:^(RKObjectRequestOperation *operation, NSError *error) {
	 [self handleFailureForOperation:operation
						   withError:error
				 withCompletionBlock:block];
   }];
  [self.objectManager enqueueObjectRequestOperation:operation];
}


- (void)deleteObject:(id)object
				path:(NSString*)path
		  parameters:(NSDictionary*)params
		  completion:(ApiCompletionHandler)block {
  [self.objectManager deleteObject:object
							  path:path
						parameters:params
						   success:
   ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
	 [self handleSuccessWithMappingResult:mappingResult withCompletionBlock:block];
   }
						   failure:
   ^(RKObjectRequestOperation *operation, NSError *error) {
	 [self handleFailureForOperation:operation
						   withError:error
				 withCompletionBlock:block];
   }];
}

- (NSArray *)collectionFromMainQueueManagedObjectContext:(NSArray *)objects {
  NSMutableArray *retrievedObjects = [NSMutableArray arrayWithCapacity:[objects count]];
  for (id object in objects) {
	if ([object isKindOfClass:[NSManagedObject class]]) {
	  NSManagedObject *newObject =
	  [[self managedObjectContext] objectWithID:[object objectID]];
	  [retrievedObjects addObject:newObject];
	}
	else {
	  [retrievedObjects addObject:object];
	}
  }
  return retrievedObjects;
}

- (void)handleSuccessWithMappingResult:(RKMappingResult *)mappingResult
				   withCompletionBlock:(ApiCompletionHandler)block {
  NSArray *objects =
  [self collectionFromMainQueueManagedObjectContext:[mappingResult array]];
  if (block) {
	block(YES, objects, nil);
  }
}

- (void)handleFailureForOperation:(RKObjectRequestOperation *)operation
						withError:(NSError *)error
			  withCompletionBlock:(ApiCompletionHandler)block {
  [self handleFailureForHTTPOperation:operation.HTTPRequestOperation
							withError:error
				  withCompletionBlock:block];
}

- (APIError*)apiErrorForOperation:(RKObjectRequestOperation*)operation
							error:(NSError*)error {
  return [self apiErrorForHTTPOperation:operation.HTTPRequestOperation
								  error:error];
}

- (APIError*)apiErrorForHTTPOperation:(AFHTTPRequestOperation*)operation
								error:(NSError*)error {
  APIError * apiError ;
  NSData * errorData = operation.responseData;
  if (errorData != nil) {
	id parsedResponse = [RKMIMETypeSerialization objectFromData:errorData
													   MIMEType:RKMIMETypeJSON
														  error:nil];
	apiError = [self errorForOperation:operation withResponse:parsedResponse andError:error];
  }
  if (!apiError) {
	apiError = [APIError apiErrorWithError:error];
  }
  return apiError;
}


#pragma mark - APIInterface Protocol

- (void)setupRestkitConfigurations {
  NSAssert(NO, @"Subclass should implement this method to setup Restkit");
}

- (void)setupObjectMappings {
  NSAssert(NO, @"Subclass should implement this method to setup object mappings");
}

- (NSManagedObjectContext *)managedObjectContext {
  NSAssert(NO, @"Subclass should implement this method to return managedObjectContext for the Model");
  return nil;
}

- (id<APIErrorProtocol>)errorForOperation: (AFHTTPRequestOperation*)operation
							 withResponse:(NSDictionary *)response
								 andError:(NSError *)error {
  NSAssert(NO, @"Subclass should implement this method to return managedObjectContext for the Model");
  return nil;
}

- (void)setupAuthToken: (NSString*)authToken {
  NSAssert(NO, @"Subclass should implement this method to return managedObjectContext for the Model");
}

@end
