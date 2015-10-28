//
//  APIError.m
//  ICSAdmin
//
//  Created by Susmita Horrow on 28/10/15.
//  Copyright © 2015 GHCI-CSPR. All rights reserved.
//

#import "APIError.h"

NSString * kDefaultAPIErrorDomain = @"Error";
NSInteger  kDefaultAPIErrorCode = 1000;

@interface APIError()

@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, copy) NSString *domain;

@end

@implementation APIError


- (id)init {
  return [self initWithDomain:kDefaultAPIErrorDomain
					  message:NSLocalizedString(@"An Error Occured.", nil)
					  andCode:kDefaultAPIErrorCode];
}

#pragma mark - public methods

- (APIError *)initWithDomain:(NSString *)domain
					 message:(NSString *)message
					 andCode:(NSInteger)code {
  self = [super init];
  if (self) {
	_domain = domain;
	_message = message;
	_code = code;
  }
  return self;
}

- (id)initWithError:(NSError *)error {
  NSString *message = [error.userInfo objectForKey:NSLocalizedDescriptionKey];
  return [self initWithDomain:error.domain message:message andCode:error.code];
}

+ (APIError *)apiErrorWithError:(NSError *)error {
  APIError *apiError = [[APIError alloc] initWithError:error];
  return apiError;
}

- (NSString *)description {
  return [NSString stringWithFormat:@"APIError: code: %ld, domain: %@, message: %@",
   									(long)self.code, self.domain, self.message];
}

#pragma mark APIErrorProtocol

- (NSString *)message {
  return _message;
}

- (NSInteger)code {
  return _code;
}

- (NSString *)domain {
  return _domain;
}


@end
