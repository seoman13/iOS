//
//  CustomTableViewCell.m
//  ContactsBook
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "CustomTableViewCell.h"

@interface CustomTableViewCell ()

@property(nonatomic, strong) UILabel *firstName;
@property(nonatomic, strong) UILabel *lastName;
@end

@implementation CustomTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.picLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 15, 15)];
        self.picLabel.backgroundColor = [UIColor redColor];
        //self.picLabel.
   
        [self.contentView addSubview:self.picLabel];
        self.picLabel.layer.cornerRadius = 5;
        self.picLabel.clipsToBounds = YES;
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

@end
