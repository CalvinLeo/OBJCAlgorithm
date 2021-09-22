//
//  LinkCommon.swift
//  Arthmetic
//
//  Created by zx on 2021/9/22.
//  Copyright © 2021 Calvin. All rights reserved.
//

import Foundation

class listNode: NSObject {
    var value: Int?
    var next: listNode?
    
    convenience init(val: Int?, next: listNode?) {
        self.init()
        self.value = val
        self.next = next
    }
}

/// 树节点
public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

class LinkCommon: NSObject {
    
    /// 遍历
    @objc func traverse(head: listNode?) {
        var p = head
        while p != nil {
            print("value的值为：\(String(describing: p?.value))")
            p = p?.next
        }
    }
    
    func traverseRecursion(head: listNode?) {
        if head == nil {
            return
        }
        print("value的值为：\(String(describing: head?.value))")
        self.traverseRecursion(head: head?.next)
    }
    
    /// 给你两棵二叉树的根节点 p 和 q ，编写一个函数来检验这两棵树是否相同。
    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        
        if p == nil && q == nil {
            return true
        } else if p == nil || q == nil {
            return false
        } else if p?.val != q?.val {
            return false
        } else {
            return isSameTree(p?.left, q?.left) && isSameTree(p?.right, q?.right)
        }
    }
    
    /// 判断二叉树是否对称
    func isSymmetric(root: TreeNode?) -> Bool {
        return check(p: root, q: root)
    }
    
    func check(p: TreeNode?, q: TreeNode?) -> Bool {
        if p == nil && q == nil {
            return true
        } else if (p == nil || q == nil) {
            return false
        } else {
            return p?.val == q?.val && check(p: p?.right, q: q?.left) && check(p: p?.left, q: q?.right)
        }
    }
    
    /// 二叉树的深度
    func maxDepth(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        return max(maxDepth(root?.left), maxDepth(root?.right)) + 1
    }
}
