//
//  MySwitchTableViewCell.h
//  TestingCoreAnimation
//
//  Created by Admin on 09.12.17.
//  Copyright © 2017 crest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MySwitchCellDelegate.h"


@interface MySwitchTableViewCell : UITableViewCell

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UISwitch *rightSwitch;
@property (nonatomic, weak) id<MySwitchCellDelegate> delegate;

+ (NSString *)reuseIdentifier;

+ (CGFloat)cellDefaultHeight;

@end
