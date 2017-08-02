//
//  CenterView.h
//  JinHaiMa
//
//  Created by xiuyu on 16/1/30.
//  Copyright © 2016年 xiuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CenterView : UIView


@property (strong, nonatomic) UIImageView *centerOne;
@property (strong, nonatomic) UIImageView *centerTwo;
@property (strong, nonatomic) UIImageView *centerThree;


-(void)startLeft;


-(void)startRight;

@end
