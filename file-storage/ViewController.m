//
//  ViewController.m
//  file-storage
//
//  Created by wei cui on 2019/11/25.
//  Copyright © 2019 wei cui. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self plistSave];
//    [self plistRead];
//
//    [self preferenceSave];
//    [self preferenceRead];
//
    [self nsKeyedArchiverSave];
    [self nsKeyedArchiverRead];
}
//自定义对象归档
-(void)nsKeyedArchiverSave
{
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    
    NSString *filePath=[cachePath stringByAppendingPathComponent:@"person.data"];
    NSLog(@"%@", filePath);
    Person *p=[[Person alloc] init];
    p.name=@"cw";
    p.age=18;
    [NSKeyedArchiver archiveRootObject:p toFile:filePath];
}
-(void)nsKeyedArchiverRead
{
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    
    NSString *filePath=[cachePath stringByAppendingPathComponent:@"person.data"];
    NSLog(@"%@", filePath);
    //解档
    Person *p = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"%@---%zd", p.name, p.age);
}
-(void)preferenceSave
{
    //偏好设置
    //好处：1.不需要关系文件名
    //2.快速做键值对存储
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];//单例，只有一个内存
    [userDefault setObject:@"cw" forKey:@"name"];
    [userDefault setObject:@"cuiwei.net" forKey:@"password"];
    [userDefault setBool:YES forKey:@"rember"];
    
    // 在ios7之前，默认写入缓存，要写入磁盘, 需要另执行
    //[userDefault synchronize];
}
-(void)preferenceRead
{
    NSString *name=[[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
    NSString *password=[[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    NSInteger rember=[[NSUserDefaults standardUserDefaults] boolForKey:@"rember"];
    NSLog(@"%@ --- %@ --- %zd", name, password, rember);
    //所有key
    NSLog(@"%@", [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] allKeys]);
}
-(void)plistSave
{
    NSArray *arr = @[@"123", @1];
    //保存到沙盒的Library/Caches目录下
    NSString *cachePath= NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSLog(@"cachePath：%@", cachePath);
   
    //拼接“/文件名”
    NSString *filePath=[cachePath stringByAppendingPathComponent:@"arr.plist"];
    NSLog(@"filePath：%@", filePath);
    [arr writeToFile:filePath atomically:YES];
}
-(void)plistRead
{
    NSString *cachePath= NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    //文件全路径
    NSString *filePath=[cachePath stringByAppendingPathComponent:@"arr.plist"];
    NSLog(@"%@", filePath);
    NSArray *arr=[NSArray arrayWithContentsOfFile:filePath];
    NSLog(@"%@", arr);
}

@end
