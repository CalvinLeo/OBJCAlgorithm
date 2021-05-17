//
//  Sort.swift
//  Arthmetic
//
//  Created by Calvin Gao on 2021/4/20.
//  Copyright © 2021 Calvin. All rights reserved.
//

import UIKit

@objcMembers public class Sort: NSObject {
    
    @objc func logsomeThing() {
        print("SortClass")
    }
    
    public static func swap(array: inout [Int], a: Int, b: Int) {
        (array[a], array[b]) = (array[b], array[a])
    }
    
    @objc func quickSort(array: NSMutableArray, left: Int, right: Int, pivot: Int) {
        var temp = array as! [Int]
        threeFlagsSort(array: &temp, left: left, right: right, pivot: pivot)
    }
    
    func threeFlagsSort(array: inout [Int], left: Int, right: Int, pivot: Int) {
        
        let index = partition(array: &array, left: left, right: right, pivot: pivot)
//        thirdFlagsSort(array: &array, left: 0, right: index - 1, pivot: pivot)
        threeFlagsSort(array: &array, left: index + 1, right: right, pivot: pivot + 1)
    }
    
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
