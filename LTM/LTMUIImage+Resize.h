// UIImage+Resize.h
// Created by Trevor Harmon on 8/5/09.
// Free for personal or commercial use, with or without modification.
// No warranty is expressed or implied.

// Extends the UIImage class to support resizing/cropping
#import <UIKit/UIKit.h>


#if LTM_IOS_SDK
@interface UIImage (LTMUIImageResizeAdditions)

- (UIImage *)ltm_croppedImage:(CGRect)bounds;

- (UIImage *)ltm_thumbnailImage:(NSInteger)thumbnailSize
              transparentBorder:(NSUInteger)borderSize
                   cornerRadius:(NSUInteger)cornerRadius
           interpolationQuality:(CGInterpolationQuality)quality;


- (UIImage *)ltm_resizedImage:(CGSize)newSize
         interpolationQuality:(CGInterpolationQuality)quality;

#if !TARGET_OS_WATCH
- (UIImage *)ltm_resizedImageWithContentMode:(UIViewContentMode)contentMode
                                      bounds:(CGSize)bounds
                        interpolationQuality:(CGInterpolationQuality)quality;
#endif
@end

#endif //LTM_IOS_SDK
