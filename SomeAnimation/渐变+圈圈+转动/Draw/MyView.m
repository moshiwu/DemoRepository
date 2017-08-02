//
//  MyView.m
//  Draw
//
//  Created by 莫锹文 on 16/1/28.
//  Copyright © 2016年 莫锹文. All rights reserved.
//

#import "MyView.h"

@interface MyView ()

@property (nonatomic, strong) CAShapeLayer *sublayer;

@end

@implementation MyView

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];

	if (self)
	{
//		CAShapeLayer *sublayer = [[CAShapeLayer alloc] init];
//		sublayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
//
////		UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//        UIBezierPath *circle = [UIBezierPath bezierPathWithArcCenter:self.center radius:50 startAngle:0 endAngle:90 clockwise:YES];
//		sublayer.path = circle.CGPath;
//		sublayer.strokeColor = [UIColor blueColor].CGColor;
//		sublayer.lineWidth = 1;
////		sublayer.fillColor = [UIColor clearColor].CGColor;
//		sublayer.opacity = 1;
//		[self.layer addSublayer:sublayer];
//
//		self.sublayer = sublayer;
	}
	return self;
}

- (void)start
{
	self.alpha = 1;

//	self.transform = CGAffineTransformScale(self.transform, 0.5, 0.5);
//	[UIView animateWithDuration:1 delay:0.1f options:UIViewAnimationOptionCurveEaseOut animations:^{
//		self.alpha = 0;
//
//		self.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
//	} completion:^(BOOL finished) {
//
//			[self start];
//
//	}];

}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
	NSLog(@"123");
}

//- (void)drawRect:(CGRect)rect
//{
//	self.backgroundColor = [UIColor greenColor];
//
//	CGContextRef context = UIGraphicsGetCurrentContext();
//
//	CGContextSetRGBFillColor(context, 1, 0, 0, 0.5); //设置填充颜色
//
//	CGContextFillRect(context, self.frame);
//    CGContextDrawPath(context, kCGPathFillStroke);
////    CGContextClearRect(context, self.frame);
//
//	CGContextSetRGBStrokeColor(context, 1, 1, 1, 0); //画笔线的颜色
//	CGContextSetRGBFillColor(context, 1, 0, 0, 1.0); //设置填充颜色
//
//	CGContextMoveToPoint(context, 50, 300);                    //设置Path的起点
//	CGContextAddQuadCurveToPoint(context, 200, 200, 350, 250); //设置贝塞尔曲线的控制点坐标和终点坐标
//
//	CGContextAddLineToPoint(context, 350, 150);
//
//	CGContextAddQuadCurveToPoint(context, 200, 200, 50, 100); //设置贝塞尔曲线的控制点坐标和终点坐标
//
//	CGContextAddLineToPoint(context, 50, 300);
//
//	CGContextClosePath(context);                     //封起来
//	CGContextDrawPath(context, kCGPathEOFillStroke); //根据坐标绘制路径
//
//	CGContextMoveToPoint(context, 50, 200);
//	CGContextAddArc(context, 50, 200, 100, 180 * M_PI / 180, -180 * M_PI / 180, 1);
//	CGContextDrawPath(context, kCGPathEOFillStroke); //根据坐标绘制路径
//
//	CGContextMoveToPoint(context, 350, 200);
//	CGContextAddArc(context, 350, 200, 80, 180 * M_PI / 180, -180 * M_PI / 180, 1);
//	CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
//
//
////    CGContextClearRect(context, self.frame);
//
//}

@end
//