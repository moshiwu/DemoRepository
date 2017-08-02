//
//  CP_GradientBar.m
//
//  Created by 莫锹文 on 16/4/13.
//  Copyright © 2016年 GOUYU. All rights reserved.
//

#import "CP_GradientBar.h"

@interface CP_GradientBar ()

@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@property (nonatomic, strong) CAShapeLayer *maskLayer;

@property (nonatomic, strong) CAShapeLayer *backLayer;

@end

@implementation CP_GradientBar

- (instancetype)initWithFrame:(CGRect)frame colors:(NSArray *)colors progress:(CGFloat)progress
{
	self = [super initWithFrame:frame];

	if (self)
	{
		UIBezierPath *path;

		//背景图层
		path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:frame.size.height / 2];
		CAShapeLayer *backLayer = [CAShapeLayer layer];
		backLayer.path = path.CGPath;
		backLayer.fillColor = [UIColor colorWithWhite:0.878 alpha:1.000].CGColor;
		[self.layer addSublayer:backLayer];
		self.backLayer = backLayer;

		//渐变图层
		CAGradientLayer *gradientLayer = [CAGradientLayer layer];
		gradientLayer.frame = self.bounds;
		gradientLayer.colors = [self transformUIColorToCGColor:colors];
		gradientLayer.startPoint = CGPointMake(0, 0.5);
		gradientLayer.endPoint = CGPointMake(1, 0.5);
		[self.layer addSublayer:gradientLayer];
		self.gradientLayer = gradientLayer;

		//蒙版图层
		path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:frame.size.height / 2];
		CAShapeLayer *maskLayer = [CAShapeLayer layer];
		maskLayer.path = path.CGPath;
		maskLayer.fillColor = [UIColor blueColor].CGColor;
		[self.layer addSublayer:maskLayer];
		self.maskLayer = maskLayer;

		gradientLayer.mask = maskLayer;

		self.progress = progress;
	}
	return self;
}

- (NSArray *)transformUIColorToCGColor:(NSArray <UIColor *> *)array
{
	NSMutableArray *newArray = [NSMutableArray array];

	for (UIColor *color in array)
	{
		[newArray addObject:(__bridge id)color.CGColor];
	}

	return newArray;
}

- (void)setProgress:(CGFloat)progress
{
	if (_progress != progress)
	{
		_progress = progress > 1 ? 1 : progress;

		CGRect rect = CGRectMake(0, 0, self.frame.size.width * _progress, self.frame.size.height);

		UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:self.frame.size.height / 2];

		self.maskLayer.path = path.CGPath;
	}
}

- (void)setColors:(NSArray *)colors
{
	if (_colors != colors)
	{
		_colors = colors;

		self.gradientLayer.colors = [self transformUIColorToCGColor:colors];
	}
}

- (void)setBackgroundLayerColor:(UIColor *)backgroundLayerColor
{
	if (_backgroundLayerColor != backgroundLayerColor)
	{
		_backgroundLayerColor = backgroundLayerColor;

		self.backLayer.fillColor = backgroundLayerColor.CGColor;
	}
}

@end
