//
//  RightTableViewCell.h
//  PersonDreaw
//
//  Created by QAING CHEN on 16/10/17.
//  Copyright © 2016年 QAING CHEN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelStatus.h"
@class FoodModel;
#define kCellIdentifier_Right @"RightTableViewCell"
@interface RightTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *MainImage;
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *PriceLabel;

@property (nonatomic, strong) FoodModel *model;

@end
