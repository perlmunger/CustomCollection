//
//  CustomCollectionCell.m
//  CustomCollection
//
//  Created by Matt Long on 11/27/12.
//  Copyright (c) 2012 Matt Long. All rights reserved.
//

#import "CustomCollectionCell.h"

@implementation CustomCollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      [self setAttributes];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self setAttributes];
  }
  return self;
}

- (void)setAttributes
{
  [self setBackgroundColor:[UIColor lightGrayColor]];
  [[self layer] setBorderWidth:5.0f];
  [[self layer] setBorderColor:[[UIColor whiteColor] CGColor]];
}

@end
