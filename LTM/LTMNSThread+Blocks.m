//
//  NSThread+Blocks.m
//  LTM
//
//  Created by wangxiaoxiang on 16/8/18.
//  Copyright © 2016年 wangxiaoxiang. All rights reserved.
//

#import "LTMNSThread+Blocks.h"

@implementation NSThread (LTMBlocksAdditions)

+ (void)ltm_runBlockOnCurrentThread:(void (^)())block {
    block();
}

- (void)ltm_performBlock:(void (^)())block {
    if ([[NSThread currentThread] isEqual:self]) {
        block();
    } else {
        [self ltm_performWaitingUntilDone:NO block:block];
    }
}

- (void)ltm_performWaitingUntilDone:(BOOL)waitDone block:(void (^)())block {
    [NSThread performSelector:@selector(ltm_runBlockOnCurrentThread:)
                     onThread:self
                   withObject:[block copy]
                waitUntilDone:waitDone];
}

+ (void)ltm_performBlockInBackground:(void (^)())block {
    [NSThread performSelectorInBackground:@selector(ltm_runBlockOnCurrentThread:)
                               withObject:[block copy]];
}

@end
