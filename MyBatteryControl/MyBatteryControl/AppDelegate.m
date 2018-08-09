//
//  AppDelegate.m
//  MyBatteryControl
//
//  Created by 莫锹文 on 2017/12/26.
//  Copyright © 2017年 莫锹文. All rights reserved.
//

#import "AppDelegate.h"
#import <IOKit/IOKitLib.h>
#import <IOKit/ps/IOPowerSources.h>
#import <IOKit/ps/IOPSKeys.h>

@interface AppDelegate ()
@property (nonatomic, strong) NSStatusItem *statusBar;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSPopover *popover;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    self.statusBar = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    self.statusBar.target = self;
    self.statusBar.action = @selector(showMyPopover:);
    
    NSStoryboard *storyboard = [NSStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    NSViewController *controller = [storyboard instantiateControllerWithIdentifier:@"popView"];
    
    self.popover = [[NSPopover alloc] init];
    self.popover.behavior = NSPopoverBehaviorTransient;
    self.popover.appearance = [NSAppearance appearanceNamed:NSAppearanceNameVibrantLight];
    self.popover.contentViewController = controller;
    
    //    [self setCurrent:0];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(getInfo) userInfo:nil repeats:YES];
    [self getInfo];
}

- (void)getInfo
{
    CFTypeRef info;
    CFArrayRef list;
    CFDictionaryRef battery;
    
    info = IOPSCopyPowerSourcesInfo();
    
    if (info == NULL)
    {
        return;
    }
    list = IOPSCopyPowerSourcesList(info);
    
    if (list == NULL)
    {
        CFRelease(info);
        return;
    }
    
    if (CFArrayGetCount(list) && (battery = IOPSGetPowerSourceDescription(info, CFArrayGetValueAtIndex(list, 0))))
    {
        //            NSLog(@"%@", (__bridge NSDictionary *)battery);
        //            BOOL outputInstalled = [[(__bridge NSDictionary *) battery objectForKey:@kIOPSIsPresentKey] boolValue];
        //            BOOL outputConnected = [(NSString *)[(__bridge NSDictionary *) battery objectForKey:@kIOPSPowerSourceStateKey] isEqualToString:@kIOPSACPowerValue];
        //            BOOL outputCharging = [[(__bridge NSDictionary *) battery objectForKey:@kIOPSIsChargingKey] boolValue];
        CGFloat outputCurrent = [[(__bridge NSDictionary *) battery objectForKey:@kIOPSCurrentKey] doubleValue];
        //            CGFloat outputVoltage = [[(__bridge NSDictionary *) battery objectForKey:@kIOPSVoltageKey] doubleValue];
        //            CGFloat outputCapacity = [[(__bridge NSDictionary *) battery objectForKey:@kIOPSCurrentCapacityKey] doubleValue];
        //            CGFloat outputMaxCapacity = [[(__bridge NSDictionary *) battery objectForKey:@kIOPSMaxCapacityKey] doubleValue];
        
        //            NSLog(@"outputInstalled : %d", outputInstalled);
        //            NSLog(@"outputConnected : %d", outputConnected);
        //            NSLog(@"outputCharging : %d", outputCharging);
        //            NSLog(@"outputCurrent : %f", outputCurrent);
        //            NSLog(@"outputVoltage : %f", outputVoltage);
        //            NSLog(@"outputCapacity : %f", outputCapacity);
        //            NSLog(@"outputMaxCapacity : %f", outputMaxCapacity);
        [self setCurrent:outputCurrent];
    }
    else
    {
        //            self.outputInstalled = NO;
        //            self.outputConnected = NO;
        //            self.outputCharging = NO;
        //            self.outputCurrent = 0.0;
        //            self.outputVoltage = 0.0;
        //            self.outputCapacity = 0.0;
        //            self.outputMaxCapacity = 0.0;
    }
    
    CFRelease(list);
    CFRelease(info);
}

- (void)showMyPopover:(NSStatusBarButton *)button
{
    [self.popover showRelativeToRect:button.bounds ofView:button preferredEdge:NSRectEdgeMaxY];
}

- (void)setCurrent:(CGFloat)value
{
    int num = floor(value);
    
    self.statusBar.title = [NSString stringWithFormat:@"%d mA", num];
}

@end
