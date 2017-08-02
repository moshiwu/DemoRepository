//
//  MyRadianView.h
//  Draw
//
//  Created by xiuyu on 16/1/30.
//  Copyright © 2016年 莫锹文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyRadianView : UIView{

    BOOL _stop;

}


@property (nonatomic, strong) CAShapeLayer *sublayer;

- (void)start;

- (void)stop;

@end
