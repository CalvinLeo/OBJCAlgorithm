//
//  BinaryTreeNode.h
//  Arthmetic
//
//  Created by Calvin's Macbook Pro on 2019/9/16.
//  Copyright © 2019 Calvin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BinaryTreeNode : NSObject

@property (nonatomic, assign) NSInteger value;
@property (nonatomic, strong, nullable) BinaryTreeNode *leftNode;
@property (nonatomic, strong, nullable) BinaryTreeNode *rightNode;

+ (instancetype)createNodeWithValue:(NSInteger)value leftNode:(BinaryTreeNode * _Nullable)leftNode rightNode:(BinaryTreeNode * _Nullable)rightNode;

@end

NS_ASSUME_NONNULL_END
