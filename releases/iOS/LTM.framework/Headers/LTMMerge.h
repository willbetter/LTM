//
//  LTMMerge.h
//  LTMFoundation
//
//  Created by wangxiaoxiang on 16/8/18.
//  Copyright © 2016年 wangxiaoxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTMMerge : NSObject
// The signature of the |merger| is:
//    - (id)merge:(id)newItem;
//
// The signature of the |comparer| is:
//   - (NSComparisonResult)compare:(id)other
//
// Returns a new, sorted array.
+ (NSArray *)mergeArray1:(NSArray *)array1
                  array2:(NSArray *)array2
           mergeSelector:(SEL)merger;

+ (NSArray *)mergeArray1:(NSArray *)array1
                  array2:(NSArray *)array2
           mergeSelector:(SEL)merger
         compareSelector:(SEL)comparer;

#if NS_BLOCKS_AVAILABLE
typedef id  (^UTKMerger)(id  obj1, id   obj2);

// Returns a new, sorted array.
+ (NSArray *)mergeArray1:(NSArray *)array1
                  array2:(NSArray *)array2
                  merger:(UTKMerger)merger
              comparator:(NSComparator)cmptr;
#endif
@end
