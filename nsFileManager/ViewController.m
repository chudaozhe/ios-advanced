//
//  ViewController.m
//  nsFileManager
//
//  Created by wei cui on 2020/4/19.
//  Copyright © 2020 wei cui. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //NSFileManager *fileManager = [NSFileManager defaultManager];
    //[fileManager createFileAtPath:@"/Users/cuiw/Downloads/img_thubm2.jpg" contents:myImageData attributes:nil];
    
    UIImage *img=[UIImage imageNamed:@"img_thubm2"];
    NSData *imgData= UIImageJPEGRepresentation(img, 0.6);
    NSLog(@"%zd", [imgData length]);
    
    //uiimage大小
}

@end
