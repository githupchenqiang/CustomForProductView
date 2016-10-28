//
//  ModelStatus.m
//  PersonDreaw
//
//  Created by QAING CHEN on 16/10/17.
//  Copyright © 2016年 QAING CHEN. All rights reserved.
//

#import "ModelStatus.h"

@implementation ModelStatus
+ (NSDictionary *)objectClassInArray
{
    return @{@"spus":@"FoodModel"};
}
@end

@implementation FoodModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"foodId":@"id"};
}

@end
