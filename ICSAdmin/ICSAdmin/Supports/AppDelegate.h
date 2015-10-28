//
//  AppDelegate.h
//  ICSAdmin
//
//  Created by Susmita Horrow on 19/10/15.
//  Copyright (c) 2015 GHCI-CSPR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <RUMSlidingMenuViewController.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) RUMSlidingMenuViewController *slidingMenuContainer;

- (void)showHomeFlow;

@end

