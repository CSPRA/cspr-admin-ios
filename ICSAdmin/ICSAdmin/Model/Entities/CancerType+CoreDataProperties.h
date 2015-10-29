//
//  CancerType+CoreDataProperties.h
//  
//
//  Created by Susmita Horrow on 28/10/15.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CancerType.h"

NS_ASSUME_NONNULL_BEGIN

@interface CancerType (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *id;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *about;

@end

NS_ASSUME_NONNULL_END
