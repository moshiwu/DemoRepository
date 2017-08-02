//
//  HeartRateView.m
//  Draw
//
//  Created by 莫锹文 on 16/3/10.
//  Copyright © 2016年 莫锹文. All rights reserved.
//

#import "HeartRateView.h"

@implementation HeartRateView

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];

	if (self)
	{
		self.active = NO;
	}
	return self;
}

- (void)draw
{
	CAShapeLayer *sublayer = [[CAShapeLayer alloc] init];

	sublayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);

	CGFloat startX = 0;
	CGFloat startY = self.center.y;

	UIBezierPath *bezier = [[UIBezierPath alloc] init];

	[bezier moveToPoint:CGPointMake(0, startY)];

	if (self.active)
	{
		for (int i = 0; i < 4; i++)
		{
			[bezier addLineToPoint:CGPointMake(startX + 10, startY)];
			[bezier addLineToPoint:CGPointMake(startX + 12, startY)];
			[bezier addLineToPoint:CGPointMake(startX + 17, startY - 4)];
			[bezier addLineToPoint:CGPointMake(startX + 20, startY)];
			[bezier addLineToPoint:CGPointMake(startX + 27, startY)];
			[bezier addLineToPoint:CGPointMake(startX + 30, startY + 7)];
			[bezier addLineToPoint:CGPointMake(startX + 36, startY - 30)];
			[bezier addLineToPoint:CGPointMake(startX + 40, startY + 30)];
			[bezier addLineToPoint:CGPointMake(startX + 45, startY)];
			[bezier addLineToPoint:CGPointMake(startX + 50, startY)];
			[bezier addLineToPoint:CGPointMake(startX + 55, startY - 5)];
			[bezier addLineToPoint:CGPointMake(startX + 60, startY)];

			startX = bezier.currentPoint.x;
		}
	}
	else
	{
		[bezier addLineToPoint: CGPointMake(240, startY)];
	}

	sublayer.path = bezier.CGPath;
	sublayer.lineWidth = 4;
	sublayer.lineJoin = kCALineJoinRound;
	sublayer.fillColor = [UIColor clearColor].CGColor;
	sublayer.strokeColor = [UIColor redColor].CGColor;

	[self.layer addSublayer:sublayer];
}

@end
