//
//  AppDelegate.m
//  2application
//
//  Created by wei cui on 2019/11/19.
//  Copyright © 2019 wei cui. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

//程序启动完成时调用
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSLog(@"%s ：程序启动完成时调用", __func__);
    return YES;
}
//当app进入后台时调用
//app突然被打断的时候，在这里保存一些需要用到的数据
-(void)applicationDidEnterBackground:(UIApplication *)application
{
    NSLog(@"%s ：app进入后台时调用", __func__);
}
//当app获取到焦点的时候调用，意味着app可以交互
-(void)applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"%s ：app获取到焦点的时候调用", __func__);
}
//当app失去焦点时调用
-(void)applicationWillResignActive:(UIApplication *)application
{
    NSLog(@"%s ：当app失去焦点时调用", __func__);
}
//app进入前台
-(void)applicationWillEnterForeground:(UIApplication *)application
{
    NSLog(@"%s ：app进入前台", __func__);
}
//当app关闭时调用
-(void)applicationWillTerminate:(UIApplication *)application
{
    NSLog(@"%s ：app关闭时调用", __func__);
}
//内存警告时调用
-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    NSLog(@"%s ：内存警告时调用", __func__);
}
#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    NSLog(@"%s", __func__);
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}

- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    NSLog(@"%s", __func__);
}


@end
