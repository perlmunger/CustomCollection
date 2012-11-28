//
//  ViewController.h
//  CustomCollection
//
//  Created by Matt Long on 11/27/12.
//  Copyright (c) 2012 Matt Long. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UICollectionViewController<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, assign) NSInteger cellCount;

@end
