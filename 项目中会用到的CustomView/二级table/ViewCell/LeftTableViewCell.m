//
//  LeftTableViewCell.m
//  PersonDreaw
//
//  Created by QAING CHEN on 16/10/17.
//  Copyright © 2016年 QAING CHEN. All rights reserved.
//

#import "LeftTableViewCell.h"

@implementation LeftTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"LeftTableViewCell" owner:self options:nil]firstObject];
        self.frame = frame;
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.contentView.backgroundColor = selected ? [UIColor whiteColor] :[UIColor colorWithWhite:0 alpha:0.1];
    self.highlighted = selected;
    self.nameLabel.highlighted = selected;
   
    
}



@end
