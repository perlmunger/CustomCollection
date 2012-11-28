//
//  CustomCollectionLayout.m
//  CustomCollection
//
//  Created by Matt Long on 11/27/12.
//  Copyright (c) 2012 Matt Long. All rights reserved.
//

#import "CustomCollectionLayout.h"

#define ITEM_SIZE 300.0f

@implementation CustomCollectionLayout

- (id)initWithCoder:(NSCoder *)aDecoder
{
  self = [super initWithCoder:aDecoder];
  if (self) {
    _insertedIndexPaths = [[NSMutableArray alloc] init];
    _deletedIndexPaths = [[NSMutableArray alloc] init];
  }
  return self;
}

- (id)init
{
  self = [super init];
  if (self) {
    _insertedIndexPaths = [[NSMutableArray alloc] init];
    _deletedIndexPaths = [[NSMutableArray alloc] init];
  }
  return self;
}

- (void)prepareLayout
{
  [super prepareLayout];
  
  CGSize size = [[self collectionView] frame].size;
  _cellCount = [[self collectionView] numberOfItemsInSection:0];
  _center = CGPointMake(size.width / 2.0, size.height / 2.0);
}

- (CGSize)collectionViewContentSize
{
  return [[self collectionView] frame].size;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
{
  UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
  [attributes setSize:CGSizeMake(ITEM_SIZE, ITEM_SIZE)];
  [attributes setCenter:[self center]];
  [attributes setZIndex:[path row]*-1];
  NSInteger angle = arc4random() % 15;
  [attributes setTransform3D:CATransform3DMakeRotation(degreesToRadians(angle), 0.0f, 0.0f, 1.0f)];
  
  return attributes;
}

- (NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
  NSMutableArray* attributes = [NSMutableArray array];
  for (NSInteger i=0 ; i < self.cellCount; i++) {
    NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
    [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
  }
  return attributes;
}

- (void)prepareForCollectionViewUpdates:(NSArray*)updates
{
  [super prepareForCollectionViewUpdates:updates];
  for (UICollectionViewUpdateItem* updateItem in updates) {
    if ([updateItem updateAction] == UICollectionUpdateActionInsert) {
      [_insertedIndexPaths addObject:[updateItem indexPathAfterUpdate]];
    } else if ([updateItem updateAction] == UICollectionUpdateActionDelete) {
      [_deletedIndexPaths addObject:[updateItem indexPathBeforeUpdate]];
    }
  }
}

- (UICollectionViewLayoutAttributes*)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath*)indexPath
{
  return [_insertedIndexPaths containsObject:indexPath] ? [self appearanceAnimationAttributesForIndexPath:indexPath] : [super initialLayoutAttributesForAppearingItemAtIndexPath:indexPath];
}

- (UICollectionViewLayoutAttributes*)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath*)indexPath
{
  return [_deletedIndexPaths containsObject:indexPath] ? [self disappearanceAnimationAttributesForIndexPath:indexPath] : [super finalLayoutAttributesForDisappearingItemAtIndexPath:indexPath];
}

- (void)finalizeCollectionViewUpdates
{
  [_insertedIndexPaths removeAllObjects];
  [_deletedIndexPaths removeAllObjects];
}

- (UICollectionViewLayoutAttributes*)appearanceAnimationAttributesForIndexPath:(NSIndexPath*)indexPath
{
  UICollectionViewLayoutAttributes* attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
  [attributes setAlpha:0.0];
  [attributes setCenter:CGPointMake(_center.x, _center.y)];
  [attributes setTransform3D:CATransform3DMakeScale(25.0, 25.0, 1.0)];

  return attributes;
}

- (UICollectionViewLayoutAttributes*)disappearanceAnimationAttributesForIndexPath:(NSIndexPath*)indexPath
{
  UICollectionViewLayoutAttributes* attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
  [attributes setAlpha:0.0];
  [attributes setCenter:CGPointMake(_center.x, _center.y)];
  [attributes setTransform3D:CATransform3DMakeScale(25.0, 25.0, 1.0)];

  return attributes;
}

@end
