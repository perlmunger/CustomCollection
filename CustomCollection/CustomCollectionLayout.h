//
//  CustomCollectionLayout.h
//  CustomCollection
//
//  Created by Matt Long on 11/27/12.
//  Copyright (c) 2012 Matt Long. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCollectionLayout : UICollectionViewLayout

@property (nonatomic, assign) CGPoint center;
@property (nonatomic, assign) NSInteger cellCount;

@property (nonatomic, strong) NSMutableArray *insertedIndexPaths;
@property (nonatomic, strong) NSMutableArray *deletedIndexPaths;


- (UICollectionViewLayoutAttributes*)appearanceAnimationAttributesForIndexPath:(NSIndexPath*)indexPath;
- (UICollectionViewLayoutAttributes*)disappearanceAnimationAttributesForIndexPath:(NSIndexPath*)indexPath;

@end
