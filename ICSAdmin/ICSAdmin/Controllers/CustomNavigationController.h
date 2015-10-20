//
//  CustomNavigationController.h
//  ICSAdmin
//
//  Created by Susmita Horrow on 20/10/15.
//  Copyright (c) 2015 GHCI-CSPR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RUMSlidingMenuCenterProtocol.h"

@interface CustomNavigationController : UINavigationController<RUMSlidingMenuCenterProtocol, UINavigationControllerDelegate>

@end
