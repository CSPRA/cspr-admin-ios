//
//  APIInterface.h
//  ICSAdmin
//
//  Created by Susmita Horrow on 28/10/15.
//  Copyright © 2015 GHCI-CSPR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIError.h"
#import <RestKit/RestKit.h>

typedef enum {
  APIErrorStatusCodeBadRequest = 400,
  APIErrorStatusCodeUnauthorized = 401,
  APIErrorStatusCodeForbidden = 403,
  APIErrorStatusCodeNotFound = 404
}APIErrorStatusCode;


typedef void (^ApiCompletionHandler)(BOOL success, NSArray *result, APIError *error);


@protocol APIInterface <NSObject>

@required

/*
 In this method , a subclass should configure Restkit, Object Manager and Object Store.
 */
- (void)setupRestkitConfigurations;

/*This method should be implemented by subclass to provide RestKit mapping for all objects.*/
- (void)setupObjectMappings;

/*Subclass should return the context.*/
- (NSManagedObjectContext *)managedObjectContext;

/*Should be implementd by subclass to handle any error in the response. */
- (id<APIErrorProtocol>)errorForOperation: (AFHTTPRequestOperation*)operation
							 withResponse:(NSDictionary *)response
								 andError:(NSError *)error;

- (void)setupAuthToken: (NSString*)authToken;

@end

@interface APIInterface : NSObject<APIInterface> {

@public
  RKObjectManager *_objectManager;
  RKManagedObjectStore *_objectStore;
}

@property(nonatomic, readonly)RKObjectManager *objectManager;
@property(nonatomic, readonly)RKManagedObjectStore *objectStore;

- (void)cancelAllRequestAndMapping;


- (void)postPath:(NSString *)path
	  parameters:(NSDictionary *)parameters
	  completion:(ApiCompletionHandler)completionBlock;

- (void)getPath:(NSString *)path
	 parameters:(NSDictionary *)parameters
	 completion:(ApiCompletionHandler)completionBlock;

- (void)getObjectsAtPath:(NSString *)path
			  parameters:(NSDictionary *)parameters
			  completion:(ApiCompletionHandler)block;

- (void)getObject:(id)object
			 path:(NSString*)path
	   parameters:(NSDictionary*)params
	   completion:(ApiCompletionHandler)block;

- (void)postObject:(id)object
			  path:(NSString*)path
		parameters:(NSDictionary*)params
		completion:(ApiCompletionHandler)block;

- (void)deleteObject:(id)object
				path:(NSString*)path
		  parameters:(NSDictionary*)parameters
		  completion:(ApiCompletionHandler)block;

- (void)patchObject:(id)object
			   path:(NSString*)path
		 parameters:(NSDictionary*)parameters
		 completion:(ApiCompletionHandler)block;

- (void)multipartFormRequestWithObject:(id)object
								method:(RKRequestMethod)method
								  path:(NSString*)path
							parameters:(NSDictionary*)params
			 constructingBodyWithBlock:(void(^)(id<AFMultipartFormData> formData))bodyMakingBlock
							completion:(ApiCompletionHandler)block;

- (NSArray *)collectionFromMainQueueManagedObjectContext:(NSArray *)objects;

@end
