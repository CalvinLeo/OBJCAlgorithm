//
//  BinaryTreeTree.h
//  Arthmetic
//
//  Created by Calvin's Macbook Pro on 2019/9/16.
//  Copyright © 2019 Calvin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BinaryTreeNode;

NS_ASSUME_NONNULL_BEGIN

@interface BinaryTreeTool : NSObject

- (BinaryTreeNode *)createBinaryTreeData;

// 二叉排序树插入排序
- (BinaryTreeNode *)createBinaryTreeWithArray:(NSArray *)dataArray;

// 删除
- (void)deleteNode:(BinaryTreeNode *)tree node:(BinaryTreeNode *)node;

// 先序遍历
- (void)preOrderTraverse:(BinaryTreeNode *)binaryNode;

// 中序遍历
- (void)inOrderTraverse:(BinaryTreeNode *)binaryNode;

// 后序遍历
- (void)backOrderTraverse:(BinaryTreeNode *)binaryNode;

// 层次遍历
- (NSArray *)levelTraverse:(BinaryTreeNode *)binaryNode;

@end

NS_ASSUME_NONNULL_END
