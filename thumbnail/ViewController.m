//
//  ViewController.m
//  thumbnail
//
//  Created by wei cui on 2020/4/18.
//  Copyright © 2020 wei cui. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
/** 备注 */
@property (strong, nonatomic) NSMutableArray *photo;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImage *img=[UIImage imageNamed:@"img"];
    //UIImage *img_thumb= [self OriginImage:img scaleToSize:CGSizeMake(100, 100)];
    UIImage *img_thumb= [self imageByScalingAndCroppingForSize:CGSizeMake(1000, 1000) withSourceImage:img];
    NSData *myImageData = UIImageJPEGRepresentation(img_thumb, 0.6);
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createFileAtPath:@"/Users/cuiwei/Downloads/img_thubm2.jpg" contents:myImageData attributes:nil];
    
}

-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;   //返回的就是已经改变的图片
}
/**
 * 图片压缩到指定大小
 * @param targetSize 目标图片的大小
 * @param sourceImage 源图片
 * @return 目标图片
 */
 - (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize withSourceImage:(UIImage *)sourceImage{
    UIImage *newImage = nil;
     
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
     
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
     
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor > heightFactor){
            scaleFactor = widthFactor; // scale to fit height
        }else{
            scaleFactor = heightFactor; // scale to fit width
        }
        scaledWidth= width * scaleFactor;
        scaledHeight = height * scaleFactor;
        // center the image
        if (widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if (widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width= scaledWidth;
    thumbnailRect.size.height = scaledHeight;

    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
    NSLog(@"could not scale image");

    //pop the context to get back to the default
    UIGraphicsEndImageContext();

    return newImage;
}
@end
