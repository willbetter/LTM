// UIImage+RoundedCorner.h
// Created by Trevor Harmon on 9/20/09.
// Free for personal or commercial use, with or without modification.
// No warranty is expressed or implied.

// Extends the UIImage class to support making rounded corners
#import <UIKit/UIKit.h>

#if LTM_IOS_SDK
@interface UIImage (LTMUIImageRoundedCornerAdditions)

- (UIImage *)ltm_roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize;

@end

#endif //LTM_IOS_SDK
