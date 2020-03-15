//
//  AppDelegate.m
//  uiTabBarController
//
//  Created by wei cui on 2019/11/27.
//  Copyright © 2019 wei cui. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //通过代码使用一个控制器
    //干掉 Main
    //1创建窗口
    self.window=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor purpleColor];
    //2设置窗口跟控制器
    UITabBarController *tabBarVc=[[UITabBarController alloc] init];
    self.window.rootViewController=tabBarVc;
    //3显示窗口
    [self.window makeKeyAndVisible];
    
    //添加子控制器
    UIViewController *home=[[UIViewController alloc] init];
    home.view.backgroundColor=[UIColor redColor];
    home.tabBarItem.title=@"HOME";
    home.tabBarItem.image=[UIImage imageNamed:@"footer_home"];
    //home.tabBarItem.badgeValue=@"100";//消息数量红点
    [tabBarVc addChildViewController:home];
    
    UIViewController *php=[[UIViewController alloc] init];
    php.view.backgroundColor=[UIColor yellowColor];
    php.tabBarItem.title=@"PHP";
    php.tabBarItem.image=[UIImage imageNamed:@"footer_php"];
    [tabBarVc addChildViewController:php];
    
    UIViewController *linux=[[UIViewController alloc] init];
    linux.view.backgroundColor=[UIColor yellowColor];
    linux.tabBarItem.title=@"LINUX";
    linux.tabBarItem.image=[UIImage imageNamed:@"footer_linux"];
    [tabBarVc addChildViewController:linux];
    
    UIViewController *seach=[[UIViewController alloc] init];
    seach.view.backgroundColor=[UIColor yellowColor];
    seach.tabBarItem.title=@"搜索";
    seach.tabBarItem.image=[UIImage imageNamed:@"footer_search"];
    [tabBarVc addChildViewController:seach];
    //seach.hidesBottomBarWhenPushed=YES;//隐藏下边的tabBar
    return YES;
}

@end
