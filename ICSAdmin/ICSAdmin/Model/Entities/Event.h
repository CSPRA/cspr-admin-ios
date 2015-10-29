//
//  Event.h
//  ICSAdmin
//
//  Created by Susmita Horrow on 29/10/15.
//  Copyright © 2015 GHCI-CSPR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CancerType.h"

typedef enum {
  kEventTypeRegister,
  kEventTypeScreening,
  kEventTypeBoth
}EventType;

typedef enum {
  kEventStatusOpen,
  kEventStatusClosed,
  kEventStatusNotStarted
}EventStatus;

@interface Event : NSObject

@property (nonatomic, strong) NSString *eventId;
@property (nonatomic, strong) NSString *eventName;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic, strong) NSString *eventTypeString;
@property (nonatomic, assign) EventType eventType;
@property (nonatomic, strong) CancerType *cancerType;
@property (nonatomic, assign) EventStatus status;
@property (nonatomic, strong) NSString *detectionFormId;
@property (nonatomic, strong) NSDate *createdAt;

@end
