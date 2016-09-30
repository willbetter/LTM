//
//  UIImage+Rotate.m
//  LFToolboxKit
//
//  Created by wangxiaoxiang on 16/7/17.
//  Copyright © 2016年 Youku. All rights reserved.
//

#import "LTMUIImage+Rotate.h"

UIKIT_STATIC_INLINE CGSize _LTMSwapWidthAndHeight(CGSize size) {
    CGFloat  tempWidth = size.width;
    
    size.width  = size.height;
    size.height = tempWidth;
    
    return size;
}

@implementation UIImage (LTMUIImageRotateAdditions)

- (UIImage *)ltm_rotatedImageWithOrientation:(UIImageOrientation)targetOrientation {
    CGRect bounds = CGRectZero;
    CGRect rect = CGRectZero;
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    bounds.size = [self size];
    rect.size = [self size];
    
    switch (targetOrientation) {
        case UIImageOrientationUp:
            return [UIImage imageWithCGImage:[self CGImage]];
            
        case UIImageOrientationUpMirrored:
            transform = CGAffineTransformMakeTranslation(rect.size.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown:
            transform = CGAffineTransformMakeTranslation(rect.size.width,
                                                         rect.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformMakeTranslation(0.0, rect.size.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeft:
            bounds.size = _LTMSwapWidthAndHeight(bounds.size);
            transform = CGAffineTransformMakeTranslation(0.0, rect.size.width);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
            
        case UIImageOrientationLeftMirrored:
            bounds.size = _LTMSwapWidthAndHeight(bounds.size);
            transform = CGAffineTransformMakeTranslation(rect.size.height,
                                                         rect.size.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
            
        case UIImageOrientationRight:
            bounds.size = _LTMSwapWidthAndHeight(bounds.size);
            transform = CGAffineTransformMakeTranslation(rect.size.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRightMirrored:
            bounds.size = _LTMSwapWidthAndHeight(bounds.size);
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        default:
            NSAssert(false, @"Invalid orientation %zd", targetOrientation);
            return nil;
    }
    
    UIGraphicsBeginImageContextWithOptions(bounds.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    switch (targetOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextScaleCTM(context, -1.0, 1.0);
            CGContextTranslateCTM(context, -rect.size.height, 0.0);
            break;
            
        default:
            CGContextScaleCTM(context, 1.0, -1.0);
            CGContextTranslateCTM(context, 0.0, -rect.size.height);
            break;
    }
    
    CGContextConcatCTM(context, transform);
    CGContextDrawImage(context, rect, [self CGImage]);
    
    UIImage *rotatedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return rotatedImage;
}

@end
