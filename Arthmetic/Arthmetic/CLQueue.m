//
//  CLQueue.m
//  Arthmetic
//
//  Created by Calvin's Macbook Pro on 2019/9/16.
//  Copyright © 2019 Calvin. All rights reserved.
//

#import "CLQueue.h"

@interface CLQueue ()

@property (nonatomic, strong) NSMutableArray *queueArray;

@end

@implementation CLQueue

- (instancetype)initWithCapacity:(NSInteger)capacity
{
    self = [super init];
    if (self) {
        self.queueArray = [NSMutableArray arrayWithCapacity:capacity];
    }
    return self;
}

- (void)queuePush:(id)object {
    if (object != nil) {
        [self.queueArray addObject:object];
    }
    else {
        NSLog(@"You can't push nil object to queue");
    }
}

- (id)queuePop {
    if (self.queueArray.count > 0) {
        id object = [self.queueArray objectAtIndex:0];
        [self.queueArray removeObjectAtIndex:0];
        return object;
    }
    return nil;
}

@end
