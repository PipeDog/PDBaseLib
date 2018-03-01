//
//  UIControl+PDAdd.m
//  PDBaseLib
//
//  Created by liang on 2018/2/28.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import "UIControl+PDAdd.h"
#import <objc/runtime.h>
#import "PDCustomMacro.h"

@interface UIControl ()

// The timestamp of the last received event.
@property (nonatomic, assign) NSTimeInterval pd_receivedEventTime;

@end

@implementation UIControl (PDAdd)

PDSYNTH_DYNAMIC_PROPERTY_CTYPE(pd_receiveEventInterval, setPd_receiveEventInterval, NSTimeInterval)
PDSYNTH_DYNAMIC_PROPERTY_CTYPE(pd_receivedEventTime, setPd_receivedEventTime, NSTimeInterval)

+ (void)load {
    Method originalMethod = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method targetMethod = class_getInstanceMethod(self, @selector(pd_sendAction:to:forEvent:));
    method_exchangeImplementations(originalMethod, targetMethod);
}

- (void)pd_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if ([NSDate date].timeIntervalSince1970 - self.pd_receivedEventTime < self.pd_receiveEventInterval) {
        return;
    }
    if (self.pd_receiveEventInterval > 0) {
        self.pd_receivedEventTime = [NSDate date].timeIntervalSince1970;
    }
    [self pd_sendAction:action to:target forEvent:event];
}

@end
