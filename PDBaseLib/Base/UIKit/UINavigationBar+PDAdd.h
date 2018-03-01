//
//  UINavigationBar+PDAdd.h
//  PDBaseLib
//
//  Created by liang on 2018/2/28.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (PDAdd)

// Hide the bottom line.
- (void)hideBottomShadowImageView;

// Show the bottom line.
- (void)showBottomShadowImageView;

// Make the background of the navigation bar transparent.
- (void)makeTransparent;

// Restore the default navigation bar appearance.
- (void)makeDefault;

@end
