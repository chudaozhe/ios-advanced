//
//  AppDelegate.m
//  keyboard
//
//  Created by wei cui on 2020/3/22.
//  Copyright © 2020 wei cui. All rights reserved.
//

#import "AppDelegate.h"
#import "KeyboardController.h"
#import "Keyboard2Controller.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //跟控制器
    //KeyboardController *vc=[[KeyboardController alloc] init];
    Keyboard2Controller *vc=[[Keyboard2Controller alloc] init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    self.window.rootViewController=nav;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
