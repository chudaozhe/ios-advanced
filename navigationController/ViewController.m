//
//  ViewController.m
//  navigationController
//
//  Created by wei cui on 2019/11/21.
//  Copyright © 2019 wei cui. All rights reserved.
//

#import "ViewController.h"
#import <SDWebImage/SDWebImage.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *imgView=[[UIImageView alloc] init];
    imgView.frame=CGRectMake(0, 0, 100, 100);
    NSURL *url=[NSURL URLWithString:@"https://www.baidu.com/img/bd_logo1.png?where=super"];
    //[imgView sd_setImageWithURL:url];
    [imgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"php"]];//php.png占位图片
    [self.view addSubview:imgView];
    
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 20)];
    cancelButton.titleLabel.textColor = [UIColor greenColor];
    cancelButton.titleLabel.text = @"取消";
    [cancelButton setTitle:@"取消x" forState:UIControlStateNormal];
    cancelButton.frame=CGRectMake(0, 0, 100, 200);
    cancelButton.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:cancelButton];
}


@end
