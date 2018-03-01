//
//  NSString+PDAttributedString.m
//  PDBaseLib
//
//  Created by liang on 2018/3/1.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import "NSString+PDAttributedString.h"

@interface NSString (PDMatchString)

- (NSArray<NSArray *> *)onceMatchComponentsByString:(NSString *)aString;
- (NSArray<NSArray *> *)onceMatchComponentsByRange:(NSRange)range;

@end

@implementation NSString (PDMatchString)

// The elements in return array, [BOOL, NSRange]
- (NSArray<NSArray *> *)onceMatchComponentsByString:(NSString *)aString {
    if (![self containsString:aString]) {
        return @[];
    }
    NSString *selfCopy = [self copy];
    NSRange matchRange = [selfCopy rangeOfString:aString];
    
    NSRange frontRange = NSMakeRange(0, matchRange.location);
    NSRange rearRange  = NSMakeRange(matchRange.location + matchRange.length,
                                     selfCopy.length - (matchRange.location + matchRange.length));
    
    return @[@[@(NO),  [NSValue valueWithRange:frontRange]],
             @[@(YES), [NSValue valueWithRange:matchRange]],
             @[@(NO),  [NSValue valueWithRange:rearRange]]];
}

- (NSArray<NSArray *> *)onceMatchComponentsByRange:(NSRange)range {
    if (range.location > self.length || range.location + range.length > self.length) {
        return @[];
    }
    NSString *selfCopy = [self copy];
    
    NSRange frontRange = NSMakeRange(0, range.location);
    NSRange rearRange  = NSMakeRange(range.location + range.length,
                                     selfCopy.length - (range.location + range.length));
    
    return @[@[@(NO),  [NSValue valueWithRange:frontRange]],
             @[@(YES), [NSValue valueWithRange:range]],
             @[@(NO),  [NSValue valueWithRange:rearRange]]];
}

@end

@implementation NSString (PDAttributedString)

- (NSAttributedString *)setAttributes:(NSDictionary<NSAttributedStringKey, id> *)attrs
                               string:(NSString *)aString
                            matchType:(PDAttributedStringMatchType)matchType {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    if (self.length == 0) return attributedString;
    
    NSArray <NSArray *>*ranges = [self onceMatchComponentsByString:aString];
    if (ranges.count == 0) return attributedString;
    
    for (NSArray *matchInfo in ranges) {
        BOOL isMatch  = [matchInfo[0] boolValue];
        NSRange range = [matchInfo[1] rangeValue];
        
        if (matchType == PDAttributedStringMatchTypeMatchOnce) {
            if (isMatch) [attributedString setAttributes:attrs range:range];
        }
        else if (matchType == PDAttributedStringMatchTypeUnmatch) {
            if (!isMatch) [attributedString setAttributes:attrs range:range];
        }
    }
    return [attributedString copy];
}

- (NSAttributedString *)addAttributes:(NSDictionary<NSAttributedStringKey, id> *)attrs
                               string:(NSString *)aString
                            matchType:(PDAttributedStringMatchType)matchType {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    if (self.length == 0) return attributedString;
    
    NSArray <NSArray *>*ranges = [self onceMatchComponentsByString:aString];
    if (ranges.count == 0) return attributedString;
    
    for (NSArray *matchInfo in ranges) {
        BOOL isMatch  = [matchInfo[0] boolValue];
        NSRange range = [matchInfo[1] rangeValue];
        
        if (matchType == PDAttributedStringMatchTypeMatchOnce) {
            if (isMatch) [attributedString addAttributes:attrs range:range];
        }
        else if (matchType == PDAttributedStringMatchTypeUnmatch) {
            if (!isMatch) [attributedString addAttributes:attrs range:range];
        }
    }
    return [attributedString copy];
}

- (NSAttributedString *)setAttributes:(NSDictionary<NSAttributedStringKey, id> *)attrs
                                range:(NSRange)range
                            matchType:(PDAttributedStringMatchType)matchType {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    if (self.length == 0) return attributedString;
    
    if (range.location > self.length) range.length = self.length;
    
    NSArray <NSArray *>*ranges = [self onceMatchComponentsByRange:range];
    if (ranges.count == 0) return attributedString;
    
    for (NSArray *matchInfo in ranges) {
        BOOL isMatch   = [matchInfo[0] boolValue];
        NSRange _range = [matchInfo[1] rangeValue];
        
        if (matchType == PDAttributedStringMatchTypeMatchOnce) {
            if (isMatch) [attributedString setAttributes:attrs range:_range];
        }
        else if (matchType == PDAttributedStringMatchTypeUnmatch) {
            if (!isMatch) [attributedString setAttributes:attrs range:_range];
        }
    }
    return [attributedString copy];
}

- (NSAttributedString *)addAttributes:(NSDictionary<NSAttributedStringKey, id> *)attrs
                                range:(NSRange)range
                            matchType:(PDAttributedStringMatchType)matchType {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    if (self.length == 0) return attributedString;
    
    if (range.location > self.length) range.length = self.length;
    
    NSArray <NSArray *>*ranges = [self onceMatchComponentsByRange:range];
    if (ranges.count == 0) return attributedString;
    
    for (NSArray *matchInfo in ranges) {
        BOOL isMatch   = [matchInfo[0] boolValue];
        NSRange _range = [matchInfo[1] rangeValue];
        
        if (matchType == PDAttributedStringMatchTypeMatchOnce) {
            if (isMatch) [attributedString addAttributes:attrs range:_range];
        }
        else if (matchType == PDAttributedStringMatchTypeUnmatch) {
            if (!isMatch) [attributedString addAttributes:attrs range:_range];
        }
    }
    return [attributedString copy];
}

@end

@implementation NSAttributedString (PDAdd)

- (NSAttributedString *)setAttributes:(NSDictionary<NSAttributedStringKey, id> *)attrs
                               string:(NSString *)aString
                            matchType:(PDAttributedStringMatchType)matchType {
    NSMutableAttributedString *attributedString = [self mutableCopy];
    if (self.length == 0) return attributedString;
    
    NSArray <NSArray *>*ranges = [self.string onceMatchComponentsByString:aString];
    if (ranges.count == 0) return attributedString;
    
    for (NSArray *matchInfo in ranges) {
        BOOL isMatch  = [matchInfo[0] boolValue];
        NSRange range = [matchInfo[1] rangeValue];
        
        if (matchType == PDAttributedStringMatchTypeMatchOnce) {
            if (isMatch) [attributedString setAttributes:attrs range:range];
        }
        else if (matchType == PDAttributedStringMatchTypeUnmatch) {
            if (!isMatch) [attributedString setAttributes:attrs range:range];
        }
    }
    return [attributedString copy];
}

- (NSAttributedString *)addAttributes:(NSDictionary<NSAttributedStringKey, id> *)attrs
                               string:(NSString *)aString
                            matchType:(PDAttributedStringMatchType)matchType {
    NSMutableAttributedString *attributedString = [self mutableCopy];
    if (self.length == 0) { return attributedString; }
    
    NSArray <NSArray *>*ranges = [self.string onceMatchComponentsByString:aString];
    if (ranges.count == 0) { return attributedString; }
    
    for (NSArray *matchInfo in ranges) {
        BOOL isMatch  = [matchInfo[0] boolValue];
        NSRange range = [matchInfo[1] rangeValue];
        
        if (matchType == PDAttributedStringMatchTypeMatchOnce) {
            if (isMatch) [attributedString addAttributes:attrs range:range];
        }
        else if (matchType == PDAttributedStringMatchTypeUnmatch) {
            if (!isMatch) [attributedString addAttributes:attrs range:range];
        }
    }
    return [attributedString copy];
}

- (NSAttributedString *)setAttributes:(NSDictionary<NSAttributedStringKey, id> *)attrs
                                range:(NSRange)range
                            matchType:(PDAttributedStringMatchType)matchType {
    NSMutableAttributedString *attributedString = [self mutableCopy];
    if (self.length == 0) return attributedString;
    
    if (range.location > self.length) range.length = self.length;
    
    NSArray <NSArray *>*ranges = [self.string onceMatchComponentsByRange:range];
    if (ranges.count == 0) return attributedString;
    
    for (NSArray *matchInfo in ranges) {
        BOOL isMatch   = [matchInfo[0] boolValue];
        NSRange _range = [matchInfo[1] rangeValue];
        
        if (matchType == PDAttributedStringMatchTypeMatchOnce) {
            if (isMatch) [attributedString setAttributes:attrs range:_range];
        }
        else if (matchType == PDAttributedStringMatchTypeUnmatch) {
            if (!isMatch) [attributedString setAttributes:attrs range:_range];
        }
    }
    return [attributedString copy];
}

- (NSAttributedString *)addAttributes:(NSDictionary<NSAttributedStringKey, id> *)attrs
                                range:(NSRange)range
                            matchType:(PDAttributedStringMatchType)matchType {
    NSMutableAttributedString *attributedString = [self mutableCopy];
    if (self.length == 0) return attributedString;
    
    if (range.location > self.length) range.length = self.length;
    
    NSArray <NSArray *>*ranges = [self.string onceMatchComponentsByRange:range];
    if (ranges.count == 0) return attributedString;
    
    for (NSArray *matchInfo in ranges) {
        BOOL isMatch   = [matchInfo[0] boolValue];
        NSRange _range = [matchInfo[1] rangeValue];
        
        if (matchType == PDAttributedStringMatchTypeMatchOnce) {
            if (isMatch) [attributedString addAttributes:attrs range:_range];
        }
        else if (matchType == PDAttributedStringMatchTypeUnmatch) {
            if (!isMatch) [attributedString addAttributes:attrs range:_range];
        }
    }
    return [attributedString copy];
}

@end

