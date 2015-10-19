//
//  ICSModel.h
//  ICSAdmin
//
//  Created by Susmita Horrow on 19/10/15.
//  Copyright (c) 2015 GHCI-CSPR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ICSModel : NSObject

- (ICSModel*)sharedModel;
- (BOOL)loggedInUserPresent;

@end
