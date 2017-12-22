//
//  MySwitchTableViewCell.m
//  TestingCoreAnimation
//
//  Created by Admin on 09.12.17.
//  Copyright © 2017 crest. All rights reserved.
//

#import "MySwitchTableViewCell.h"


@implementation MySwitchTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self configureCellInterface];
    }
    return self;
}

- (void)configureCellInterface {
    CGRect textViewFrame = CGRectMake(20, 10, CGRectGetWidth(self.contentView.bounds) - 80, 80);
    self.textView = [[UITextView alloc] initWithFrame:textViewFrame];
    self.textView.userInteractionEnabled = NO;
    [self.contentView addSubview:self.textView];
    
    CGRect rightSwitchFrame = CGRectMake(CGRectGetWidth(self.bounds) - 60, CGRectGetHeight(self.contentView.bounds) / 2 - 10, 20, 20);
    self.rightSwitch = [[UISwitch alloc] initWithFrame:rightSwitchFrame];
    [self.rightSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:self.rightSwitch];
}

- (void)switchValueChanged:(UISwitch *)sender {
    [self.delegate switchValueChanged:sender fromCell:self];
}

+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

+ (CGFloat)cellDefaultHeight {
    return 100.f;
}

@end
