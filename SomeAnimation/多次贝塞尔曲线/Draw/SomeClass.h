//
//  SomeClass.h
//  Draw
//
//  Created by 莫锹文 on 16/3/24.
//  Copyright © 2016年 莫锹文. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SomeDelegate <NSObject>

@end

@interface SomeClass : NSObject

@property (nonatomic, weak) id <SomeDelegate> delegate;

@end
