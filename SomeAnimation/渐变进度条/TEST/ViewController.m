//
//  ViewController.m
//  TEST
//
//  Created by 莫锹文 on 16/2/19.
//  Copyright © 2016年 莫锹文. All rights reserved.
//

#import "ViewController.h"
#import "CP_GradientBar.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
	[super viewDidLoad];

    CP_GradientBar *bar = [[CP_GradientBar alloc] initWithFrame:CGRectMake(12, 50, 300, 6) colors:@[[UIColor colorWithRed:0.090 green:0.718 blue:0.894 alpha:1.000],[UIColor colorWithRed:0.051 green:0.451 blue:0.910 alpha:1.000]] progress:0.5];
    
    bar.progress = 0.6;
    bar.colors = @[[UIColor greenColor],[UIColor yellowColor],[UIColor redColor]];
    
    bar.backgroundLayerColor = [UIColor cyanColor];
    [self.view addSubview:bar];
    
////    NSString *str = @"{"dataTime" : "2016-04-12","startTime" : "2016-04-12 19:27:00","status" : 1},{"dataTime" : "2016-04-12","startTime" : "2016-04-12 19:42:00","status" : 2},{"dataTime" : "2016-04-12","startTime" : "2016-04-12 19:47:30","status" : 9},{"dataTime" : "2016-04-12","startTime" : "2016-04-12 23:21:00","status" : 8},{"dataTime" : "2016-04-12","startTime" : "2016-04-12 23:46:00","status" : 2},{"dataTime" : "2016-04-12","startTime" : "2016-04-12 23:51:00","status" : 3},{"dataTime" : "2016-04-12","startTime" : "2016-04-12 23:56:00","status" : 5},{"dataTime" : "2016-04-12","startTime" : "2016-04-13 00:21:00","status" : 3},{"dataTime" : "2016-04-12","startTime" : "2016-04-13 00:26:00","status" : 5}";
//
////        NSString *str = @"{"dataTime" : "2016-04-12","startTime" : "2016-04-12 19:27:00","status" : 1},{"dataTime" : "2016-04-12","startTime" : "2016-04-12 19:42:00","status" : 2},{"dataTime" : "2016-04-12","startTime" : "2016-04-12 19:47:30","status" : 9},{"dataTime" : "2016-04-12","startTime" : "2016-04-12 23:21:00","status" : 8},{"dataTime" : "2016-04-12","startTime" : "2016-04-12 23:46:00","status" : 2},{"dataTime" : "2016-04-12","startTime" : "2016-04-12 23:51:00","status" : 3},{"dataTime" : "2016-04-12","startTime" : "2016-04-12 23:56:00","status" : 5},{"dataTime" : "2016-04-12","startTime" : "2016-04-13 00:21:00","status" : 3},{"dataTime" : "2016-04-12","startTime" : "2016-04-13 00:26:00","status" : 5}";
//
////    NSData *data = [NSJSONSerialization dataWithJSONObject:str options:NSJSONWritingPrettyPrinted error:nil];
//
////    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
////    NSLog(@"%@",dict);
//
////    NSLog(@"%@",dataArr);
//
//	NSMutableArray *hourArr = [[NSMutableArray alloc] init];
//
//	NSMutableArray *statusArr = [[NSMutableArray alloc] init];
//
//	NSMutableArray *setYArr = [[NSMutableArray alloc] init];
//
//	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//
//	formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//
//	NSArray *dataArr = @[
//		@{@"startTime" : @"2016-04-12 19:27:00", @"status" : @1},
//		@{@"startTime" : @"2016-04-12 19:42:00", @"status" : @2},
//		@{@"startTime" : @"2016-04-12 19:47:30", @"status" : @9},
//		@{@"startTime" : @"2016-04-13 00:26:00", @"status" : @5}];
//
//	NSInteger minDay = 0;
//
//	//算最小“时”和最大“时”
//	for (int i = 0; i < dataArr.count; i++)
//	{
//		NSDictionary *dic = [dataArr objectAtIndex:i];
//
//		NSString *str = [dic objectForKey:@"startTime"];
//		NSArray *arr = [str componentsSeparatedByString:@" "];
//
//		NSString *dayString = arr[0];
//
//        //获得数据里面最小的“天数”
//		if (i == 0)
//		{
//			minDay = [[[dayString componentsSeparatedByString:@"-"] lastObject] integerValue];
//		}
//
//		NSString *timeString = arr[1];
//
//        //当前的小时
//		NSInteger hour = [[[timeString componentsSeparatedByString:@":"] firstObject] integerValue];
//
//        //当前的天数
//		NSInteger currentDay = [[[dayString componentsSeparatedByString:@"-"] lastObject] integerValue];
//
//        //当前天数和最小天数的间隔
//		NSInteger dayInterval = currentDay - minDay;
//
//        //天数间隔 * 24 加上当前小时
//		NSInteger totalHour = dayInterval * 24 + hour;
//
//		NSString *time = [NSString stringWithFormat:@"%ld", totalHour];
//
//		if (![hourArr containsObject:time])
//		{
//			[hourArr addObject:time];
//		}
//	}

//        //添加最大“时”
//        int t = [[hourArr lastObject] intValue] + 1;
//        [hourArr addObject:[NSString stringWithFormat:@"%d", t]];
//
//        //定义一个起始的Date做对比
//        NSString *str = [NSString stringWithFormat:@"%@ %@:00:00", [dataArr firstObject][@"dataTime"], [hourArr firstObject]];
//        NSDate *startDate = [formatter dateFromString:str];
//        NSLog(@"%@", startDate);
//
//        //间隔内总分钟数
//        NSInteger totalMinute = ([[hourArr lastObject] intValue] - [[hourArr firstObject] intValue]) * 60;
//
//        //最开始加上0
//        [statusArr addObject:[NSNumber numberWithFloat:0]];
//        [setYArr addObject:[NSNumber numberWithFloat:0]];
//
//        //计算坐标
//        for (int i = 0; i < dataArr.count; i++) {
//            NSDictionary *dic = [dataArr objectAtIndex:i];
//
//            NSDate *date = [formatter dateFromString:[[dataArr objectAtIndex:i] objectForKey:@"startTime"]];
//
//            NSDateComponents *components = [startDate intervalToDate:date];
//
//            NSInteger time2 = ((components.minute + components.hour * 60));
//
//            CGFloat y = 1.0f * time2 / totalMinute * (INTERVAL * hourArr.count);
//
//
//            [setYArr addObject:[NSNumber numberWithFloat:y]];
//
//            int status = [[dic objectForKey:@"status"] intValue];
//            [statusArr addObject:[NSNumber numberWithFloat:(status * 5)]];
//        }
//
//        //最末位加上0
//        [statusArr addObject:[NSNumber numberWithFloat:0]];
//        [setYArr addObject:[NSNumber numberWithFloat:INTERVAL * hourArr.count]];
//
//        [self setLineWithHour:hourArr];
}


@end
