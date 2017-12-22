//
//  Header.h
//  TestingCoreAnimation
//
//  Created by Admin on 09.12.17.
//  Copyright © 2017 crest. All rights reserved.
//

@class UISwitch;
@class MySwitchTableViewCell;

@protocol MySwitchCellDelegate <NSObject>

- (void)switchValueChanged:(UISwitch *)sender fromCell:(MySwitchTableViewCell *)cell;

@end
