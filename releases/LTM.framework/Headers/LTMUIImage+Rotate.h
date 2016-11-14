//
//  UIImage+Rotate.h
//  LFToolboxKit
//
//  Created by wangxiaoxiang on 16/7/17.
//  Copyright © 2016年 Youku. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UIImage (LTMUIImageRotateAdditions)

- (UIImage *)ltm_rotatedImageWithOrientation:(UIImageOrientation)targetOrientation;

@end
