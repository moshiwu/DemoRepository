//
//  BreathView.m
//  Draw
//
//  Created by 莫锹文 on 16/3/10.
//  Copyright © 2016年 莫锹文. All rights reserved.
//

#import "BreathView.h"

@interface BreathView ()

@property (nonatomic, strong) CALayer *maskContainer;
@property (nonatomic, strong) UIView *maskContainerView;

@end

@implementation BreathView

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];

	if (self)
	{
		self.active = NO;

		self.clipsToBounds = YES;
	}
	return self;
}

- (void)draw
{
	CGFloat width = self.frame.size.width;
	CGFloat height = self.frame.size.height;

	CAShapeLayer *sublayer = [[CAShapeLayer alloc] init];

	CGFloat startX = 0;
	CGFloat startY = self.center.y;

	UIBezierPath *bezier = [[UIBezierPath alloc] init];

	[bezier moveToPoint:CGPointMake(0, startY)];

	if (self.active)
	{
		for (int i = 0; i < 3; i++)
		{
			[bezier addQuadCurveToPoint:CGPointMake(startX + 40, startY) controlPoint:CGPointMake(startX + 20, startY - 90)];
			[bezier addQuadCurveToPoint:CGPointMake(startX + 80, startY) controlPoint:CGPointMake(startX + 60, startY + 90)];
			startX = bezier.currentPoint.x;
		}
	}
	else
	{
		[bezier addLineToPoint:CGPointMake(240, startY)];
	}

	sublayer.path = bezier.CGPath;
	sublayer.lineWidth = 4;
	sublayer.lineJoin = kCALineJoinRound;
	sublayer.fillColor = [UIColor clearColor].CGColor;
	sublayer.strokeColor = [UIColor blueColor].CGColor;

	[self.layer addSublayer:sublayer];

//	CALayer *container = [[CALayer alloc] init];
//
//	self.maskContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
//	self.maskView = self.maskContainerView;
//	[self.maskContainerView.layer addSublayer:container];
//
//	CAShapeLayer *sublayer2 = [[CAShapeLayer alloc] init];
//	UIBezierPath *besize2 = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//	sublayer2.path = besize2.CGPath;
//	sublayer2.position = CGPointMake(0, 0);
//	[container addSublayer:sublayer2];
//
//	CAShapeLayer *sublayer3 = [[CAShapeLayer alloc] init];
//	UIBezierPath *besize3 = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//	sublayer3.path = besize3.CGPath;
//	sublayer3.fillColor = [UIColor greenColor].CGColor;
//	sublayer3.position = CGPointMake(-250, 0);
//	[container addSublayer:sublayer3];

//	self.maskContainer = container;
}

@end
