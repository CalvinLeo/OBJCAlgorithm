//
//  数据结构队列
//
//  Created by Calvin's Macbook Pro on 2019/9/16.
//  Copyright © 2019 Calvin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLQueue : NSObject

@property (nonatomic, assign) BOOL isEmpty;

- (instancetype)initWithCapacity:(NSInteger)capacity;

- (void)queuePush:(id)object;

- (id)queuePop;

@end

NS_ASSUME_NONNULL_END
