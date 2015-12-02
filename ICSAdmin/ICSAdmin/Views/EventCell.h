//
//  EventCell.h
//  ICSAdmin
//
//  Created by Susmita Horrow on 01/11/15.
//  Copyright © 2015 GHCI-CSPR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface EventCell : UITableViewCell

- (void)configureWithEvent:(Event *)event;

@end
