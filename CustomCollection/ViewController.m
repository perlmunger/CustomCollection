//
//  ViewController.m
//  CustomCollection
//
//  Created by Matt Long on 11/27/12.
//  Copyright (c) 2012 Matt Long. All rights reserved.
//

#import "ViewController.h"
#import "CustomCollectionCell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
  self.cellCount = 20;
  UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
  [self.collectionView addGestureRecognizer:tapRecognizer];
}

#pragma mark - UICollectionView DataSource/Delegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  CustomCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCellIdentifier" forIndexPath:indexPath];

  return cell;
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
  return self.cellCount;
}

- (void)handleTapGesture:(UITapGestureRecognizer *)sender {
  
  if (sender.state == UIGestureRecognizerStateEnded)
  {
    CGPoint initialPinchPoint = [sender locationInView:self.collectionView];
    NSIndexPath* tappedCellPath = [self.collectionView indexPathForItemAtPoint:initialPinchPoint];
    if (tappedCellPath!=nil)
    {
      self.cellCount = self.cellCount - 1;
      [self.collectionView performBatchUpdates:^{
        [self.collectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:tappedCellPath]];
        
      } completion:nil];
    }
    else
    {
      self.cellCount = self.cellCount + 1;
      [self.collectionView performBatchUpdates:^{
        [self.collectionView insertItemsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:0 inSection:0]]];
      } completion:nil];
    }
  }
}

@end
