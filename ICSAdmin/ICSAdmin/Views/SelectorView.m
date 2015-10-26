//
//  SelectorView.m
//  ICSAdmin
//
//  Created by Susmita Horrow on 26/10/15.
//  Copyright (c) 2015 GHCI-CSPR. All rights reserved.
//

#import "SelectorView.h"

@interface SelectorView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic,copy) TapHandler detailTapHandler;
@property (nonatomic,copy) TapHandler cellSelectionHandler;


@end

@implementation SelectorView

- (void)awakeFromNib {
  self.tableView = [UITableView new];
  [self addSubview:self.tableView];
  
  
  self.tableView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  self.tableView.backgroundColor = [UIColor colorWithRed:216/255.0 green:224/255.0 blue:227/255.0 alpha:1.0];
  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  [self configureTableView];
}

- (void)configureTableView {
  self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
  NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading
  relatedBy:NSLayoutRelationEqual toItem:self.tableView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
  NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.tableView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
  NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.tableView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
	 NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.tableView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
	 [self addConstraints:@[leftConstraint,rightConstraint,topConstraint,bottomConstraint]];
}

- (void)configureWithDataSource:(NSArray *)datasource withCellTapHandler:(TapHandler)cellTapHandler withDetailTapHandler:(TapHandler)detailTapHandler {
  self.dataSource = [NSArray arrayWithArray:datasource];
  self.detailTapHandler = detailTapHandler;
  self.cellSelectionHandler = cellTapHandler;
  [self.tableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.dataSource.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SelectorCell"];
  cell.backgroundColor = [UIColor clearColor];
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  cell.textLabel.font = [UIFont systemFontOfSize:13.0];
  if (self.detailTapHandler) {
	[cell setAccessoryType:UITableViewCellAccessoryDetailButton];
	cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
  }else {
	cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
  }
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  [tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionMiddle animated:YES];
  cell.backgroundColor = [UIColor colorWithRed:149/255.0 green:212/255.0 blue:237/255.0 alpha:1.0];
  if (self.cellSelectionHandler) {
	self.cellSelectionHandler(indexPath);
  }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  cell.backgroundColor = [UIColor clearColor];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
  if (self.detailTapHandler) {
	self.detailTapHandler(indexPath);
  }
}

@end
