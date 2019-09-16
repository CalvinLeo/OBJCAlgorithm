//
//  BinaryTreeNode.m
//  Arthmetic
//
//  Created by Calvin's Macbook Pro on 2019/9/16.
//  Copyright © 2019 Calvin. All rights reserved.
//

#import "BinaryTreeNode.h"

@implementation BinaryTreeNode

+ (instancetype)createNodeWithValue:(NSInteger)value leftNode:(BinaryTreeNode *)leftNode rightNode:(BinaryTreeNode *)rightNode {
    BinaryTreeNode *node = [[BinaryTreeNode alloc] init];
    node.value = value;
    node.leftNode = leftNode;
    node.rightNode = rightNode;
    return node;
}

@end
