//
//  ViewController.m
//  Draw
//
//  Created by 莫锹文 on 16/1/28.
//  Copyright © 2016年 莫锹文. All rights reserved.
//

#import "ViewController.h"

#import "HeartRateView.h"
#import "BreathView.h"
#import "IncisionAnimate.h"
#import "BodyMoveView.h"
#import "NSDate+Utilities.h"

@interface ViewController ()
@property (nonatomic, strong) IncisionAnimate *test;

@property (nonatomic, strong) BodyMoveView *currentBodyMoveView;
@property (nonatomic, strong) BodyMoveView *nextBodyMoveView;
//
@property (nonatomic, strong) HeartRateView *currentHeartRateView;
@property (nonatomic, strong) HeartRateView *nextHeartRateView;

@property (nonatomic, strong) BreathView *currentBreathView;
@property (nonatomic, strong) BreathView *nextBreathView;

@end

@implementation ViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

	NSDate *date = [NSDate dateWithTimeIntervalSince1970:1464550250];
	NSString *str = [date stringWithFormat:@"YYYY/HH/mm"];
	NSLog(@"%@", str);

	return;

	[self switchToNextView:0];
	[self switchToNextHeartRateView:NO];
	[self switchToNextBreathView:NO];
}

- (void)switchToNextView:(NSInteger)nextCount
{
	NSLog(@"switchToNextView %ld", nextCount);

	if (self.currentBodyMoveView != nil)
	{
		[self.currentBodyMoveView removeFromSuperview];
		self.currentBodyMoveView = self.nextBodyMoveView;
		self.nextBodyMoveView = nil;
	}

	if (self.currentBodyMoveView == nil)
	{
		//创建当前view
		BodyMoveView *currentView = [[BodyMoveView alloc] initWithFrame:CGRectMake(0, 0, 240, 300)];
		currentView.moveCount = 0;
		[currentView draw];
		[self.view addSubview:currentView];
		currentView.center = CGPointMake(self.view.center.x, self.view.center.y + 180);

		self.currentBodyMoveView = currentView;
	}

	//给当前view加动画
	IncisionAnimate *anima1 = [[IncisionAnimate alloc] initWithBaseview:self.currentBodyMoveView space:10];
	anima1.repeat = YES;
	anima1.duration = 2;
	anima1.enableLeft = NO;
	[anima1 startWithComplete:^{
	    //下一个循环
		NSInteger nextNextCount = arc4random() % 10;
		[self switchToNextView:nextNextCount];
	}];

	if (self.nextBodyMoveView == nil)
	{
		//创建下一个view
		BodyMoveView *nextView = [[BodyMoveView alloc] initWithFrame:CGRectMake(0, 0, 240, 300)];
		nextView.moveCount = nextCount;
		[nextView draw];
		[self.view addSubview:nextView];
		nextView.center = CGPointMake(self.view.center.x, self.view.center.y + 180);

		//给下一个view加动画
		IncisionAnimate *anima2 = [[IncisionAnimate alloc] initWithBaseview:nextView space:10];
		anima2.duration = 2;
		anima2.enableRight = NO;
		[anima2 start];

		self.nextBodyMoveView = nextView;
	}
}

- (void)switchToNextHeartRateView:(BOOL)active
{
	NSLog(@"switchToNextHeartRateView %d", active);

	if (self.currentHeartRateView != nil)
	{
		[self.currentHeartRateView removeFromSuperview];
		self.currentHeartRateView = self.nextHeartRateView;
		self.nextHeartRateView = nil;
	}

	if (self.currentHeartRateView == nil)
	{
		//创建当前view
		HeartRateView *currentView = [[HeartRateView alloc] initWithFrame:CGRectMake(0, 0, 240, 300)];
		[currentView draw];
		[self.view addSubview:currentView];
		currentView.center = CGPointMake(self.view.center.x, self.view.center.y);

		self.currentHeartRateView = currentView;
	}

	//给当前view加动画
	IncisionAnimate *anima1 = [[IncisionAnimate alloc] initWithBaseview:self.currentHeartRateView space:10];
	anima1.repeat = YES;
	anima1.duration = 2;
	anima1.enableLeft = NO;
	[anima1 startWithComplete:^{
	    //下一个循环
		NSInteger nextNextCount = arc4random() % 10;

		BOOL nextActive = nextNextCount > 4 ? YES : NO;
		[self switchToNextHeartRateView:nextActive];
	}];

	if (self.nextHeartRateView == nil)
	{
		//创建下一个view
		HeartRateView *nextView = [[HeartRateView alloc] initWithFrame:CGRectMake(0, 0, 240, 300)];
		nextView.active = active;
		[nextView draw];
		[self.view addSubview:nextView];
		nextView.center = CGPointMake(self.view.center.x, self.view.center.y);

		//给下一个view加动画
		IncisionAnimate *anima2 = [[IncisionAnimate alloc] initWithBaseview:nextView space:10];
		anima2.duration = 2;
		anima2.enableRight = NO;
		[anima2 start];

		self.nextHeartRateView = nextView;
	}
}

- (void)switchToNextBreathView:(BOOL)active
{
	NSLog(@"switchToNextBreathView %d", active);

	if (self.currentBreathView != nil)
	{
		[self.currentBreathView removeFromSuperview];
		self.currentBreathView = self.nextBreathView;
		self.nextBreathView = nil;
	}

	if (self.currentBreathView == nil)
	{
		//创建当前view
		BreathView *currentView = [[BreathView alloc] initWithFrame:CGRectMake(0, 0, 240, 300)];
		[currentView draw];
		[self.view addSubview:currentView];
		currentView.center = CGPointMake(self.view.center.x, self.view.center.y - 150);

		self.currentBreathView = currentView;
	}

	//给当前view加动画
	IncisionAnimate *anima1 = [[IncisionAnimate alloc] initWithBaseview:self.currentBreathView space:10];
	anima1.repeat = YES;
	anima1.duration = 2;
	anima1.enableLeft = NO;
	[anima1 startWithComplete:^{
	    //下一个循环
		NSInteger nextNextCount = arc4random() % 10;

		BOOL nextActive = nextNextCount > 4 ? YES : NO;
		[self switchToNextBreathView:nextActive];
	}];

	if (self.nextBreathView == nil)
	{
		//创建下一个view
		BreathView *nextView = [[BreathView alloc] initWithFrame:CGRectMake(0, 0, 240, 300)];
		nextView.active = active;
		[nextView draw];
		[self.view addSubview:nextView];
		nextView.center = CGPointMake(self.view.center.x, self.view.center.y - 150);

		//给下一个view加动画
		IncisionAnimate *anima2 = [[IncisionAnimate alloc] initWithBaseview:nextView space:10];
		anima2.duration = 2;
		anima2.enableRight = NO;
		[anima2 start];

		self.nextBreathView = nextView;
	}
}

- (void)touchesBegan:(NSSet <UITouch *> *)touches withEvent:(UIEvent *)event
{
	NSLog(@"123");
}

@end
