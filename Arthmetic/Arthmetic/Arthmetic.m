//
//  Arthmetic.m
//  Arthmetic
//
//  Created by Mr Gao on 2019/5/21.
//  Copyright © 2019年 Calvin. All rights reserved.
//

#import "Arthmetic.h"

@implementation Arthmetic

// 二分查找
+ (NSInteger)binarySortWithArray:(NSArray<NSNumber *> *)array value:(NSInteger)value
{
    NSUInteger high = array.count - 1;
    NSUInteger low = 0;
    NSUInteger mid;
    while (low < high) {
        mid = low + ((high - low)>>1);
        NSInteger midNumber = [[array objectAtIndex:mid] integerValue];
        if (midNumber == value) {
            return mid;
        }
        else if (midNumber > value) {
            high = mid - 1;
        }
        else {
            low = mid + 1;
        }
    }
    return -1;
}

// 冒泡排序
+ (void)bubbleAscendingSort:(NSMutableArray<NSNumber *> *)array
{
    if (array == nil || array.count == 1) {
        return;
    }
    
    for (int i = 0; i < array.count-1; i++) {
        for (int j = 0; j < array.count -1-i; j++) {
            NSInteger next = [[array objectAtIndex:j+1] integerValue];
            NSInteger current = [[array objectAtIndex:j] integerValue];
            if (current > next) {
                NSNumber *temp = array[j];
                array[j] = array[j+1];
                array[j+1] = temp;
            }
        }
    }
}

+ (void)bubbleDescendingSort:(NSMutableArray<NSNumber *> *)array
{
    if (array == nil || array.count == 1) {
        return;
    }
    
    for (int i = 0; i < array.count - 1; i++) {
        for (int j = 0; j < array.count - 1 - i; j++) {
            NSInteger current = [array[j] integerValue];
            NSInteger next = [array[j+1] integerValue];
            if (current < next) {
                NSNumber *temp = array[j];
                array[j] = array[j+1];
                array[j+1] = temp;
            }
        }
    }
}

@end
