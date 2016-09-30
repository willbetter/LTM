//
//  UIView+Snapshot.m
//  LFToolboxKit
//
//  Created by wangxiaoxiang on 16/7/17.
//  Copyright © 2016年 Youku. All rights reserved.
//

#import "LTMUIView+Snapshot.h"

static BOOL g_drawViewHierarchyInRect = NO;

@implementation UIView (LTMUIViewSnapshotAdditions)

+ (void)load {
    g_drawViewHierarchyInRect = [self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)];
}

-(UIImage *)ltm_snapshot {
    UIImage *image = nil;
    if (g_drawViewHierarchyInRect) {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0);
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }else{
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
    }
    return image;
}

@end
