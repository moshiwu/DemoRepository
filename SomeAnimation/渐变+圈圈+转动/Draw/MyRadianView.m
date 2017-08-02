//
//  MyRadianView.m
//  Draw
//
//  Created by xiuyu on 16/1/30.
//  Copyright © 2016年 莫锹文. All rights reserved.
//

#import "MyRadianView.h"

@interface MyRadianView ()

@property (nonatomic, strong) CAShapeLayer *sb;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@end

@implementation MyRadianView

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];

	if (self)
	{
		_stop = NO;

		self.backgroundColor = [UIColor greenColor];
		CAShapeLayer *sublayer = [[CAShapeLayer alloc] init];
		sublayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);

		UIBezierPath *circle = [[UIBezierPath alloc] init];
		[circle addArcWithCenter:self.center radius:80 startAngle:M_PI * 1.7 endAngle:M_PI * 2.0 clockwise:YES];

		sublayer.path = circle.CGPath;
		sublayer.strokeColor = [UIColor blueColor].CGColor;
		sublayer.lineWidth = 1.5;
		sublayer.fillColor = [UIColor clearColor].CGColor;

		[self.layer addSublayer:sublayer];
		self.sublayer = sublayer;

		self.layer.anchorPoint = CGPointMake(0.5, 0.5);

        //渐变图层
		CAGradientLayer *gradientLayer = [CAGradientLayer layer];
		gradientLayer.frame = self.frame;
		gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:0.125 green:0.611 blue:1.000 alpha:1.000].CGColor, (__bridge id)[UIColor colorWithRed:0.802 green:0.998 blue:1.000 alpha:1.000].CGColor];
		gradientLayer.startPoint = CGPointMake(0, 0.5);
		gradientLayer.endPoint = CGPointMake(1, 0.5);

		[self.layer addSublayer:gradientLayer];

		gradientLayer.mask = sublayer;

		self.sb = sublayer;
		self.gradientLayer = gradientLayer;
	}
	return self;
}

- (void)start
{
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];

	// 设定动画选项
	animation.duration = 2.5;     // 持续时间
	animation.repeatCount = INTMAX_MAX; // 重复次数

	// 设定选装角度
	animation.fromValue = [NSNumber numberWithFloat:0.0];    // 起始角度
	animation.toValue = [NSNumber numberWithFloat:2 * M_PI]; // 终止角度

	// 添加动画
	[self.sb addAnimation:animation forKey:@"rotate-layer"];

}

- (void)stop
{
//	_stop = YES;
	[self.sb removeAllAnimations];
}

@end
