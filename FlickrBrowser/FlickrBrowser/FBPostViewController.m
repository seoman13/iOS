//
//  FBPostViewController.m
//  FlickrBrowser
//
//  Created by Admin on 03.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "FBPostViewController.h"
#import <Masonry/Masonry.h>
#import "FBPictureItem.h"
#import "FBImageManager.h"
#import "FBImageLoader.h"
#import "FBImageSetter.h"
#import "FBDataLoaderFromFlickr.h"
#import "FBRouter.h"
#import "FBDataParser.h"

@interface FBPostViewController ()

@property (strong, nonatomic) UIButton *avatarButton;
@property (strong, nonatomic) UIActivityIndicatorView *avatarIndicator;
@property (strong, nonatomic) UILabel *usernameLabel;
@property (strong, nonatomic) UILabel *location;
@property (strong, nonatomic) UIActivityIndicatorView *locationIndicator;
@property (strong, nonatomic) UIImageView *myImageView;
@property (strong, nonatomic) UIActivityIndicatorView *imageActivityIndicator;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *comments;
@property (strong, nonatomic) FBImageManager *imageManager;
@property (strong, nonatomic) FBImageSetter *imageSetter;
@property (strong, nonatomic) FBImageLoader *imageLoader;

@end

@implementation FBPostViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _imageManager = [FBImageManager sharedManager];
        _imageSetter = [[FBImageSetter alloc] init];
        _imageLoader = [[FBImageLoader alloc] init];
        [self configureSubviews];
    }
    return self;
}

- (void)configureSubviews {
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    // Set UIView
    CGFloat width = CGRectGetWidth(self.view.bounds);
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width / 2, 32.0)];
    view.bounds = CGRectOffset(view.bounds, 29, 0);
    // Setup button
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    btn.layer.cornerRadius = 16.0;
    btn.clipsToBounds = YES;
//    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(avatarButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left);
        make.centerY.equalTo(view.mas_centerY);
        make.width.mas_equalTo(32.0);
        make.height.mas_equalTo(32.0);
    }];
    self.avatarButton = btn;
    // Setup button activity indicator
    UIActivityIndicatorView *avatarIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [view addSubview:avatarIndicator];
    [avatarIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.avatarButton.mas_centerX);
        make.centerY.equalTo(self.avatarButton.mas_centerY);
        make.width.equalTo(self.avatarButton.mas_width);
        make.height.equalTo(self.avatarButton.mas_height);
    }];
    self.avatarIndicator = avatarIndicator;
    // Setup location icon
    UIImageView *locationIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fill2800"]];
    [view addSubview:locationIconView];
    [locationIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarButton.mas_right).with.offset(16);
        make.bottom.equalTo(self.avatarButton.mas_bottom).with.offset(-1);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(10);
    }];
    // Setup Location label
    UILabel *locationLabel = [UILabel new];
    locationLabel.font = [UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:13.0];
    [locationLabel setTextColor:[UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0]];
//    [locationLabel setText:@"Town, Country"];
    [view addSubview:locationLabel];
    [locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(locationIconView.mas_right).with.offset(4);
        make.centerY.equalTo(locationIconView.mas_centerY);
        make.height.mas_equalTo(15);
    }];
    self.location = locationLabel;
    // Location Activity Indicator
    UIActivityIndicatorView *locationIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [view addSubview:locationIndicator];
    [locationIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(locationLabel.mas_centerY);
        make.centerX.equalTo(locationLabel.mas_left).with.offset(30);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
    }];
    self.locationIndicator = locationIndicator;
    // Setup username label
    UILabel *usernameLabel = [UILabel new];
    usernameLabel.font = [UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:14.0];
    usernameLabel.text = @"username";
    [usernameLabel setTextColor:[UIColor blackColor]];
    [view addSubview:usernameLabel];
    [usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(locationIconView.mas_left);
        make.bottom.equalTo(locationIconView.mas_top).with.offset(-6);
        make.height.mas_equalTo(16);
    }];
    self.usernameLabel = usernameLabel;
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.leftItemsSupplementBackButton = YES;
    self.navigationItem.leftBarButtonItem = leftButton;
    
    // Set ImageView
    UIImageView *myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds) - 2, 248)];
    [self.view addSubview:myImageView];
    [myImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(65);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(self.view.mas_width).with.offset(-2);
        make.height.mas_equalTo(248);
    }];
    self.myImageView = myImageView;
    
    // Setup activity indicator for ImageView
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    activityIndicator.color = [UIColor grayColor];
    [activityIndicator setColor:[UIColor redColor]];
    [activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.myImageView.mas_centerX);
        make.centerY.equalTo(self.myImageView.mas_centerY);
        make.width.equalTo(self.myImageView.mas_width);
        make.height.equalTo(self.myImageView.mas_height);
    }];
    self.imageActivityIndicator = activityIndicator;
    // Setup tableView
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.myImageView.mas_bottom);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(self.view.mas_height);
    }];
    self.tableView = tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)avatarButtonPressed:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupPostViewWithPictureItem:(FBPictureItem *)pictureItem {
    // Set userName
    [self.usernameLabel setText:pictureItem.userName];
    // Set Big Image
    __weak UIActivityIndicatorView *act = self.imageActivityIndicator;
    [act startAnimating];
    [self.imageLoader loadImageAtAddress:[NSURL URLWithString:pictureItem.pictureUrlString]  desiredSize:FBPictureItemImageSizeLarge handler:^(UIImage *image) {
        [act stopAnimating];
        self.myImageView.image = image;
    }];
    // Set Avatar
    __weak UIActivityIndicatorView *avatarIndicator = self.avatarIndicator;
    [avatarIndicator startAnimating];
    [self.imageLoader loadImageAtAddress:[NSURL URLWithString:pictureItem.avatarUrlString] desiredSize:FBPictureItemImageSizeAvatar handler:^(UIImage *avatar) {
        if (avatar != nil) {
            [self.avatarButton setImage:avatar forState:UIControlStateNormal];
            [avatarIndicator stopAnimating];
        } else {
            [self.avatarButton setImage:[UIImage imageNamed:@"noImage"] forState:UIControlStateNormal];
            [avatarIndicator stopAnimating];
        }
    }];
    
    // Set Location
    __weak UIActivityIndicatorView *locationIndicator = self.locationIndicator;
    [locationIndicator startAnimating];
    [self getLocationInfoWithPictureId:pictureItem.pictureId success:^(NSDictionary *location) {
        if ([location[@"hasLocation"] isEqualToNumber:@YES]) {
            NSString *city = location[@"town"];
            NSString *country = location[@"country"];
            self.location.text = [NSString stringWithFormat:@"%@, %@", city, country];
        } else {
            self.location.text = @"Unknown";
        }
        [locationIndicator stopAnimating];
    } failure:^(NSError *error) {
        NSLog(@"Couldn't load Location Name. Error: %@", error.localizedDescription);
        [locationIndicator stopAnimating];
    }];
}

- (void)getLocationInfoWithPictureId:(NSString *)pictureId success:(void(^)(NSDictionary *))success failure:(void(^)(NSError *))failure {
    NSURLRequest *request = [FBRouter pictureInfoRequestWithPictureId:pictureId];
    [FBDataLoaderFromFlickr getDataWithRequest:request success:^(NSData *data) {
        [FBDataParser parsePictureInfoFromData:data success:^(NSArray *dataArray) {
            NSDictionary *pictureInfo = [dataArray firstObject];
            dispatch_async(dispatch_get_main_queue(), ^{
                success(pictureInfo);
            });
        } failure:^(NSError *error) {
            NSLog(@"Couldn't parse data. Error: %@", error.localizedDescription);
        }];
    } failure:^(NSError *err) {
        NSLog(@"Couldn't load location data. Error: %@", err.localizedDescription);
    }];
}

@end
