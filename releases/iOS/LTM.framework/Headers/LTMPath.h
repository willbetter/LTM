//
//  LTMPath.h
//  LTM
//
//  Created by wangxiaoxiang on 16/8/22.
//  Copyright © 2016年 wangxiaoxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

#if defined __cplusplus
extern "C" {
#endif
    
    /**
     * Create a path with the documents directory and the relative path appended.
     *
     * @returns The documents path concatenated with the given relative path.
     */
    NSString* LTMPathForDocumentsResource(NSString* relativePath);
    
    /**
     * Create a path with the Library directory and the relative path appended.
     *
     * @returns The Library path concatenated with the given relative path.
     */
    NSString* LTMPathForLibraryResource(NSString* relativePath);
    
    /**
     * Create a path with the caches directory and the relative path appended.
     *
     * @returns The caches path concatenated with the given relative path.
     */
    NSString* LTMPathForCachesResource(NSString* relativePath);
    
#if defined __cplusplus
};
#endif

@interface LTMPath : NSObject

@end
