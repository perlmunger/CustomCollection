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
  [self setCellCount:1];
}

#pragma mark - UICollectionView DataSource/Delegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  CustomCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCellIdentifier" forIndexPath:indexPath];
  [[cell layer] setContents:(id)[[self randomImage] CGImage]];
  return cell;
}

- (UIImage*)randomImage
{
  NSInteger random = arc4random() % 11;
  return [UIImage imageNamed:[NSString stringWithFormat:@"%d", random]];
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
  return [self cellCount];
}

- (IBAction)handleTapGesture:(UITapGestureRecognizer *)sender
{
  if ([sender state ] == UIGestureRecognizerStateEnded)
  {
    CGPoint initialPinchPoint = [sender locationInView:[self collectionView]];
    NSIndexPath* tappedCellPath = [[self collectionView] indexPathForItemAtPoint:initialPinchPoint];
    if (tappedCellPath!=nil) {
      [self setCellCount:[self cellCount] - 1];
      [[self collectionView] performBatchUpdates:^{
        [[self collectionView] deleteItemsAtIndexPaths:[NSArray arrayWithObject:tappedCellPath]];
        
      } completion:nil];
    } else {
      [self setCellCount:[self cellCount] + 1];
      [[self collectionView] performBatchUpdates:^{
        [[self collectionView] insertItemsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:0 inSection:0]]];
      } completion:nil];
    }
  }
}

@end
