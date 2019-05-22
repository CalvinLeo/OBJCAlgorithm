//
//  AppDelegate.m
//  Arthmetic
//
//  Created by Mr Gao on 2019/5/21.
//  Copyright © 2019年 Calvin. All rights reserved.
//

#import "AppDelegate.h"

#import "Arthmetic.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    NSInteger index = [Arthmetic binarySortWithArray:@[@1, @3, @4, @5, @7, @9, @23] value:2];
//    NSLog(@"index 在数组中的位置是：%ld", (long)index);
//
    NSMutableArray *arrayM = [NSMutableArray arrayWithObjects:@6, @4, @1, @7, @9, @2, @3, nil];
//    //    [Arthmetic bubbleAscendingSort:bubbleArray];
//    [Arthmetic bubbleDescendingSort:arrayM];
//    NSLog(@"冒泡排序结果：%@", arrayM);
    
//    [Arthmetic selectSort:arrayM];
//    NSLog(@"选择排序结果为：%@", arrayM);
    
    [Arthmetic insertionSort:arrayM];
    NSLog(@"插入排序结果：%@", arrayM);
    
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
