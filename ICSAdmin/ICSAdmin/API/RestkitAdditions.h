//
//  RestkitAdditions.h
//  ICSAdmin
//
//  Created by Susmita Horrow on 28/10/15.
//  Copyright © 2015 GHCI-CSPR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/Restkit.h>

@protocol RestkitAdditions <NSObject>

@optional

+(RKObjectMapping *)restkitObjectMapping;
+(RKEntityMapping *)restkitObjectMappingForStore:(RKManagedObjectStore *)store;

+(RKObjectMapping *)serializationMapping;
+(RKEntityMapping *)serializationMappingForStore:(RKManagedObjectStore *)store;


@end
