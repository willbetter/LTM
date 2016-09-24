//
//  LFCoreDefines.h
//  LFToolboxKit
//
//  Created by zhiwei wang on 16/6/30.
//  Copyright © 2016年 Youku. All rights reserved.
//

#ifndef LTMDefines_h
#define LTMDefines_h


#import <Foundation/Foundation.h>

#if !defined(LTM_INLINE)
    #if (defined (__GNUC__) && (__GNUC__ == 4)) || defined (__clang__)
        #define LTM_INLINE static __inline__ __attribute__((always_inline))
    #else
        #define LTM_INLINE static __inline__
    #endif
#endif


#ifdef __cplusplus
    #define LTM_EXTERN extern "C" __attribute__((visibility ("default")))
#else
    #define LTM_EXTERN extern __attribute__((visibility ("default")))
#endif

#define LTM_STATIC_INLINE static inline

#define LTM_NO_DESIGNATED_INITIALIZER() \
            @throw [NSException exceptionWithName:NSInvalidArgumentException \
                                           reason:[NSString stringWithFormat:@"unrecognized selector sent to instance %p", self] \
                                         userInfo:nil]

#define LTM_NOT_DESIGNATED_INITIALIZER(DESIGNATED_INITIALIZER) \
            @throw [NSException exceptionWithName:NSInvalidArgumentException \
                                           reason:[NSString stringWithFormat:@"Please use the designated initializer [%p %@]", \
                                        self, NSStringFromSelector(@selector(DESIGNATED_INITIALIZER))] \
                                         userInfo:nil]


#if TARGET_OS_IPHONE
    #define LTM_IOS_SDK 1
    #if TARGET_IPHONE_SIMULATOR
        #define LTM_IOS_DEVICE 0
        #define LTM_IOS_SIMULATOR 1
    #else
        #define LTM_IOS_DEVICE 1
        #define LTM_IOS_SIMULATOR 0
    #endif
#else
    #define LTM_MACOS_SDK 1
    #define LTM_IOS_SDK 0
    #define LTM_IOS_DEVICE 0
    #define LTM_IOS_SIMULATOR 0
#endif //TARGET_OS_IPHONE


#if LTM_MACOS_SDK
    #define LTM_AVAILABLE_ONLY_ON_IOS UNAVAILABLE_ATTRIBUTE
    #define LTM_AVAILABLE_ONLY_ON_MACOS
#else
    #define LTM_AVAILABLE_ONLY_ON_IOS
    #define LTM_AVAILABLE_ONLY_ON_MACOS UNAVAILABLE_ATTRIBUTE
#endif //LTM_MACOS_SDK

#define LTMSuppressPerformSelectorLeakWarning(Stuff) \
            do { \
                _Pragma("clang diagnostic push") \
                _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
                Stuff; \
                _Pragma("clang diagnostic pop") \
            } while (0)


#ifndef _LTMDevLog
    #ifdef DEBUG
        #define _LTMDevLog(...) NSLog(__VA_ARGS__)
    #else
        #define _LTMDevLog(...) do { } while (0)
    #endif
#endif //_LTMDevLog

#ifndef _LTMDevAssert
    // we directly invoke the NSAssert handler so we can pass on the varargs
    // (NSAssert doesn't have a macro we can use that takes varargs)
    #if !defined(NS_BLOCK_ASSERTIONS)
        #define _LTMDevAssert(condition, ...)                                                                           \
                    do {                                                                                                \
                        if (!(condition)) {                                                                             \
                            [[NSAssertionHandler currentHandler]                                                        \
                                handleFailureInFunction:(NSString *)[NSString stringWithUTF8String:__PRETTY_FUNCTION__] \
                                                   file:(NSString *)[NSString stringWithUTF8String:__FILE__]            \
                                             lineNumber:__LINE__                                                        \
                                            description:__VA_ARGS__];                                                   \
                        }                                                                                               \
                    } while(0)
    #else // !defined(NS_BLOCK_ASSERTIONS)
        #define _LTMDevAssert(condition, ...) do { } while (0)
    #endif // !defined(NS_BLOCK_ASSERTIONS)

#endif // _LTMDevAssert


#endif /* LTMDefines_h */
