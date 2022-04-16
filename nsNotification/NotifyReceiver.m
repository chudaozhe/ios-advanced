//
//  NotifyReceiver.m
//  nsNotification
//
//  Created by wei cui on 2020/4/5.
//  Copyright © 2020 wei cui. All rights reserved.
//

#import "NotifyReceiver.h"

@implementation NotifyReceiver
- (instancetype)init{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"BYNotificationTest" object:nil];
    }
    return self;
}

/*!
 * @brief   接收通知(BYNotificationTest)
 * @param   note NSNotification通知对象
 */
- (void)handleNotification:(NSNotification *)note
{
    if ([[NSThread currentThread] isMainThread]) {
        NSLog(@"接收到通知 - BYNotificationTest，主线程，开始处理相关逻辑");
    } else {
        NSLog(@"接收到通知 - BYNotificationTest，异步线程，开始处理相关逻辑");
    }
}

- (void)dealloc{
    NSLog(@"注销通知");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"BYNotificationTest" object:nil];
}
@end
