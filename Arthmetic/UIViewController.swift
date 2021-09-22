//
//  UIViewController.swift
//  Arthmetic
//
//  Created by zx on 2021/9/22.
//  Copyright © 2021 Calvin. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("CustomViewController")
        linkListTraverse()
    }
    
    /// 链表
    func linkListTraverse() {
        let link = LinkCommon()
        
        let three = listNode(val: 3, next: nil)
        let two = listNode(val: 2, next: three)
        let one = listNode(val: 1, next: two)
        let head = listNode(val: 1, next: one)
        link.traverse(head: head)
        link.traverseRecursion(head: head)
    }
}
