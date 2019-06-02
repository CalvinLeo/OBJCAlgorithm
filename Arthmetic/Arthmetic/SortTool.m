//
//  Arthmetic.m
//  Arthmetic
//
//  Created by Mr Gao on 2019/5/21.
//  Copyright © 2019年 Calvin. All rights reserved.
//

#import "SortTool.h"

@implementation SortTool

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
    
    for (int i = 0; i < array.count; i++) {
        for (int j = 1; j < array.count-i; j++) {
            NSInteger current = [[array objectAtIndex:j] integerValue];
            NSInteger last = [[array objectAtIndex:j - 1] integerValue];
            if (last > current) {
                NSNumber *temp = array[j];
                array[j] = array[j-1];
                array[j-1] = temp;
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
    
    for (int i = 0; i < array.count; i++) {
        for (int j = 1; j < array.count - i; j++) {
            NSInteger current = [array[j] integerValue];
            NSInteger last = [array[j-1] integerValue];
            if (last < current) {
                NSNumber *temp = array[j];
                array[j] = array[j-1];
                array[j-1] = temp;
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

/**
 * 插入排序
 * 思路：插入排序是在一个已经有序的小序列的基础上，一次插入一个元素。当然，刚开始这个有序的小序列只有1个元素，就是第一个元素。比较是从有序序列的末尾开始，也就是想要插入的元素和已经有序的最大者开始比起，如果比它大则直接插入在其后面，否则一直往前找直到找到它该插入的位置。如果碰见一个和插入元素相等的，那么插入元素把想插入的元素放在相等元素的后面。所以，相等元素的前后顺序没有改变，从原无序序列出去的顺序就是排好序后的顺序，所以插入排序是稳定的。
 */
+ (void)insertionSort:(NSMutableArray<NSNumber *> *)array
{
    if (array == nil || array.count < 2) {
        return;
    }
    
    for (int i = 1; i < array.count; i++)
    {
        // 待插入元素
        NSInteger temp = [array[i] integerValue];
        NSInteger j;
        for (j = i - 1; j >= 0; j--)
        {
            // 将大于temp的往后移动一位
            if ([array[j] integerValue] > temp)
            {
                array[j + 1] = array[j];
            }
            else
            {
                break;
            }
        }
        array[j + 1] = [NSNumber numberWithInteger:temp];
    }
}

/*
 * 快速排序
 * 思路：左右两个标记位分别对挑选出的参考数进行比较，然后再采用分制的处理方式对对每一次的排序结果在进行排序
 * 直到不能再划分为止
 */
+ (void)quickSort:(NSMutableArray<NSNumber *> *)array low:(NSInteger)low high:(NSInteger)high
{
    if (array == nil || array.count < 2) {
        return;
    }
    
    if (low < high) {
        NSInteger index = [SortTool getIndexWithQuickSort:array low:low high:high];
        [SortTool quickSort:array low:0 high:index - 1];
        [SortTool quickSort:array low:index + 1 high:high];
    }
}

+ (NSInteger)getIndexWithQuickSort:(NSMutableArray<NSNumber *> *)array low:(NSInteger)low high:(NSInteger
                                                                                                )high
{
    NSInteger baseNum = [[array objectAtIndex:low] integerValue];
    
    while (low < high) {
        while ([array[high] integerValue] > baseNum && low < high) {
            high--;
        }
        array[low] = array[high];
        
        while ([array[low] integerValue] < baseNum && low < high) {
            low++;
        }
        array[high] = array[low];
    }
    
    // low 和 high值相等
    array[low] = [NSNumber numberWithInteger:baseNum];
    
    return low;
}

@end
