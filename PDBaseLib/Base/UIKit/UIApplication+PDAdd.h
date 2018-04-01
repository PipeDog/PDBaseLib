//
//  UIApplication+PDAdd.h
//  PDBaseLib
//
//  Created by liang on 2018/4/1.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (PDAdd)

// Call phone.
- (void)callPhone:(NSString *)phone completion:(void (^ __nullable)(BOOL success))completion;

// Open system preferences.
- (void)openSystemPreferencesWithCompletion:(void (^ __nullable)(BOOL success))completion;

// Open the custom url, adapt to different system versions.
- (void)openURL:(NSString *)urlString completion:(void (^ __nullable)(BOOL success))completion;

@end

NS_ASSUME_NONNULL_END
