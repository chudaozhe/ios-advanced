//
//  ImageCell.m
//  uiCollectionView
//
//  Created by wei cui on 2020/1/4.
//  Copyright © 2020 wei cui. All rights reserved.
//

#import "ImageCell.h"

@interface ImageCell()

/** 不需要对外暴露的写在.m文件 */
@property (strong, nonatomic) UIImageView *imageView;
@end

@implementation ImageCell

-(UIImageView *)imageView
{
    if (_imageView == nil) {
        UIImageView *imageV=[[UIImageView alloc] initWithFrame:self.bounds];
        _imageView=imageV;
        [self.contentView addSubview:imageV];
    }
    return _imageView;
}
-(void)setImage:(UIImage *)image
{
    _image=image;
    self.imageView.image=image;
}
@end
