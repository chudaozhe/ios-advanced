//
//  ViewController.m
//  nsNotification
//
//  Created by wei cui on 2020/4/5.
//  Copyright © 2020 wei cui. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "NotifyReceiver.h"
#import "NotifyPoster.h"

@interface ViewController ()
/** 备注 */
@property (strong, nonatomic) Person *p1;
@property (strong, nonatomic) Person *p2;
@property (strong, nonatomic) Person *p3;
/** 备注 */
@property (strong, nonatomic) NotifyPoster *poster;
@end

@implementation ViewController
-(instancetype)init{
self = [super init];
//重新加载界面
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadController) name:@"ViewControllerShouldReloadNotification" object:nil];
return self;
}
-(void)reloadController{
NSArray *viewsToRemove = [self.view subviews];
for (UIView *v in viewsToRemove) {
    [v removeFromSuperview];
}

//[self setUpType];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //接收通知（TestNotify，收到后执行p1 的test方法
    //[[NSNotificationCenter defaultCenter] addObserver:self.p1 selector:@selector(test) name:@"TestNotify" object:nil];//匿名

    //我发的通知（TestNotify
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"TestNotify" object:nil];
    
    self.poster= [[NotifyPoster alloc] init];
 
    NSLog(@"------------主线程发送通知---------------");
    [self.poster postNotification];
    
    sleep(5);//延迟五秒
    
    NSLog(@"------------异步线程发送通知--------------");
     __weak typeof(self) weakSelf = self;
    dispatch_queue_t queue = dispatch_queue_create("NOTIFICATION_TEST_QUEUE", NULL);
    dispatch_async(queue, ^{
        [weakSelf.poster postNotification];
    });
}

@end
