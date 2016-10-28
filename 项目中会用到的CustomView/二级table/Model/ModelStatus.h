//
//  ModelStatus.h
//  PersonDreaw
//
//  Created by QAING CHEN on 16/10/17.
//  Copyright © 2016年 QAING CHEN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelStatus : NSObject
@property (nonatomic ,copy)NSString *name;
@property (nonatomic ,copy)NSString *icon;
@property (nonatomic ,strong)NSArray *spus;
@end

@interface FoodModel : NSObject;
@property (nonatomic ,copy)NSString *name;
@property (nonatomic ,copy)NSString *foodId;
@property (nonatomic ,copy)NSString *picture;
@property (nonatomic ,assign)NSInteger praise_content;
@property (nonatomic ,assign)NSInteger month_saled;
@property (nonatomic ,assign)float min_price;
@end
