//
//  CreateFormViewController.m
//  ICSAdmin
//
//  Created by Susmita Horrow on 27/10/15.
//  Copyright (c) 2015 GHCI-CSPR. All rights reserved.
//

#import "QuestionnaireViewController.h"
#import "FormViewController.h"
#import "SearchViewController.h"

@interface QuestionnaireViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIButton *formNameButton;
@property (weak, nonatomic) IBOutlet UIButton *sectionButton;
@property (weak, nonatomic) IBOutlet UICollectionView *sectionIndicator;

@property (strong, nonatomic) NSMutableArray *sections;

@end

@implementation QuestionnaireViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.sections = [NSMutableArray new];
//  self.sections = [NSMutableArray arrayWithObjects:@"Medical History",@"Life Style",@"Reports",nil];
  NSString *title = self.sections.count == 0 ? @"Section Name" : [self.sections firstObject];
  [self.sectionButton setTitle:[NSString stringWithFormat:@"%@",title]
					  forState:UIControlStateNormal];
					  }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapOnSection:(id)sender {
  SearchViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"searchVC"];
  [self.navigationController pushViewController:vc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)didTapOnNameButton:(id)sender {
  FormViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"formVC"];
  [self.navigationController pushViewController:vc animated:YES];
//  [self presentViewController:vc animated:YES completion:^{
//	
//  }];

}

#pragma mark - UICollectionViewDataSource methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.sections.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"sectionCell" forIndexPath:indexPath];
  UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
  title.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
  [cell.contentView addSubview:title];
  cell.backgroundColor = [UIColor colorWithRed:216/255.0 green:224/255.0 blue:227/255.0 alpha:1.0];

  title.center = cell.contentView.center;
  return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout methods

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return CGSizeMake(60, 60);
}

#pragma mark - UICollectionViewDelegate methods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  [self.sectionButton setTitle:[NSString stringWithFormat:@"%@",[self.sections objectAtIndex:indexPath.row]]
  					  forState:UIControlStateNormal];
  UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
  cell.backgroundColor = [UIColor colorWithRed:149/255.0 green:212/255.0 blue:237/255.0 alpha:1.0];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
  UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
  cell.backgroundColor = [UIColor colorWithRed:216/255.0 green:224/255.0 blue:227/255.0 alpha:1.0];

}
@end
