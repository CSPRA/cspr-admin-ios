//
//  APIErrorProtocol.h
//  ICSAdmin
//
//  Created by Susmita Horrow on 28/10/15.
//  Copyright © 2015 GHCI-CSPR. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol APIErrorProtocol <NSObject>

@required

- (NSString *)message;
- (NSInteger)code;
- (NSString *)domain;

@end
