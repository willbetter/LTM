//
//  LTMMerge.m
//  LTMFoundation
//
//  Created by wangxiaoxiang on 16/8/18.
//  Copyright © 2016年 wangxiaoxiang. All rights reserved.
//

#import "LTMMerge.h"
#import "LTMDefines.h"
#import <objc/message.h>

@implementation LTMMerge

+ (NSArray *)mergeArray1:(NSArray *)array1 array2:(NSArray *)array2 mergeSelector:(SEL)merger {
    return [self mergeArray1:array1 array2:array2 mergeSelector:merger compareSelector:@selector(compare:)];
}

+ (NSArray *)mergeArray1:(NSArray *)array1 array2:(NSArray *)array2 mergeSelector:(SEL)merger compareSelector:(SEL)comparer {
    //比较器
    if (!comparer) return nil;
    
    NSArray *sortedMergedArray = nil;
    if ([array1 count] && [array2 count]) {
        
        _LTMDevAssert([array1[0] isKindOfClass:[array2[0] class]], @"both array’s elements are not the same class");
        
        NSMutableArray *mergingArray = [NSMutableArray arrayWithArray:array1];
        [mergingArray sortUsingSelector:comparer];
        
        NSArray *sortedNewArray = nil;
        sortedNewArray = [array2 sortedArrayUsingSelector:comparer];
        
        NSUInteger oldIndex = 0;
        NSUInteger oldCount = [mergingArray count];
        
        id oldItem = (oldIndex < oldCount) ? [mergingArray objectAtIndex:0] : nil;
        
        for (id newItem in sortedNewArray) {
            BOOL stillLooking = YES;
            while (oldIndex < oldCount && stillLooking) {
                NSComparisonResult result = ((NSComparisonResult (*)(id, SEL, id))objc_msgSend)(newItem, comparer, oldItem);
                if (result == NSOrderedSame && merger) {
                    // It's a match!
                    id repItem = nil;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                    repItem = [oldItem performSelector:merger withObject:newItem];
#pragma clang diagnostic pop
                    
                    [mergingArray replaceObjectAtIndex:oldIndex
                                            withObject:repItem];
                    ++oldIndex;
                    oldItem = (oldIndex < oldCount) ? [mergingArray objectAtIndex:oldIndex] : nil;
                    stillLooking = NO;
                } else if (result == NSOrderedAscending
                           || (result == NSOrderedSame && !merger)) {
                    // This is either a new item and belongs right here, or it's
                    // a match to an existing item but we're not merging.
                    [mergingArray insertObject:newItem
                                       atIndex:oldIndex];
                    ++oldIndex;
                    ++oldCount;
                    stillLooking = NO;
                } else {
                    ++oldIndex;
                    oldItem = (oldIndex < oldCount) ? [mergingArray objectAtIndex:oldIndex] : nil;
                }
            }
            if (stillLooking) {
                // Once we get here, the rest of the new items get appended.
                [mergingArray addObject:newItem];
            }
        }
        sortedMergedArray = mergingArray;
    }else if ([array1 count]) {
        sortedMergedArray = [array1 sortedArrayUsingSelector:comparer];
    } else if ([array2 count]) {
        sortedMergedArray = [array2 sortedArrayUsingSelector:comparer];
    }
    return sortedMergedArray;
}

#if NS_BLOCKS_AVAILABLE
+ (NSArray *)mergeArray1:(NSArray *)array1 array2:(NSArray *)array2 merger:(UTKMerger)merger comparator:(NSComparator)cmptr {
    if (cmptr == nil) return nil;
    
    NSArray *sortedMergedArray = nil;
    if ([array1 count] && [array2 count]) {
        NSMutableArray *mergingArray = [NSMutableArray arrayWithArray:array1];
        [mergingArray sortUsingComparator:cmptr];
        
        NSArray *sortedNewArray = nil;
        sortedNewArray = [array2 sortedArrayUsingComparator:cmptr];
        
        NSUInteger oldIndex = 0;
        NSUInteger oldCount = [mergingArray count];
        
        id oldItem = (oldIndex < oldCount) ? [mergingArray objectAtIndex:0] : nil;
        
        for (id newItem in sortedNewArray) {
            BOOL stillLooking = YES;
            while (oldIndex < oldCount && stillLooking) {
                NSComparisonResult result = cmptr(newItem,oldItem);
                if (result == NSOrderedSame && merger) {
                    // It's a match!
                    id repItem = nil;
                    
                    repItem =  merger(oldItem,newItem);
                    
                    [mergingArray replaceObjectAtIndex:oldIndex
                                            withObject:repItem];
                    ++oldIndex;
                    oldItem = (oldIndex < oldCount) ? [mergingArray objectAtIndex:oldIndex] : nil;
                    stillLooking = NO;
                } else if (result == NSOrderedAscending
                           || (result == NSOrderedSame && !merger)) {
                    // This is either a new item and belongs right here, or it's
                    // a match to an existing item but we're not merging.
                    [mergingArray insertObject:newItem
                                       atIndex:oldIndex];
                    ++oldIndex;
                    ++oldCount;
                    stillLooking = NO;
                } else {
                    ++oldIndex;
                    oldItem = (oldIndex < oldCount)
                    ? [mergingArray objectAtIndex:oldIndex]
                    : nil;
                }
            }
            if (stillLooking) {
                // Once we get here, the rest of the new items get appended.
                [mergingArray addObject:newItem];
            }
        }
        sortedMergedArray = mergingArray;
    }else if ([array1 count]) {
        sortedMergedArray = [array1 sortedArrayUsingComparator:cmptr];
    } else if ([array2 count]) {
        sortedMergedArray = [array2 sortedArrayUsingComparator:cmptr];
    }
    return sortedMergedArray;
}
#endif

@end
