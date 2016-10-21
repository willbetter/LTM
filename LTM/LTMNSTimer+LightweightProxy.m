//
//  NSTimer+LightweightProxy.m
//  LTM
//
//  Created by 汪潇翔 on 21/10/2016.
//  Copyright © 2016 wangxiaoxiang. All rights reserved.
//

#import "LTMNSTimer+LightweightProxy.h"
#import "LTMLightweightProxy.h"

@implementation NSTimer (LTMLightweightProxy)


+ (NSTimer *)ltm_scheduledTimerWithTimeInterval:(NSTimeInterval)ti
                                         target:(id)aTarget
                                       selector:(SEL)aSelector
                                       userInfo:(nullable id)userInfo
                                        repeats:(BOOL)yesOrNo {
    LTMLightweightProxy *proxy = [LTMLightweightProxy lightweightProxyWithRepresentedObject:aTarget];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:ti
                                                      target:proxy
                                                    selector:aSelector
                                                    userInfo:userInfo
                                                     repeats:yesOrNo];
    return timer;
    
}

@end
