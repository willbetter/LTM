//
//  NSThread+Blocks.h
//  LTM
//
//  Created by wangxiaoxiang on 16/8/18.
//  Copyright © 2016年 wangxiaoxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSThread (LTMBlocksAdditions)
// If self is not the current thread, the block will be called asynchronously
// and this method returns immediately.
// If self is the current thread, the block will be performed immediately, and
// then this method will return.
- (void)ltm_performBlock:(void (^)())block;

- (void)ltm_performWaitingUntilDone:(BOOL)waitDone block:(void (^)())block;
+ (void)ltm_performBlockInBackground:(void (^)())block;
@end
