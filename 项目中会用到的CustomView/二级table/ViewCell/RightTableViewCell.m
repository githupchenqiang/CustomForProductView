//
//  RightTableViewCell.m
//  PersonDreaw
//
//  Created by QAING CHEN on 16/10/17.
//  Copyright © 2016年 QAING CHEN. All rights reserved.
//

#import "RightTableViewCell.h"
#import "Header.h"
@implementation RightTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"RightTableViewCell" owner:self options:nil]firstObject];
        self.frame = frame;
    }
    return self;    
}


- (void)setModel:(FoodModel *)model
{
    [self.MainImage sd_setImageWithURL:[NSURL URLWithString:model.picture]];
    self.NameLabel.text = model.name;
    self.PriceLabel.text = [NSString stringWithFormat:@"¥%@",@(model.min_price)];
}

@end
