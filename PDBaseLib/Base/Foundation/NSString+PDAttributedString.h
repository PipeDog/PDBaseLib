//
//  NSString+PDAttributedString.h
//  PDBaseLib
//
//  Created by liang on 2018/3/1.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PDAttributedStringMatchType) {
    PDAttributedStringMatchTypeMatchOnce = 0, ///< The first matching substring.
    PDAttributedStringMatchTypeUnmatch   = 1, ///< Unmatched substrings.
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

@end

@interface NSString (PDAttributedString) <PDAttributedStringProtol>

@end

@interface NSAttributedString (PDAdd) <PDAttributedStringProtol>

@end