//
//  Sort.swift
//  Arthmetic
//
//  Created by Calvin Gao on 2021/4/20.
//  Copyright © 2021 Calvin. All rights reserved.
//

import UIKit

@objcMembers public class Sort: NSObject {
    
    /// 交换
    public static func swap(array: inout [Int], a: Int, b: Int) {
        (array[a], array[b]) = (array[b], array[a])
    }
    
    /// 三色旗排序 swift 版本
    @objc func threeFlagsSortSwift() {
        var array = [1, 0, 0, 1, 2, 0, 2, 2, 0, 1, 0]
        threeFlagsSort(array: &array, left: 0, right: array.count - 1, pivot: 0)
        print("排序后的数组为：\(array)")
    }
    
    /// 三色旗排序
    func threeFlagsSort(array: inout [Int], left: Int, right: Int, pivot: Int) {
        
        if (left >= right) {return}
        
        let index = partition(array: &array, left: left, right: right, pivot: pivot)
//        thirdFlagsSort(array: &array, left: 0, right: index - 1, pivot: pivot)
        threeFlagsSort(array: &array, left: index + 1, right: right, pivot: pivot + 1)
    }
    
    /// 排序和分半
    func partition(array: inout[Int], left: Int, right: Int, pivot: Int) -> Int {
        var low = left
        var high = right
        while low < high {
            while (array[high] > pivot && low < high) {
                high -= 1
            }
            
            while (array[low] <= pivot && low < high) {
                low += 1
            }
            
            if (low < high) {Sort.swap(array:&array, a:low, b:high)}
        }
        return low
    }
}
