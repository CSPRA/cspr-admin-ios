//
//  CoreDataManager.h
//  ICSAdmin
//
//  Created by Susmita Horrow on 28/10/15.
//  Copyright © 2015 GHCI-CSPR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (instancetype)shared;

- (NSURL *)applicationDocumentsDirectory;
- (NSError *)saveContext;

#pragma mark - Object Creation Method

- (NSManagedObject *)newObjectForEntityName:(NSString *)entityName;

#pragma mark - Random Object Methods

- (id)randomObjectForEntityName:(NSString *)entityName
				  withPredicate:(NSPredicate *)predicate
			withSortDescriptors:(NSArray *)sortDescriptors
						  error:(NSError **)error;

#pragma mark - Object Fetch Methods

- (NSArray *)objectsForEntityName:(NSString *)entityName
					withPredicate:(NSPredicate *)predicate
			  withSortDescriptors:(NSArray *)sortDescriptors
							error:(NSError **)error;


- (NSArray *)objectsForEntityName:(NSString *)entityName
					withPredicate:(NSPredicate *)predicate
							error:(NSError **)error;

- (NSArray *)objectsForEntityName:(NSString *)entityName
							error:(NSError **)error;


#pragma mark - Object Count Methods

- (NSInteger)objectCountForEntityName:(NSString *)entityName
						withPredicate:(NSPredicate *)predicate
				  withSortDescriptors:(NSArray *)sortDescriptors
								error:(NSError **)error;

- (NSInteger)objectCountForEntityName:(NSString *)entityName
						withPredicate:(NSPredicate *)predicate
								error:(NSError **)error;

- (NSInteger)objectCountForEntityName:(NSString *)entityName
								error:(NSError **)error;

#pragma mark - Object Delete Methods

- (void)deleteObjectsForEntityName:(NSString *)entityName
					 withPredicate:(NSPredicate *)predicate
							 error:(NSError **)error;

- (void)deleteObjectsForEntityName:(NSString *)entityName
							 error:(NSError **)error;

- (void)deleteObjects:(NSArray *)objectsToBeDeleted error:(NSError **)error;

- (void)deleteObject:(NSManagedObject *)objectToBeDeleted error:(NSError **)error;

@end
