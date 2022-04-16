//
//  NotifyPoster.m
//  nsNotification
//
//  Created by wei cui on 2020/4/5.
//  Copyright © 2020 wei cui. All rights reserved.
//

#import "NotifyPoster.h"

@implementation NotifyPoster
/*!
 * @brief 发送通知BYNotificationTest
 */
- (void)postNotification
{
    NSLog(@"准备发送通知 - BYNotificationTest");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BYNotificationTest" object:nil];
    NSLog(@"BYNotificationTest - 通知发送完毕，继续往下执行");
    // TODO:发送通知完毕后，继续执行
}

@end
