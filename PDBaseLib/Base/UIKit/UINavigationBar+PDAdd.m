//
//  UINavigationBar+PDAdd.m
//  PDBaseLib
//
//  Created by liang on 2018/2/28.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import "UINavigationBar+PDAdd.h"

@implementation UINavigationBar (PDAdd)

- (void)hideBottomShadowImageView {
    UIImageView *bottomShadowImageView = [self findBottomShadowImageView:self];
    bottomShadowImageView.hidden = YES;
}

- (void)showBottomShadowImageView {
    UIImageView *bottomShadowImageView = [self findBottomShadowImageView:self];
    bottomShadowImageView.hidden = NO;
}

- (void)makeTransparent {
    [self setTranslucent:YES];
    [self setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.backgroundColor = [UIColor clearColor];
    self.shadowImage = [[UIImage alloc] init];
    [self hideBottomShadowImageView];
}

- (void)makeDefault {
    [self setTranslucent:YES];
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.backgroundColor = nil;
    self.shadowImage = nil;
    [self showBottomShadowImageView];
}

- (UIImageView *)findBottomShadowImageView:(UIView *)aView {
    if ([aView isKindOfClass:UIImageView.class] && aView.bounds.size.height <= 1.0) {
        return (UIImageView *)aView;
    }
    for (UIView *subview in aView.subviews) {
        UIImageView *imageView = [self findBottomShadowImageView:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

@end
