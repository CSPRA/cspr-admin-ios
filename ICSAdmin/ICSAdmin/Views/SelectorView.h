//
//  SelectorView.h
//  ICSAdmin
//
//  Created by Susmita Horrow on 26/10/15.
//  Copyright (c) 2015 GHCI-CSPR. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapHandler)(NSIndexPath *indexPath);

@interface SelectorView : UIView

- (void)configureWithDataSource:(NSArray *)datasource withCellTapHandler:(TapHandler)cellTapHandler withDetailTapHandler:(TapHandler)detailTapHandler;

@end
