//
//  ISTrackCell.m
//  ITunesSearcher
//
//  Created by Admin on 11.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "ISTrackCell.h"
#import <Masonry/Masonry.h>

NSString *const trackCellIdentifier = @"ISTrackCellIdentifier";

@interface ISTrackCell ()

@end

@implementation ISTrackCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configureCellView];
    }
    return self;
}

- (void)configureCellView {
    // Setting up cell's artwork
    self.myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60.0, 60.0)];
    self.myImageView.layer.cornerRadius = 30.0;
    self.myImageView.clipsToBounds = YES;
    [self addSubview:self.myImageView];
    [self.myImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).with.offset(10);
        make.width.mas_equalTo(60.0);
        make.height.mas_equalTo(60.0);
    }];
    
    // Setting up UIActivityView
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:self.activityIndicator];
    [self.activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).with.offset(10);
        make.width.mas_equalTo(60.0);
        make.height.mas_equalTo(60.0);
    }];
    
    // Setting up Song title
    self.titleLabel = [UILabel new];
    self.titleLabel.font = [UIFont fontWithName:@"Georgia" size:16.0];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.myImageView.mas_top).with.offset(10);
        make.left.equalTo(self.myImageView.mas_right).with.offset(5);
        make.right.lessThanOrEqualTo(self.mas_right).with.offset(-150);
        make.width.lessThanOrEqualTo(self.mas_width).with.offset(-165);
    }];
    
    // Seting up Artist name
    self.artistLabel = [UILabel new];
    self.artistLabel.font = [UIFont fontWithName:@"Georgia" size:14.0];
    self.artistLabel.textColor = [UIColor grayColor];
    [self addSubview:_artistLabel];
    [_artistLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(4);
        make.left.equalTo(self.titleLabel.mas_left);
        make.right.lessThanOrEqualTo(self.mas_right).with.offset(-150);
        make.width.lessThanOrEqualTo(self.mas_width).with.offset(-165);
    }];
    
    // Setting up Progress View
    self.progressView = [UIProgressView new];
    self.progressView.hidden = YES;
    [self addSubview:_progressView];
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.artistLabel.mas_bottom).with.offset(4);
        make.left.equalTo(self.titleLabel.mas_left);
        make.width.equalTo(self.mas_width).with.offset(-165);
    }];
    
    // Setting up Price Label and its wrapper
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self addSubview:self.priceLabel];
    UIColor *deepPink = [UIColor colorWithRed:255/255.0 green:20/255.0 blue:147/255.0 alpha:1.0];
    self.priceLabel.textColor = deepPink;
    self.priceLabel.layer.borderColor = [deepPink CGColor];
    self.priceLabel.layer.cornerRadius = 5.0;
    self.priceLabel.clipsToBounds = YES;
    self.priceLabel.layer.borderWidth = 1.0;
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.progressView.mas_right).with.offset(-3);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    // Setting up Download Button
    self.downloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.downloadButton setTitle:@"Download" forState:UIControlStateNormal];
    [self.downloadButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.downloadButton.titleLabel.font = [UIFont fontWithName:@"Georgia" size:15.0];
    self.downloadButton.titleLabel.shadowColor = [UIColor grayColor];
    [self addSubview:_downloadButton];
    [self.downloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.progressView.mas_right).with.offset(13);
        make.top.equalTo(self.titleLabel.mas_top).with.offset(5);
    }];
    [self.downloadButton addTarget:self action:@selector(downloadTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    // Setting up Pause Button
    self.pauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
    [self.pauseButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.pauseButton.titleLabel.font = [UIFont fontWithName:@"Georgia" size:15.0];
    self.pauseButton.titleLabel.shadowColor = [UIColor grayColor];
    [self addSubview:_pauseButton];
    [self.pauseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.downloadButton.mas_centerX);
        make.centerY.equalTo(self.downloadButton.mas_centerY).with.offset(-20);
        
    }];
    [self.pauseButton addTarget:self action:@selector(pauseOrResumeTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.pauseButton setHidden:YES];
    
    // Setting up Cancel Button
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = [UIFont fontWithName:@"Georgia" size:15.0];
    self.cancelButton.titleLabel.shadowColor = [UIColor grayColor];
    [self addSubview:_cancelButton];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.downloadButton.mas_centerX);
        make.centerY.equalTo(self.downloadButton.mas_centerY).with.offset(-2);
    }];
    [self.cancelButton addTarget:self action:@selector(cancelTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelButton setHidden:YES];
    
    // Setting up Progress Label
    self.progressLabel = [UILabel new];
    self.progressLabel.text = @"";
    self.progressLabel.textColor = [UIColor grayColor];
    self.progressLabel.font = [UIFont fontWithName:@"Georgia" size:11.0];
    [self addSubview:_progressLabel];
    [self.progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.progressView.mas_bottom).with.offset(3);
        make.centerX.equalTo(self.downloadButton.mas_centerX);
        make.left.greaterThanOrEqualTo(self.progressView.mas_right).with.offset(5);
    }];
}

- (void)pauseOrResumeTapped:(UIButton *)sender {
    if ([sender.titleLabel.text compare:@"Pause"] == NSOrderedSame) {
        [_delegate pauseTapped:self];
    } else {
        [_delegate resumeTapped:self];
    }
}

- (void)cancelTapped:(UIButton *)sender {
    [_delegate cancelTapped:self];
}

- (void)downloadTapped:(UIButton *)sender {
    [_delegate downloadTapped:self];
}

@end
