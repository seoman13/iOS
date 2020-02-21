//
//  FBCustomCollectionViewLayout.h
//  FlickrBrowser
//
//  Created by Admin on 12.07.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FBCollectionViewDelegate;

@interface FBCustomCollectionViewLayout : UICollectionViewLayout

@property (weak, nonatomic) FBCollectionViewDelegate *delegate;
@property (assign, nonatomic) NSUInteger numberOfColumns;
@property (assign, nonatomic) CGFloat cellPadding;

@end
