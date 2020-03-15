//
//  ViewController.m
//  AVFoundation
//
//  Created by wei cui on 2020/3/6.
//  Copyright © 2020 wei cui. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface ViewController ()
/** 缩略图 */
@property (strong, nonatomic) UIImageView *imgView;
/** 视频url */
@property (strong, nonatomic) NSURL *url;
/** 视频资源 */
@property (strong, nonatomic) AVAsset *set;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.创建url
    self.url=[[NSBundle mainBundle] URLForResource:@"12.mp4" withExtension:nil];
    NSLog(@"%@", self.url);
    //本地视频，获取资源(用于获取视频尺寸)
    self.set=[AVAsset assetWithURL:self.url];//其实是AVURLAsset *set=[AVURLAsset assetWithURL:url]; AVAsset是一个抽象类,不能直接被实例化
    
    //缩略图
    //视频尺寸
    CGSize videoSize=[self videoSize];
    NSLog(@"video width:%f height:%f", videoSize.width, videoSize.height);
    CGFloat width=[UIScreen mainScreen].bounds.size.width-20;
    CGFloat height=(width *videoSize.height)/videoSize.width;
    NSLog(@"box width:%f height:%f", width, height);
    
    self.imgView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 100, width, height)];
    [self.imgView setUserInteractionEnabled:YES];
    [self.view addSubview:self.imgView];
    [self thumbnail];
    //播放按钮
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake((width/2)-32, (height/2)-32, 64, 64)];
    [btn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];

    [btn addTarget:self action:@selector(playVideo) forControlEvents:UIControlEventTouchUpInside];
    //[btn setTitle:@"播放" forState:UIControlStateNormal];
    btn.backgroundColor=[UIColor grayColor];
    [self.imgView addSubview:btn];//缩略图上添加
    
}
#pragma mark 播放视频
-(void)playVideo{
    //2.创建待view的播放器
    AVPlayerViewController *playVC=[[AVPlayerViewController alloc] init];
    //3.player，基本上什么操作都要使用它
    playVC.player=[AVPlayer playerWithURL:self.url];
    //4.播放视频
    [playVC.player play];
    //视频的填充模式
    //AVLayerVideoGravityResizeAspect 是按原视频比例显示，是竖屏的就显示出竖屏的，两边留黑；
    //AVLayerVideoGravityResizeAspectFill 是以原比例拉伸视频，直到两边屏幕都占满，但视频内容有部分就被切割了
    //AVLayerVideoGravityResize 是拉伸视频内容达到边框占满，但不按原比例拉伸，这里明显可以看出宽度被拉伸了。
    playVC.videoGravity = AVLayerVideoGravityResizeAspect;
    //是否显示播放控制条
    playVC.showsPlaybackControls = YES;
    //若想监听视频的操作，设置代理
    //playVC.delegate=self;
    
    //5.展示播放器有两种方式
    //5.1
    //[self showVideoModal:playVC];
    //5.2
    [self showVideoView:playVC];
}
#pragma mark 视频长度(秒)
-(NSInteger)duration{
    CMTime time=[self.set duration];
    int seconds=ceil(time.value/time.timescale);
    NSLog(@"视频长度：%i", seconds);
    return seconds;
}
#pragma mark 展示播放器1:模态对话框,即全屏，不需要frame
-(void)showVideoModal:(AVPlayerViewController *)playVC{
    [self presentViewController:playVC animated:YES completion:nil];
}
#pragma mark 展示播放器2:显示在一个view中，需要frame
-(void)showVideoView:(AVPlayerViewController *)playVC{
    playVC.view.frame=CGRectMake(0, 0, self.imgView.frame.size.width, self.imgView.frame.size.height);
    // 将播放器控制器添加到当前页面控制器中
    [self addChildViewController:playVC];
    // view一定要添加，否则将不显示
    [self.imgView addSubview:playVC.view];
}
#pragma mark 获取视频长宽比
-(CGSize)videoSize{
    NSArray *array = self.set.tracks;
    CGSize videoSize = CGSizeZero;
    for(AVAssetTrack  *track in array){
        if([track.mediaType isEqualToString:AVMediaTypeVideo]){
            videoSize = track.naturalSize;
        }
    }
    return videoSize;
}
#pragma mark 获取视频第一帧
-(void)thumbnail{
    //3.创建图像生成器
    AVAssetImageGenerator *generator=[[AVAssetImageGenerator alloc] initWithAsset:self.set];
    //4.生成图像
    /**
        Times:用来表示影片的时间值
        value:帧数
        timescale:当前视频的每秒帧数
     */
    CMTime time=CMTimeMake(5, 1);//每秒1帧，第5帧
    NSValue *value=[NSValue valueWithCMTime:time];
    [generator generateCGImagesAsynchronouslyForTimes:@[value] completionHandler:^(CMTime requestedTime, CGImageRef  _Nullable image, CMTime actualTime, AVAssetImageGeneratorResult result, NSError * _Nullable error) {
        //注意，一定要回到主线程更新ui
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.imgView.image=[UIImage imageWithCGImage:image];
        });
    }];
}

@end
