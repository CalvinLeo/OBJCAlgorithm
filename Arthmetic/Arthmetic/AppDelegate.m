//
//  AppDelegate.m
//  Arthmetic
//
//  Created by Mr Gao on 2019/5/21.
//  Copyright © 2019年 Calvin. All rights reserved.
//

#import "AppDelegate.h"

#import "BinaryTreeTool.h"
#import "SortTool.h"    // 排序
#import "CLQueue.h"     // 队列

#import "Person.h"      // 模型
#import "BinaryTreeNode.h" // 二叉树节点

#import "Arthmetic-Swift.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)descriptorHandle {
    Person *one = [Person modelWithName:@"Allen" birthDay:@"1992-01-01"];
    Person *two = [Person modelWithName:@"Bob" birthDay:@"1991-01-30"];
    Person *three = [Person modelWithName:@"Alice" birthDay:@"1992-03-23"];
    Person *four = [Person modelWithName:@"Cindy" birthDay:@"1995-06-22"];
    Person *five = [Person modelWithName:@"Davin" birthDay:@"1986-09-11"];
    Person *six = [Person modelWithName:@"Calvin" birthDay:@"1990-07-31"];
    Person *seven = [Person modelWithName:@"Serena" birthDay:@"1997-01-30"];
    NSArray *persons = @[one, two, three, four, five, six, seven];
    
    NSSortDescriptor *nameDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    NSSortDescriptor *dateDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"birthDay" ascending:YES];
    NSArray *newArr = [persons sortedArrayUsingDescriptors:@[nameDescriptor, dateDescriptor]];
    
    for (Person *p in newArr) {
        NSLog(@"p:%@", p.birthDay);
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    NSInteger index = [SortTool binarySortWithArray:@[@1, @3, @4, @5, @7, @9, @23] value:2];
//    NSLog(@"index 在数组中的位置是：%ld", (long)index);
//
//    NSMutableArray *arrayM = [NSMutableArray arrayWithObjects:@6, @4, @1, @7, @9, @2, @3, nil];
//    [SortTool bubbleAscendingSort:arrayM];
//    [SortTool bubbleDescendingSort:arrayM];
//    NSLog(@"冒泡排序结果：%@", arrayM);
    
//    [SortTool selectSort:arrayM];
//    NSLog(@"选择排序结果为：%@", arrayM);
    
//    [SortTool insertionSort:arrayM];
//    NSLog(@"插入排序结果：%@", arrayM);
//    [SortTool quickSort:arrayM low:0 high:arrayM.count - 1];
//    NSLog(@"快速排序结果：%@", arrayM);
    
    // 苹果自带排序
//    [self descriptorHandle];
    
    BinaryTreeTool *biTool = [[BinaryTreeTool alloc] init];
    BinaryTreeNode *rootNode = [biTool createBinaryTreeWithArray:@[@10, @50, @20, @22, @28, @33, @43, @53, @51, @15, @18, @21, @25, @23, @24]];
    // 先序遍历
    [biTool preOrderTraverse:rootNode];
    BinaryTreeNode *node = rootNode.rightNode;
    
    [biTool deleteNode:node];
    
    NSLog(@"---------------------------------------");
    
    Sort *sort = [[Sort alloc] init];
    [sort threeFlagsSortSwift];
    
    // 先序遍历
//    [biTool preOrderTraverse:rootNode];


//    // 中序遍历
//    [biTool inOrderTraverse:rootNode];
//
//    // 后序遍历
//    [biTool backOrderTraverse:rootNode];
    
    // 层次遍历
//    NSArray *array = [biTool levelTraverse:rootNode];
//    for (NSNumber *number in array) {
//        NSLog(@"层次遍历：%@", number);
//    }
    
    return YES;
}

- (void)deleteObject:(NSObject *)obj1 obj2:(NSObject *)obj2 {
    NSObject *obj3 = [NSObject new];
    obj1 = obj3;
    obj2 = obj3;
    NSLog(@"deleteObject-------obj1:%p----------obj2:%p", &obj1, &obj2);
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
