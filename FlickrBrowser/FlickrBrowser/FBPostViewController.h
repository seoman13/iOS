//
//  PostViewController.h
//  FlickrBrowser
//
//  Created by Admin on 03.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FBPictureItem;

@interface FBPostViewController : UIViewController

-(void)setupPostViewWithPictureItem:(FBPictureItem *)pictureItem;

@end
