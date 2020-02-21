//
//  FBCustomLayoutDelegate.h
//  FlickrBrowser
//
//  Created by Admin on 12.07.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

@protocol FBCustomLayoutDelegate <NSObject>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;

@end
