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

// 层次遍历
- (NSArray *)levelTraverse:(BinaryTreeNode *)binaryNode;

@end

NS_ASSUME_NONNULL_END
