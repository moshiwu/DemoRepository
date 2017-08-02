//
//  BodyMoveView.m
//  Draw
//
//  Created by 莫锹文 on 16/3/10.
//  Copyright © 2016年 莫锹文. All rights reserved.
//

#import "BodyMoveView.h"

@interface BodyMoveView ()

@property (nonatomic, strong) NSMutableArray *arrayBodyHeight;
@property (nonatomic, strong) NSMutableArray *arrayBodyDuration;

@property (nonatomic, assign) NSInteger sectionCount;

@end

@implementation BodyMoveView


- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];

	if (self)
	{
		self.sectionCount = 20;
	}
	return self;
}

- (void)draw
{

	CAShapeLayer *sublayer = [[CAShapeLayer alloc] init];

	CGFloat width = self.frame.size.width;
	CGFloat height = self.frame.size.height;

	sublayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);

	CGFloat startX = 0;
	CGFloat startY = height / 2;

	NSMutableArray *array = [NSMutableArray array];

	for (int i = 0; i < self.sectionCount; i++)
	{
		[array addObject:@0];
	}

	while (self.moveCount > 0) {
		int index = arc4random() % (self.sectionCount - 2) + 1;

		if (array[index] != nil && ![array[index] isEqual:@1])
		{
			array[index] = @1;
			self.moveCount--;
		}
	}

	CGFloat sectionWidth = 1.0 * width / self.sectionCount;

	UIBezierPath *bezier = [[UIBezierPath alloc] init];

	[bezier moveToPoint:CGPointMake(0, startY)];
	bezier.usesEvenOddFillRule = YES;

	for (int i = 0; i < self.sectionCount; i++)
	{
		NSNumber *num = array[i];

		if ([num isEqual:@0])
		{
			[bezier addLineToPoint:CGPointMake(startX + sectionWidth * (i + 1), startY)];
		}
		else
		{
			if (i > 0 && ![array[i - 1] isEqual:@1])
			{
				[bezier addLineToPoint:CGPointMake(startX + bezier.currentPoint.x, startY - 80)];
			}

			[bezier addLineToPoint:CGPointMake(startX + sectionWidth * (i + 1), startY - 80)];

			if (i + 1 < self.sectionCount && ![array[i + 1] isEqual:@1])
			{
				[bezier addLineToPoint:CGPointMake(startX + sectionWidth * (i + 1), startY)];
			}
		}
	}

	sublayer.path = bezier.CGPath;
	sublayer.lineWidth = 4;
	sublayer.lineJoin = kCALineJoinRound;
	sublayer.fillColor = [UIColor clearColor].CGColor;
	sublayer.strokeColor = [UIColor yellowColor].CGColor;

	[self.layer addSublayer:sublayer];
}

@end
