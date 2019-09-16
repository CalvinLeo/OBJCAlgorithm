//
//  AppDelegate.m
//  Arthmetic
//
//  Created by Mr Gao on 2019/5/21.
//  Copyright © 2019年 Calvin. All rights reserved.
//

#import "AppDelegate.h"

#import "SortTool.h"
#import "Person.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)initWithData {
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
    
    [self initWithData];
    
    return YES;
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
