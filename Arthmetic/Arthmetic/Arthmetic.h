//
//  Arthmetic.h
//  Arthmetic
//
//  Created by Mr Gao on 2019/5/21.
//  Copyright © 2019年 Calvin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Arthmetic : NSObject

/**
 * 二分查找法
 * 时间复杂度 O(logN)
 */
+ (NSInteger)binarySortWithArray:(NSArray<NSNumber *> *)array value:(NSInteger)value;

/*
 * 冒泡排序
 * 时间复杂度 O(n²)
 */
+ (void)bubbleAscendingSort:(NSMutableArray<NSNumber *> *)array;

/*
 * 冒泡降序排序
 * 时间复杂度 O(n²)
 */
+ (void)bubbleDescendingSort:(NSMutableArray<NSNumber *> *)array;

@end

NS_ASSUME_NONNULL_END
