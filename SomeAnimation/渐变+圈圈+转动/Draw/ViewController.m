//
//  ViewController.m
//  Draw
//
//  Created by 莫锹文 on 16/1/28.
//  Copyright © 2016年 莫锹文. All rights reserved.
//

#import "ViewController.h"
#import "MyView.h"
#import "Draw-Swift.h"
#import "CenterView.h"
#import "MyRadianView.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet CCMRadarView *test;
@property (nonatomic, strong) MyView *my;
@property (nonatomic, strong) CenterView *v2;
@property (nonatomic, strong) MyRadianView *myRadian;
@end

@implementation ViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

//    CCMRadarView *r;
    
    self.view.backgroundColor = [UIColor redColor];
//
//	MyView *v = [[MyView alloc] initWithFrame:CGRectMake(0, 0, 300,300)];
//    v.center = self.view.center;
//	[self.view addSubview:v];
//    
//    self.my = v;
//    
//    CenterView *v2 =[[CenterView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
//    v2.center = self.view.center;
//    [self.view addSubview:v2];
//    self.v2 = v2;
    
    self.myRadian=[[MyRadianView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    self.myRadian.center=self.view.center;
    [self.view addSubview:self.myRadian];
    
    
   
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
//	[self.test startAnimation];
    
//    [self.my start];
//    [self.v2 startLeft];
     [self.myRadian start];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
