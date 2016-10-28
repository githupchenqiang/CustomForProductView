//
//  TableHeaderView.m
//  PersonDreaw
//
//  Created by QAING CHEN on 16/10/17.
//  Copyright © 2016年 QAING CHEN. All rights reserved.
//

#import "TableHeaderView.h"
#import "Header.h"

@implementation TableHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = rgba(240, 240, 240, 0.8);
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 20)];
        self.label.font = [UIFont systemFontOfSize:13];
        [self addSubview:self.label];
    }
    return self;
}
@end
