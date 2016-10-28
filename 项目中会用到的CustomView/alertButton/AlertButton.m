//
//  AlertButton.m
//  PersonDreaw
//
//  Created by QAING CHEN on 16/10/14.
//  Copyright © 2016年 QAING CHEN. All rights reserved.
//

#import "AlertButton.h"
#define Kwidth self.frame.size.width
@implementation AlertButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
        [self setbuttonaction];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapEvent)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)tapEvent
{
    if (_Block) {
        _Block();
    };
}

- (void)setbuttonaction
{
    CGFloat butttonWidth = 40;
    NSInteger count = 0;
    CGFloat top = 10;
    CGFloat left = 20;
    for (int i = 0; i < 12; i++) {
        CGFloat Viewleft = left + (Kwidth - (butttonWidth * 4 + left * 2)) / 3 * i + i * butttonWidth;
        if (Viewleft > Kwidth) {
            Viewleft = left;
            i = 0;
            top = top + butttonWidth + 20;
        }
        [self buttonframe:CGRectMake(Viewleft, top ,butttonWidth , butttonWidth) coner:butttonWidth/2 action:@selector(buttonaction:) buttonTag:count normalImage:_ButtonImageArray[i] selectImage:@"" backColor:[UIColor cyanColor]];
        [self labeframe:CGRectMake(Viewleft - left, (top - 10) + butttonWidth + 10,butttonWidth + left * 2,20) corner:0 text:_LabelTextArray[count] backColor:[UIColor cyanColor]];
        count++;
        NSLog(@"%@",_ButtonImageArray[i]);
        if (count  == 12) {
            count = 12
            ;
            break;
            
        }
      
    }
}

- (UIButton *)buttonframe:(CGRect)frame coner:(CGFloat)corner action:(SEL)targetAction buttonTag:(NSInteger)tag normalImage:(NSString *)normal selectImage:(NSString *)selectImage backColor:(UIColor *)color
{
    
    _button = [UIButton buttonWithType:UIButtonTypeSystem];
    _button.frame = frame;
    _button.tag = tag;
    [_button addTarget:self action:targetAction forControlEvents:UIControlEventTouchDown];
    [_button setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [_button setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
    _button.layer.cornerRadius = corner;
    _button.layer.masksToBounds =  YES;
    _button.backgroundColor = color;
    [self addSubview:_button];
    return _button;
}

- (UILabel *)labeframe:(CGRect)frame corner:(CGFloat)corner text:(NSString *)text backColor:(UIColor *)color
{
    UILabel *label = [[UILabel alloc]init];
    label.frame = frame;
    label.text = @"爆发开发开放办";
    label.font = [UIFont systemFontOfSize:10];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = corner;
    label.layer.masksToBounds = YES;
    label.backgroundColor = color;
    [self addSubview:label];
    return label;
}

- (void)setbackColor:(UIColor *)color
{
    self.backgroundColor = color;
}

- (void)setCorner:(CGFloat)corner
{
    self.layer.cornerRadius = corner;
    self.layer.masksToBounds = YES;
}


- (void)buttonaction:(UIButton *)button
{
    NSNumber *number = [NSNumber numberWithInteger:button.tag];
    if ([_delegate respondsToSelector:@selector(ClickButtonWithIndex:)]) {
        [_delegate performSelector:@selector(ClickButtonWithIndex:) withObject:number];
    }
}

+ (instancetype)CustombuttonViewWithFrame:(CGRect)frame delegate:(id<alertButtonDelegate>)delegate
{   AlertButton *alert = [[AlertButton alloc]initWithFrame:frame];
    alert.delegate = delegate;
    return alert;
}

- (NSMutableArray *)ButtonImageArray
{
    if (_ButtonImageArray == nil) {
        _ButtonImageArray = [NSMutableArray array];
    }
    return _ButtonImageArray;
}

@end
