//
//  SearchViewController.m
//  ICSAdmin
//
//  Created by Susmita Horrow on 27/10/15.
//  Copyright © 2015 GHCI-CSPR. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *searchResults;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.searchResults.count;
}

@end
