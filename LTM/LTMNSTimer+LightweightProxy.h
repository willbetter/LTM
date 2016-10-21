//
//  NSTimer+LightweightProxy.h
//  LTM
//
//  Created by 汪潇翔 on 21/10/2016.
//  Copyright © 2016 wangxiaoxiang. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (LTMLightweightProxy)

+ (NSTimer *)ltm_scheduledTimerWithTimeInterval:(NSTimeInterval)ti
                                         target:(id)aTarget
                                       selector:(SEL)aSelector
                                       userInfo:(nullable id)userInfo
                                        repeats:(BOOL)yesOrNo;

@end

NS_ASSUME_NONNULL_END
