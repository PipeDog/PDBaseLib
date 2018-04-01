//
//  UIApplication+PDAdd.m
//  PDBaseLib
//
//  Created by liang on 2018/4/1.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import "UIApplication+PDAdd.h"

@implementation UIApplication (PDAdd)

- (void)callPhone:(NSString *)phone completion:(void (^)(BOOL))completion {
    NSString *tel = [NSString stringWithFormat:@"tel://%@", phone];
    [self openURL:tel completion:completion];
}

- (void)openSystemPreferencesWithCompletion:(void (^)(BOOL))completion {
    NSString *urlString;
    
    if ([[UIDevice currentDevice].systemVersion integerValue] >= 8) {
        urlString = UIApplicationOpenSettingsURLString;
    } else {
        urlString = @"prefs://";
    }
    [self openURL:urlString completion:completion];
}

- (void)openURL:(NSString *)urlString completion:(void (^)(BOOL))completion {
    NSURL *url = [NSURL URLWithString:STR_SAFE(urlString)];
    
    if (![self canOpenURL:url]) {
        BLOCK_EXE(completion, NO);
        return;
    }
    
    if (@available(iOS 10, *)) {
        [self openURL:url options:@{} completionHandler:completion];
    } else {
        [self openURL:url];
        BLOCK_EXE(completion, YES);
    }
}

@end
