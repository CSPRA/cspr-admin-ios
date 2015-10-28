//
//  CoreDataManager.m
//  ICSAdmin
//
//  Created by Susmita Horrow on 28/10/15.
//  Copyright © 2015 GHCI-CSPR. All rights reserved.
//

#import "CoreDataManager.h"

static NSString * const kResourceURL = @"ICSAdmin";
static NSString * const kResourceTypeMomd = @"momd";
static NSString * const kSqliteName = @"ICSAdmin.sqlite";

static CoreDataManager *_sharedInstance = nil;

@interface CoreDataManager()

@end

@implementation CoreDataManager

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+ (instancetype)shared {
  if(_sharedInstance == nil) {
	_sharedInstance = [[CoreDataManager alloc] init];
  }
  return _sharedInstance;
}

- (id)init {
  self = [super init];
  if(self) {
	
  	//Set up managedObjectModel
	
	NSURL *modelURL = [[NSBundle mainBundle] URLForResource:kResourceURL withExtension:@"momd"];
	_managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
	
	// Create the coordinator and store
	
	_persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
	NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:kSqliteName];
	NSError *error = nil;
	NSString *failureReason = @"There was an error creating or loading the application's saved data.";
	if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
	  // Report any error we got.
	  NSMutableDictionary *dict = [NSMutableDictionary dictionary];
	  dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
	  dict[NSLocalizedFailureReasonErrorKey] = failureReason;
	  dict[NSUnderlyingErrorKey] = error;
	  error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
	  NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	}

	// Set up managedObjectContext
	
	NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
	if (!coordinator) {
	  return nil;
	}
	_managedObjectContext = [[NSManagedObjectContext alloc] init];
	[_managedObjectContext setPersistentStoreCoordinator:coordinator];
  }
  
  return self;
}

#pragma mark - Core Data stack

- (NSError*)saveContext {
  NSError *error = nil;
  NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
  if (managedObjectContext != nil) {
	if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		return error;
	}
  }
  return nil;
}

- (NSURL *)applicationDocumentsDirectory {
  return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - Object Creation Method

- (NSManagedObject *)newObjectForEntityName:(NSString *)entityName{
  NSManagedObject *newObject =
  [NSEntityDescription insertNewObjectForEntityForName:entityName
								inManagedObjectContext:self.managedObjectContext];
  return newObject;
}


#pragma mark - Random Object Methods

- (id)randomObjectForEntityName:(NSString *)entityName
				  withPredicate:(NSPredicate *)predicate
			withSortDescriptors:(NSArray *)sortDescriptors
						  error:(NSError **)error {
  NSEntityDescription *entity =
  [NSEntityDescription entityForName:entityName
			  inManagedObjectContext:self.managedObjectContext];
  NSFetchRequest *request = [[NSFetchRequest alloc] init];
  request.entity = entity;
  if (predicate) {
	request.predicate = predicate;
  }
  if (sortDescriptors) {
	request.sortDescriptors = sortDescriptors;
  }
  NSInteger searchCount =
  [[CoreDataManager shared] objectCountForEntityName:entityName error:error];
  
  if (searchCount < 1 ) {
	return nil;
  }
  request.fetchOffset = arc4random() % searchCount;
  request.fetchLimit = 1;
  
  NSArray *objects = [self.managedObjectContext executeFetchRequest:request
															  error:error];
  if(*error || [objects count] < 1){
	if (*error) {
	  NSLog(@"objectsForEntityName Error : %@", *error);
	}
	return nil;
  }
  return [objects objectAtIndex:0];
}

#pragma mark - Object Fetch Methods

- (NSArray *)objectsForEntityName:(NSString *)entityName
					withPredicate:(NSPredicate *)predicate
			  withSortDescriptors:(NSArray *)sortDescriptors
							error:(NSError **)error {
  NSEntityDescription *entity =
  [NSEntityDescription entityForName:entityName
			  inManagedObjectContext:self.managedObjectContext];
  NSFetchRequest *request = [[NSFetchRequest alloc] init];
  request.entity = entity;
  if (predicate) {
	request.predicate = predicate;
  }
  if (sortDescriptors) {
	request.sortDescriptors = sortDescriptors;
  }
  
  NSArray *objects = [self.managedObjectContext executeFetchRequest:request error:error];
  if(*error || [objects count] < 1){
	if (*error) {
	  NSLog(@"objectsForEntityName Error : %@", *error);
	}
	return nil;
  }
  return objects;
}

- (NSArray *)objectsForEntityName:(NSString *)entityName
					withPredicate:(NSPredicate *)predicate
							error:(NSError **)error {
  return [self objectsForEntityName:entityName
					  withPredicate:predicate
				withSortDescriptors:nil
							  error:error];
}

- (NSArray *)objectsForEntityName:(NSString *)entityName
							error:(NSError **)error {
  return [self objectsForEntityName:entityName
					  withPredicate:nil
				withSortDescriptors:nil
							  error:error];
}

#pragma mark - Object Count Methods

- (NSInteger)objectCountForEntityName:(NSString *)entityName
						withPredicate:(NSPredicate *)predicate
				  withSortDescriptors:(NSArray *)sortDescriptors
								error:(NSError **)error {
  
  NSEntityDescription *entity =
  [NSEntityDescription entityForName:entityName
			  inManagedObjectContext:self.managedObjectContext];
  NSFetchRequest *request = [[NSFetchRequest alloc] init];
  request.entity = entity;
  if (predicate) {
	request.predicate = predicate;
  }
  if (sortDescriptors) {
	request.sortDescriptors = sortDescriptors;
  }
  return [self.managedObjectContext countForFetchRequest:request error:error];
}

- (NSInteger)objectCountForEntityName:(NSString *)entityName
						withPredicate:(NSPredicate *)predicate
								error:(NSError **)error {
  return [self objectCountForEntityName:entityName
						  withPredicate:predicate
					withSortDescriptors:nil
								  error:error];
}

- (NSInteger)objectCountForEntityName:(NSString *)entityName
								error:(NSError **)error {
  return [self objectCountForEntityName:entityName
						  withPredicate:nil
					withSortDescriptors:nil
								  error:error];
}

#pragma mark - Object Delete Methods

- (void)deleteObjectsForEntityName:(NSString *)entityName
					 withPredicate:(NSPredicate *)predicate
							 error:(NSError **)error {
  NSArray *objectsToBeDeleted =
  [self objectsForEntityName:entityName withPredicate:predicate error:error];
  [self deleteObjects:objectsToBeDeleted error:error];
}

- (void)deleteObjectsForEntityName:(NSString *)entityName
							 error:(NSError **)error {
  [self deleteObjectsForEntityName:entityName
					 withPredicate:nil
							 error:error];
}

- (void)deleteObjects:(NSArray *)objectsToBeDeleted error:(NSError **)error {
  for (NSManagedObject *object in objectsToBeDeleted) {
	[self.managedObjectContext deleteObject:object];
  }
  [self.managedObjectContext save:error];
}

- (void)deleteObject:(NSManagedObject *)objectToBeDeleted error:(NSError **)error {
  [self.managedObjectContext deleteObject:objectToBeDeleted];
  [self.managedObjectContext save:error];
}


@end
