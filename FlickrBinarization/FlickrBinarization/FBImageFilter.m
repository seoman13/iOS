//
//  FBImageFilter.m
//  FlickrBinarization
//
//  Created by Admin on 21.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "FBImageFilter.h"
#import <CoreImage/CoreImage.h>
#import <UIKit/UIKit.h>
#import "FBSearchViewController.h"
#import "FBImageItem.h"
@import CoreData;

@implementation FBImageFilter

+ (void)binarizeImage:(UIImage *)image inSearchViewController:(FBSearchViewController *)searchViewController atIndexPath:(NSIndexPath *)indexPath {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        CIFilter *filter = [CIFilter filterWithName:@"CIPhotoEffectMono"];
//        [filter setValue:image forKey:@"inputImage"];
//        CIImage *outputImage = [filter valueForKey:@"outputImage"];
//        CGImageRef cgimg = [[CIContext context] createCGImage:outputImage fromRect:outputImage.extent];
//        UIImage *binarizedImage = [UIImage imageWithCGImage:cgimg];
        
        // Create image rectangle with current image width/height
        CGRect imageRect = CGRectMake(0, 0, image.size.width, image.size.height);
        
        // Grayscale color space
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
        
        // Create bitmap content with current image size and grayscale colorspace
        CGContextRef context = CGBitmapContextCreate(nil, image.size.width, image.size.height, 8, 0, colorSpace, kCGImageAlphaNone);
        
        // Draw image into current context, with specified rectangle
        // using previously defined context (with grayscale colorspace)
        CGContextDrawImage(context, imageRect, [image CGImage]);
        
        // Create bitmap image info from pixel data in current context
        CGImageRef imageRef = CGBitmapContextCreateImage(context);
        
        // Create a new UIImage object
        UIImage *binarizedImage = [UIImage imageWithCGImage:imageRef];
        
        // Release colorspace, context and bitmap information
        CGColorSpaceRelease(colorSpace);
        CGContextRelease(context);
        CFRelease(imageRef);
        
        dispatch_async(dispatch_get_main_queue(), ^{
//            [searchViewController.binarizedPicturesCache setObject:binarizedImage forKey:searchViewController.searchResults[indexPath.row][@"urlString"]];
            NSArray <FBImageItem *> *imageItems = searchViewController.fetchedResultsController.fetchedObjects;
            FBImageItem *imageItem = imageItems[indexPath.row];
            [searchViewController.binarizedPicturesCache setObject:binarizedImage forKey:imageItem.urlString];
            [searchViewController.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        });
    });
    
}

@end
