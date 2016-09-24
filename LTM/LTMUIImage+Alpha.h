// UIImage+Alpha.h
// Created by Trevor Harmon on 9/20/09.
// Free for personal or commercial use, with or without modification.
// No warranty is expressed or implied.

// Helper methods for adding an alpha layer to an image
#import <UIKit/UIKit.h>

#if LTM_IOS_SDK
@interface UIImage (LTMUIImageAlphaAdditions)

- (BOOL)ltm_hasAlpha;

- (UIImage *)ltm_imageWithAlpha;

- (UIImage *)ltm_transparentBorderImage:(NSUInteger)borderSize;
@end

#endif //LTM_IOS_SDK
