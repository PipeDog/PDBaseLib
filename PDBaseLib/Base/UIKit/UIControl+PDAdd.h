//
//  UIControl+PDAdd.h
//  PDBaseLib
//
//  Created by liang on 2018/2/28.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (PDAdd)

// The time interval for receiving events.
@property (nonatomic, assign) NSTimeInterval pd_receiveEventInterval;

@end

NS_ASSUME_NONNULL_END
