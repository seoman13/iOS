//
//  FBImageItem.h
//  FlickrBinarization
//
//  Created by Admin on 19.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface FBImageItem : NSManagedObject
@property (nonatomic) u_int32_t numberWhenAdded;
@property (nonatomic, strong) NSString *pictureId;
@property (nonatomic, strong) NSString *secret;
@property (nonatomic, strong) NSString *server;
@property (strong, nonatomic) NSString *farm;
@property (nonatomic, strong) NSString *urlString;

@end
