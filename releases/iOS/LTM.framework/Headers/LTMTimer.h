//
//  LTMTimer.h
//  LTM
//
//  Created by 汪潇翔 on 21/10/2016.
//  Copyright © 2016 wangxiaoxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTMTimer : NSObject

- (instancetype)initWithTimeInterval:(NSTimeInterval)timeInterval
                              target:(id)target
                            selector:(SEL)selector
                            userInfo:(id)userInfo
                             repeats:(BOOL)repeats
                       dispatchQueue:(dispatch_queue_t)dispatchQueue;

+ (instancetype)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval
                                        target:(id)target
                                      selector:(SEL)selector
                                      userInfo:(id)userInfo
                                       repeats:(BOOL)repeats
                                 dispatchQueue:(dispatch_queue_t)dispatchQueue;

- (void)schedule;

@property (atomic, assign) NSTimeInterval tolerance;

- (void)fire;

- (void)invalidate;

- (id)userInfo;

@end
