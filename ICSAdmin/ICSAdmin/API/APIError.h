//
//  APIError.h
//  ICSAdmin
//
//  Created by Susmita Horrow on 28/10/15.
//  Copyright © 2015 GHCI-CSPR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIErrorProtocol.h"

extern NSString * kDefaultAPIErrorDomain;
extern NSInteger  kDefaultAPIErrorCode;

@interface APIError : NSObject<APIErrorProtocol>

- (id)initWithDomain:(NSString *)domain
			 message:(NSString *)message
			 andCode:(NSInteger)code;

- (id)initWithError:(NSError *)error;

+ (APIError *)apiErrorWithError:(NSError *)error;

- (NSString *)description;

@end
