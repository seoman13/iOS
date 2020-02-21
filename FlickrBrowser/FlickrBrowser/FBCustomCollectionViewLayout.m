//
//  FBCustomCollectionViewLayout.m
//  FlickrBrowser
//
//  Created by Admin on 12.07.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "FBCustomCollectionViewLayout.h"

@interface FBCustomCollectionViewLayout ()

@property (strong, nonatomic) NSArray <UICollectionViewLayoutAttributes *> *cache;
@property (assign, nonatomic) CGFloat contentHeight;
@property (assign, nonatomic) CGFloat contentWidth;

@end

@implementation FBCustomCollectionViewLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        _numberOfColumns = 3;
        _cellPadding = 1.0;
        _contentHeight = 0.0;
    }
    return self;
}

- (void)prepareLayout {
    if (self.cache == nil) {
        UIEdgeInsets insets = self.collectionView.contentInset;
        self.contentWidth = CGRectGetWidth(self.collectionView.bounds) - (insets.left + insets.right);
        CGFloat columnWidth = self.contentWidth / self.numberOfColumns;
        int num = (int)self.numberOfColumns;
        CGFloat xOffset[num];
        for (NSInteger column = 0; column < self.numberOfColumns; column++) {
            CGFloat clm = (CGFloat)column;
            xOffset[column] = clm * columnWidth;
        }
        NSInteger column = 0;
        
        
    }
}

@end
