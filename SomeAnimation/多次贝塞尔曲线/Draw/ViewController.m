//
//  ViewController.m
//  Draw
//
//  Created by 莫锹文 on 16/1/28.
//  Copyright © 2016年 莫锹文. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

	[self drawLine];
}

- (void)drawLine
{
	//view是曲线的背景view
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 300, 300)];

	view.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:view];

	//第一、UIBezierPath绘制线段
	UIBezierPath *path = [UIBezierPath bezierPath];

	//四个点
	CGPoint point = CGPointMake(10, 10);
	CGPoint point1 = CGPointMake(200, 100);
	CGPoint point2 = CGPointMake(240, 200);
	CGPoint point3 = CGPointMake(290, 200);

	[path moveToPoint:point];

	NSArray *arr = [NSArray arrayWithObjects:[NSValue valueWithCGPoint:point], [NSValue valueWithCGPoint:point1], [NSValue valueWithCGPoint:point2], [NSValue valueWithCGPoint:point3], nil];
	NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, arr.count)];
	//第二、就是这句话绘制
	[arr enumerateObjectsAtIndexes:set options:0 usingBlock:^(NSValue *pointValue, NSUInteger idx, BOOL *stop) {
		CGPoint point = [pointValue CGPointValue];
		[path addLineToPoint:point];

	    //（一）rect折线画法
		CGRect rect;
		rect.origin.x = point.x - 1.5;
		rect.origin.y = point.y - 1.5;
		rect.size.width = 4;
		rect.size.height = 4;

	    //（二）rect射线画法
//		CGRect rect = CGRectMake(10, 10, 1, 1);

		UIBezierPath *arc = [UIBezierPath bezierPathWithOvalInRect:rect];
		[path appendPath:arc];
	}];
	//第三、UIBezierPath和CAShapeLayer关联
	CAShapeLayer *lineLayer = [CAShapeLayer layer];
	lineLayer.frame = CGRectMake(0, 150, 320, 400);
	lineLayer.fillColor = [UIColor redColor].CGColor;
	lineLayer.path = path.CGPath;
	lineLayer.strokeColor = [UIColor redColor].CGColor;
	[view.layer addSublayer:lineLayer];

	//以下代码为附加的
	//（一）像一个幕布一样拉开，显得有动画
	UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 320, 400)];
	view1.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:view1];

	[UIView animateWithDuration:5 animations:^{
		view1.frame = CGRectMake(320, 100, 320, 400);
	}];
}

@end
