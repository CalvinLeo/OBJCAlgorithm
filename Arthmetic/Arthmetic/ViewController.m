//
//  ViewController.m
//  Arthmetic
//
//  Created by Mr Gao on 2019/5/21.
//  Copyright © 2019年 Calvin. All rights reserved.
//

#import "ViewController.h"

#import "Arthmetic.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSInteger index = [Arthmetic binarySortWithArray:@[@1, @3, @4, @5, @7, @9, @23] value:2];
    NSLog(@"index 在数组中的位置是：%ld", (long)index);
    
    NSMutableArray *bubbleArray = [NSMutableArray arrayWithObjects:@6, @4, @1, @7, @9, @2, @3, nil];
//    [Arthmetic bubbleAscendingSort:bubbleArray];
    [Arthmetic bubbleDescendingSort:bubbleArray];
    NSLog(@"冒泡排序结果：%@", bubbleArray);
}


@end
