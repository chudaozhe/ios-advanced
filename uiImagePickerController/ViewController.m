//
//  ViewController.m
//  uiImagePickerController
//  图片，视频的选择
//  参考 https://blog.csdn.net/mango_ios/article/details/52913835
//  Created by wei cui on 2020/2/25.
//  Copyright © 2020 wei cui. All rights reserved.
//

#import "ViewController.h"
#import "SZAddImage.h"

@interface ViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property  (nonatomic, strong)UIImageView *avatarImageView; //
@end

@implementation ViewController
#pragma mark 视图已经加入到窗口时
- (void)viewDidLoad {
    [super viewDidLoad];
    //一个demo
    SZAddImage *addImg= [[SZAddImage alloc] init];
    addImg.frame=CGRectMake(0, 100, 400, 600);
    addImg.backgroundColor=[UIColor redColor];
    [self.view addSubview:addImg];
    /*
    //添加一个按钮
    [self addButton];
    //圆角头像
    [self avatarView];
     */
}
-(void)addButton{
    UIButton *button = [[UIButton alloc]init];
    button.frame = CGRectMake(110, 250, 50, 50);
    [button setBackgroundImage:[UIImage imageNamed:@"jiahao"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(selectImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
-(void)avatarView{
    self.avatarImageView = [[UIImageView alloc]init];
    self.avatarImageView.frame = CGRectMake(100, 80, 80, 80);
    self.avatarImageView.backgroundColor = [UIColor blackColor];
    self.avatarImageView.layer.masksToBounds = YES;
    self.avatarImageView.layer.cornerRadius = CGRectGetHeight(self.avatarImageView.bounds) / 2;
    self.avatarImageView.layer.borderWidth = 2.0f;
    self.avatarImageView.layer.borderColor = [[UIColor lightGrayColor]CGColor];

    [self.view addSubview:self.avatarImageView];
}
#pragma mark 视图即将加入窗口时
- (void)viewWillAppear:(BOOL)animated{
    // 获取存放在NSUserDefaults里面的图片
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"avatar"];
    UIImage *img;
    if (data == nil) {
        //占位图
        img=[UIImage imageNamed:@"user"];
    } else{
        img=[UIImage imageWithData:data];
    }
    self.avatarImageView.image=img;
    [self.view addSubview:self.avatarImageView];
}


//选择图片并显示
- (IBAction)selectImage:(UIButton *)sender {
    //UIImagePickerControllerSourceTypePhotoLibrary 相册
    //UIImagePickerControllerSourceTypeCamera 相机
    //UIImagePickerControllerSourceTypeSavedPhotosAlbum 时刻
    //创建图片选择器
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    //设置来源类型
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    imagePicker.mediaTypes = @[@"public.image", @"public.movie"];
    //设置代理
    imagePicker.delegate = self;
    //模态弹出相册
    [self presentViewController:imagePicker animated:YES completion:nil];

}
//从相册中选择视频并播放
- (IBAction)selectVideo:(UIButton *)sender {
    UIImagePickerController *videoPicker = [[UIImagePickerController alloc] init];
    videoPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //设置媒体类型：照片public.image或视频public.movie
    videoPicker.mediaTypes = @[@"public.movie"];
    videoPicker.delegate = self;

    [self presentViewController:videoPicker animated:YES completion:nil];
}
// 媒体选取完成后调用的代理方法，info字典中包含了很多数据
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    //判断是照片or视频
    if ([mediaType isEqualToString:@"public.image"]) {
        UIImage *image = info[UIImagePickerControllerOriginalImage];//UIImagePickerControllerEditedImage
        [self saveImage:image withNamge:@"avatar.jpg"];
    }else if ([mediaType isEqualToString:@"public.movie"]){
        NSURL *movieURL = info[UIImagePickerControllerMediaURL];
        NSLog(@"movieURL:%@", movieURL);
        //这里通过视频的url可以做很多事情，比如转化成NSData数据保存、上传等等，不赘述！
        //movieURL:
        //file:///private/var/mobile/Containers/Data/PluginKitPlugin/217237E0-911E-4518-A390-BDC79E8F9137/tmp/trim.72BEBAE9-9399-47EC-B41E-4402B62183F4.MOV
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
//取消按钮的代理方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    NSLog(@"--------图片选择取消");
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 把图片保存到临时目录
 [NSUserDefaults standardUserDefaults] 偏好设置：应该不适合存这里
 */
- (void)saveImage:(UIImage *)tempImage withNamge:(NSString *)imageName{
    NSData *imageData = UIImagePNGRepresentation(tempImage);
    // 获取路径
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 拼接路径
    NSString *totalPath = [documentPath stringByAppendingString:[NSString stringWithFormat:@"/%@", imageName]];
    // 保存到document
    [imageData writeToFile:totalPath atomically:YES];
    NSLog(@"document --- %@", totalPath);
    [self.avatarImageView setImage:[self getImage:totalPath]];

    // 保存到NSUserDefaults
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:imageData forKey:@"avatar"];

    #pragma mark 上传服务器
}

// 从document取得图片
- (UIImage *)getImage:(NSString *)urlStr{
    return [UIImage imageWithContentsOfFile:urlStr];
}

@end
