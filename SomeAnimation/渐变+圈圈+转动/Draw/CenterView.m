//
//  CenterView.m
//  JinHaiMa
//
//  Created by xiuyu on 16/1/30.
//  Copyright © 2016年 xiuyu. All rights reserved.
//

#import "CenterView.h"

@implementation CenterView

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];

//    self.backgroundColor = [UIColor redColor];
    
//	self.centerThree = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//	[self addSubview:self.centerThree];
//
//	self.centerTwo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//	[self addSubview:self.centerTwo];
//
//	UIImageView *centerImgTwo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//	centerImgTwo.image = [UIImage imageNamed:@"bind2.png"];
//	[self.centerTwo addSubview:centerImgTwo];
//
//	self.centerOne = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//	[self addSubview:self.centerOne];
//
//	//    391 × 391   392/2=196
//	UIImageView *centerImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//	centerImg.image = [UIImage imageNamed:@"bind.png"];
//	[self.centerOne addSubview:centerImg];

    
    CGRect unitFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    
    
    self.centerOne = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bind"]];
    self.centerOne.frame = unitFrame;
    [self addSubview:self.centerOne];
    
    self.centerTwo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bind2"]];
    self.centerTwo.frame = unitFrame;
    
	return self;
}

- (void)startLeft
{
	[UIView transitionFromView:self.centerOne toView:self.centerTwo duration:3.0 options:UIViewAnimationOptionTransitionFlipFromLeft + UIViewAnimationOptionCurveEaseInOut completion:^(BOOL finished) {}];
}

/*
 *  // Only override drawRect: if you perform custom drawing.
 *  // An empty implementation adversely affects performance during animation.
 *  - (void)drawRect:(CGRect)rect {
 *   // Drawing code
 *  }
 */

@end
