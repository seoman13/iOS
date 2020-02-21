//
//  FBSearchBarDelegate.h
//  FlickrBrowser
//
//  Created by Admin on 23.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class FBSearchPanelViewController;

@interface FBSearchBarDelegate : NSObject <UISearchBarDelegate>

- (instancetype)initWithSearchPanelViewController:(FBSearchPanelViewController *)searchPanelViewController;

@end
