//
//  ViewController.m
//  2application
//
//  Created by wei cui on 2019/11/19.
//  Copyright © 2019 wei cui. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
//3打开外部链接
- (IBAction)openUri:(id)sender {
    NSURL *url=[NSURL URLWithString:@"http://baidu.com"];
    [[UIApplication sharedApplication] openURL:url];
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor=[UIColor redColor];
    
    // Do any additional setup after loading the view.
    //1.app提醒
    UIApplication *app=[UIApplication sharedApplication];
    //通知个数
    app.applicationIconBadgeNumber=10;
    //创建用户通知
    UIUserNotificationSettings *settings=[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    //注册用户通知
    [app registerUserNotificationSettings:settings];
    
    //2.联网状态
    app.networkActivityIndicatorVisible=YES;
}


@end
