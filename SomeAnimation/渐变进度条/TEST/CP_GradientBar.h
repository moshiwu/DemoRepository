//
//  CP_GradientBar.h
//
//  Created by 莫锹文 on 16/4/13.
//  Copyright © 2016年 GOUYU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CP_GradientBar : UIView

/**
 *  进度，范围(0,1)
 */
@property (nonatomic, assign) CGFloat progress;

/**
 *  渐变颜色，只有等分，需要做成不等分的话传入多个UIColor
 */
@property (nonatomic, strong) NSArray *colors;

/**
 *  背景颜色
 */
@property (nonatomic, strong) UIColor *backgroundLayerColor;


- (instancetype)initWithFrame:(CGRect)frame colors:(NSArray *)colors progress:(CGFloat)progress;

@end
