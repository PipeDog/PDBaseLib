//
//  PDCustomMacro.h
//  PDBaseLib
//
//  Created by liang on 2018/2/28.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#ifndef PDCustomMacro_h
#define PDCustomMacro_h


/**
 Synthsize a dynamic object property in @implementation scope.
 It allows us to add custom properties to existing classes in categories.
 
 @param association  ASSIGN / RETAIN / COPY / RETAIN_NONATOMIC / COPY_NONATOMIC
 @warning #import <objc/runtime.h>
 *******************************************************************************
 Example:
 @interface NSObject (MyAdd)
 @property (nonatomic, retain) UIColor *myColor;
 @end
 
 #import <objc/runtime.h>
 @implementation NSObject (MyAdd)
 PDSYNTH_DYNAMIC_PROPERTY_OBJECT(myColor, setMyColor, RETAIN, UIColor *)
 @end
 */
#ifndef PDSYNTH_DYNAMIC_PROPERTY_OBJECT
#define PDSYNTH_DYNAMIC_PROPERTY_OBJECT(_getter_, _setter_, _association_, _type_) \
- (void)_setter_ : (_type_)object { \
    [self willChangeValueForKey:@#_getter_]; \
    objc_setAssociatedObject(self, _cmd, object, OBJC_ASSOCIATION_ ## _association_); \
    [self didChangeValueForKey:@#_getter_]; \
} \
\
- (_type_)_getter_ { \
    return objc_getAssociatedObject(self, @selector(_setter_:)); \
}
#endif


/**
 Synthsize a dynamic c type property in @implementation scope.
 It allows us to add custom properties to existing classes in categories.
 
 @warning #import <objc/runtime.h>
 *******************************************************************************
 Example:
 @interface NSObject (MyAdd)
 @property (nonatomic, retain) CGPoint myPoint;
 @end
 
 #import <objc/runtime.h>
 @implementation NSObject (MyAdd)
 PDSYNTH_DYNAMIC_PROPERTY_CTYPE(myPoint, setMyPoint, CGPoint)
 @end
 */
#ifndef PDSYNTH_DYNAMIC_PROPERTY_CTYPE
#define PDSYNTH_DYNAMIC_PROPERTY_CTYPE(_getter_, _setter_, _type_) \
- (void)_setter_ : (_type_)object { \
    [self willChangeValueForKey:@#_getter_]; \
    NSValue *value = [NSValue value:&object withObjCType:@encode(_type_)]; \
    objc_setAssociatedObject(self, _cmd, value, OBJC_ASSOCIATION_RETAIN); \
    [self didChangeValueForKey:@#_getter_]; \
} \
\
- (_type_)_getter_ { \
    _type_ cValue = { 0 }; \
    NSValue *value = objc_getAssociatedObject(self, @selector(_setter_:)); \
    [value getValue:&cValue]; \
    return cValue; \
}
#endif


/**
 Create singleton object.
 Don't restrict you to create other objects of the class.
 *******************************************************************************
 Example:
 
 @interface SRUserStore : NSObject SINGLETON_INTERFACE_NO_LIMIT(Store)
 @end
 
 @implementation SRUserStore () SINGLETON_IMPLEMENATION_NO_LIMIT(Store)
 @end
 
 Call methods:
 
 SRUserStore *store = [SRUserStore defaultStore];
 */
#define SINGLETON_INTERFACE_NO_LIMIT(__Suffix__) /* interface 中方法声明 */ \
\
+ (instancetype)default##__Suffix__;

#define SINGLETON_IMPLEMENATION_NO_LIMIT(__Suffix__) /* implementation 中方法实现，该类可创建其它对象 */ \
static id __defaultObjc__ = nil; \
\
+ (instancetype)default##__Suffix__ { \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        __defaultObjc__ = [[self alloc] init]; \
    }); \
    \
    return __defaultObjc__; \
}


/**
 Singleton object creation.
 You can only create the unique singleton object through the Shared method.
 Unable to create other objects of the class.
 *******************************************************************************
 Example:
 
 @interface SRUserStore : NSObject SINGLETON_INTERFACE
 @end
 
 @implementation SRUserStore () SINGLETON_IMPLEMENATION_LIMIT
 @end
 
 Call methods:
 SRUserStore *store = [SRUserStore shared];
 // otherStore is nil.
 SRUserStore *otherStore = [[SRUserStore alloc] init];
 */
#define SINGLETON_INTERFACE /* interface 中方法声明 */ \
\
+ (instancetype)shared;

#define SINGLETON_IMPLEMENATION_LIMIT /* implementation 中方法实现，该类只能创建唯一一个对象 */ \
static id __sharedObjc__ = nil; \
\
+ (instancetype)shared { \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        __sharedObjc__ = [self new]; \
    }); \
    \
    return __sharedObjc__;\
} \
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone { \
    @synchronized (self) { \
        if (__sharedObjc__ == nil) { \
            __sharedObjc__ = [super allocWithZone:zone]; \
            return __sharedObjc__; \
        } \
    } \
    return nil; \
} \
\
- (instancetype)copyWithZone:(NSZone *)zone { \
    return __sharedObjc__; \
}


/// Suppress warning for performSelector.
#define SUPPRESS_PERFORMSELECTOR_LEAK_WARNING(Stuff) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop")


/// Remove and release the view.
#ifndef PDRelease_UIView
#define PDRelease_UIView(__ref) \
\
{ \
    if ((__ref) != nil) { \
        [__ref removeFromSuperview]; \
        __ref = nil; \
    } \
}
#endif


/// Processing of strings.
#ifndef STR_SAFE
#define STR_SAFE(_str_) /* 字符串确保不为nil */ \
    ([_str_ isKindOfClass:[NSString class]] ? (_str_.length > 0 ? _str_ : @"") : (@""))
#endif

#define STR_FORMAT(...) [NSString stringWithFormat:__VA_ARGS__] // 字符串拼接


/// Safe callback.
#ifndef BLOCK_EXE
#define BLOCK_EXE(blk_t, ...) \
if (blk_t) { \
    blk_t(__VA_ARGS__); \
}
#endif


/// Definition of pixel value.
#ifndef PDScreenWidth
#define PDScreenWidth ([UIScreen mainScreen].bounds.size.width)
#endif

#ifndef PDScreenHeight
#define PDScreenHeight ([UIScreen mainScreen].bounds.size.height)
#endif

#ifndef PDStatusBarHeight
#define PDStatusBarHeight (CGRectGetHeight([UIApplication sharedApplication].statusBarFrame))
#endif

#endif /* PDCustomMacro_h */
