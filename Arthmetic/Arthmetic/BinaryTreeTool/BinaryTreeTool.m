//
//  BinaryTreeTree.m
//  Arthmetic
//
//  Created by Calvin's Macbook Pro on 2019/9/16.
//  Copyright © 2019 Calvin. All rights reserved.
//

#import "BinaryTreeNode.h"

#import "BinaryTreeTool.h"
#import "CLQueue.h"

@interface BinaryTreeTool ()

@property (nonatomic, strong) BinaryTreeNode *rootNode;

@end

@implementation BinaryTreeTool

// 新建二叉树
- (BinaryTreeNode *)createBinaryTreeData {
    BinaryTreeNode *node6 = [BinaryTreeNode createNodeWithValue:38 leftNode:nil rightNode:nil];
    BinaryTreeNode *node5 = [BinaryTreeNode createNodeWithValue:52 leftNode:node6 rightNode:nil];
    BinaryTreeNode *node4 = [BinaryTreeNode createNodeWithValue:13 leftNode:nil rightNode:nil];
    BinaryTreeNode *node3 = [BinaryTreeNode createNodeWithValue:24 leftNode:nil rightNode:nil];
    BinaryTreeNode *node2 = [BinaryTreeNode createNodeWithValue:5 leftNode:node4 rightNode:node5];
    BinaryTreeNode *node1 = [BinaryTreeNode createNodeWithValue:100 leftNode:node2 rightNode:node3];
    return node1;
}

- (BinaryTreeNode *)createBinaryTreeWithArray:(NSArray *)dataArray
{
    if (dataArray.count == 0) {
        return nil;
    }
    
    BinaryTreeNode *rootNode;
    for (int i = 0; i < dataArray.count; i++) {
        NSNumber *number = dataArray[i];
        NSInteger key = number.integerValue;
        rootNode = [self insertNode:rootNode key:key];
    }
    self.rootNode = rootNode;
    return self.rootNode;
}

// 插入
- (BinaryTreeNode *)insertNode:(BinaryTreeNode *)node key:(NSInteger)key {
    if (node == nil) {
        node = [BinaryTreeNode createNodeWithValue:key leftNode:nil rightNode:nil];
        return node;
    }
    
    if (key < node.value) {
        node.leftNode = [self insertNode:node.leftNode key:key];
    }
    else {
        node.rightNode = [self insertNode:node.rightNode key:key];
    }
    return node;
}

// 层次遍历
- (NSArray *)levelTraverse:(BinaryTreeNode *)binaryNode {
    CLQueue *queue = [[CLQueue alloc] initWithCapacity:10];
    // 创建二叉树
//    BinaryTreeNode *treeNode = [self createBinaryTreeData];
    // 将根节点加入二叉树
    [queue queuePush:binaryNode];
    
    // 二叉树节点插入队列，遍历左孩子，右孩子 如果不为空就加入队列
    NSMutableArray *listArray = [NSMutableArray array];
    while (!queue.isEmpty) {
        BinaryTreeNode *currentNode = [queue queuePop];
        [listArray addObject:[NSNumber numberWithInteger:currentNode.value]];
        if (currentNode.leftNode) {
            [queue queuePush:currentNode.leftNode];
        }
        if (currentNode.rightNode) {
            [queue queuePush:currentNode.rightNode];
        }
    }
    return [listArray copy];
}

@end