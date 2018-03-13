//
//  NSString+PDAttributedString.h
//  PDBaseLib
//
//  Created by liang on 2018/3/1.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PDAttributedStringMatchType) {
    PDAttributedStringMatchTypeMatchOnce   = 0, ///< The first matching substring.
    PDAttributedStringMatchTypeUnmatchOnce = 1, ///< Unmatched substrings with matched once.
    PDAttributedStringMatchTypeMatchAll    = 2, ///< Match all substring.
    PDAttributedStringMatchTypeUnmatchAll  = 3, ///< Unmatched substrings with matched all.
};

@protocol PDAttributedStringProtol <NSObject>

@optional
// The key can refer to the <<< NSAttributedString.h >>> in <<< UIKit >>>.
- (NSAttributedString *)setAttributes:(NSDictionary<NSAttributedStringKey, id> *)attrs
                               string:(NSString *)aString
                            matchType:(PDAttributedStringMatchType)matchType;

- (NSAttributedString *)addAttributes:(NSDictionary<NSAttributedStringKey, id> *)attrs
                               string:(NSString *)aString
                            matchType:(PDAttributedStringMatchType)matchType;

- (NSAttributedString *)setAttributes:(NSDictionary<NSAttributedStringKey, id> *)attrs
                                range:(NSRange)range
                            matchType:(PDAttributedStringMatchType)matchType;

- (NSAttributedString *)addAttributes:(NSDictionary<NSAttributedStringKey, id> *)attrs
                                range:(NSRange)range
                            matchType:(PDAttributedStringMatchType)matchType;

- (NSArray<NSArray *> *)allMatchComponentsByString:(NSString *)aString;
- (NSArray<NSArray *> *)allUnmatchComponentsByString:(NSString *)aString;

@end

@interface NSString (PDAttributedString) <PDAttributedStringProtol>

@end

@interface NSAttributedString (PDAdd) <PDAttributedStringProtol>

@end
