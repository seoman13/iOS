//
//  ContacsTableViewCell.m
//  ContactsBook
//
//  Created by iOS-School-1 on 02.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "ContacsTableViewCell.h"
#import "Avatar.h"

NSString *const ContactsTableViewCellIdentifier = @"ContactsTableViewCellIdentifier";

@interface ContacsTableViewCell ()
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *surname;
@property(nonatomic, strong) Avatar *avatar;

@end

@implementation ContacsTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:]];
    if(self){
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)

@end
