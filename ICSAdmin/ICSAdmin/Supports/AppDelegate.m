//
//  AppDelegate.m
//  ICSAdmin
//
//  Created by Susmita Horrow on 19/10/15.
//  Copyright (c) 2015 GHCI-CSPR. All rights reserved.
//

#import "AppDelegate.h"
#import "ContainerViewController.h"
#import "LoginViewController.h"
#import <RUMSlidingMenuViewController.h>
#import "MenuViewController.h"
#import "HomeViewController.h"
#import "CustomNavigationController.h"
#import "CoreDataManager.h"
#import "ICSDataManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// Override point for customization after application launch.
  [self setupRootViewController];
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	// Saves changes in the application's managed object context before the application terminates.
	[[CoreDataManager shared] saveContext];
}

#pragma mark - 

-(void)setupRootViewController {
  UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
  UIStoryboard *loginStoryBoard = [UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]];
//  CustomNavigationController *navVC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"MainNavigation"];
  UINavigationController *loginNavigation = [loginStoryBoard instantiateViewControllerWithIdentifier:@"LoginNavigation"];
  
  MenuViewController *menuVC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"MenuVC"];
  HomeViewController *homeVC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"HomeVC"];
  CustomNavigationController *navVC = [[CustomNavigationController alloc]initWithRootViewController:homeVC];
  self.slidingMenuContainer = [[RUMSlidingMenuViewController alloc]initWithRootViewController:navVC
  leftViewController:menuVC
  rightViewController:nil];
  
  NSLog(@"main = %@",self.slidingMenuContainer.mainViewController);
//  UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:slidingMenuContainer];
//  [navVC setTitle:@"Home"];
//  [navVC setViewControllers:@[slidingMenuContainer]];
  NSLog(@"current User = %@",[[ICSDataManager shared] currentUser]);
  if ([[ICSDataManager shared] currentUser]) {
ContainerViewController *containerVC = [[ContainerViewController alloc]initWithViewControllers:@[self.slidingMenuContainer,loginNavigation]];
self.window.rootViewController = containerVC;
//	[self showHomeFlow];
  }else {
//	[self showLoginFlow];
 ContainerViewController *containerVC = [[ContainerViewController alloc]initWithViewControllers:@[loginNavigation,self.slidingMenuContainer]];
 self.window.rootViewController = containerVC;

  }
  
  [self.window makeKeyAndVisible];
}

- (ContainerViewController *)containerViewController {
  return (ContainerViewController *) self.window.rootViewController;
}

- (void)showLoginFlow {
  [[self containerViewController]moveToViewControllerWithIndex:0];
}

- (void)showHomeFlow {
  [[self containerViewController]moveToViewControllerWithIndex:1];
}

@end
