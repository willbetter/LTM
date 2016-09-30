//
//  UIView+Snapshot.h
//  LFToolboxKit
//
//  Created by wangxiaoxiang on 16/7/17.
//  Copyright © 2016年 Youku. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UIView (LTMUIViewSnapshotAdditions)
/**
 Create a snapshot image of the complete view hierarchy.
 This method should be called in main thread.
 */
- (UIImage *)ltm_snapshot;

@end
