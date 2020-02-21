//
//  DataParser.h
//  ITunesSearcher
//
//  Created by Admin on 14.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ISSearchViewController;

@interface DataParser : NSObject

+ (void)updateSearchResult:(NSData *)data forSearchViewController:(ISSearchViewController *)searchViewController;

@end
