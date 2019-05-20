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

/**
 * 冒泡升序
 * 思路：两个两个比较，如果前一个比后一个大就交换l；第一趟的结果是遍历出最大的元素到末尾
 */
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

// 冒泡降序
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

/**
 * 选择排序
 * 思路：每一次都挑选出未排序中的最小值或者最大值与未排好序的最左位置或最右位置交换
 */
+ (void)selectSort:(NSMutableArray<NSNumber *> *)array
{
    int i, j, min;
    for (i = 0; i < array.count - 1; i++) {
        min = i;
        for (j = i+1; j < array.count; j++) {
            NSInteger num = [[array objectAtIndex:j] integerValue];
            NSInteger mix = [[array objectAtIndex:min] integerValue];
            if (mix > num) {
                min = j;
            }
        }
        
        if (min != i) {
            NSNumber *temp = array[min];
            array[min] = array[i];
            array[i] = temp;
            NSLog(@"第%d趟排序结果为：%@", i+1, array);
        }
    }
}

@end
