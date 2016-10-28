//
//  AlertButton.h
//  PersonDreaw
//
//  Created by QAING CHEN on 16/10/14.
//  Copyright © 2016年 QAING CHEN. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^bacBlock)(void);

@protocol alertButtonDelegate <NSObject>

- (void)ClickButtonWithIndex:(NSNumber *)number;

@end

@interface AlertButton : UIView
@property (nonatomic ,assign)id<alertButtonDelegate> delegate;
@property (nonatomic ,assign)bacBlock Block;
@property (nonatomic ,strong)NSMutableArray *ButtonImageArray;
@property (nonatomic ,strong)NSMutableArray *LabelTextArray;
@property (nonatomic ,strong)UIButton *button;

/**
 view初始化方法
 @param frame    frame
 @param delegate self
 @return view
 */
+ (instancetype)CustombuttonViewWithFrame:(CGRect)frame delegate:(id<alertButtonDelegate>)delegate;

/**
 设置背景色

 @param color color
 */
- (void)setbackColor:(UIColor *)color;


/**
 设置圆角

 @param corner cgfloat
 */
- (void)setCorner:(CGFloat)corner;

@end
