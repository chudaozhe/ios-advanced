//
//  ViewController.m
//  SegmentedControl
//
//  Created by wei cui on 2020/9/23.
//  Copyright © 2020 wei cui. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic) UISegmentedControl *segmentedControl;
@property (strong, nonatomic) UIPageControl *pageControl;
/** 备注 */
@property (strong, nonatomic) UIScrollView *scrollView;
/** 备注 */
@property (strong, nonatomic) NSArray *images;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.images=@[@"1", @"2", @"3", @"4"];
    /*     */
    [self.view addSubview:self.scrollView];
    for (int i =0; i<_images.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[_images objectAtIndex:i]]];
//        NSLog(@"%@",[NSString stringWithFormat:@"%d.jpeg",i]);
        imageView.frame = CGRectMake(i*_scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
        [_scrollView addSubview:imageView];
    }

    [self.view addSubview:self.segmentedControl];
    [self.view addSubview:self.pageControl];
}
-(UIScrollView *)scrollView{
    if (nil==_scrollView) {
        _scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(50, 160, 300, 130)];
        _scrollView.backgroundColor = [UIColor greenColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;//水平滚动条
        _scrollView.showsVerticalScrollIndicator = NO;//垂直滚动条
        _scrollView.contentSize=CGSizeMake(_scrollView.frame.size.width*_images.count, _scrollView.frame.size.height);
        _scrollView.delegate = self;
    }
    return _scrollView;
}
//https://www.cnblogs.com/XYQ-208910/p/4850529.html
#pragma mark 分段控件
-(UISegmentedControl *)segmentedControl{
    if (nil==_segmentedControl) {
        NSArray *items=@[@"图片", @"视频"];
        NSArray *items2=@[[UIImage imageNamed:@"faxian2"], [UIImage imageNamed:@"shoucang2"], @"123"];
        _segmentedControl=[[UISegmentedControl alloc] initWithItems:items2];
        _segmentedControl.frame=CGRectMake(60, 100, 200, 30);
        _segmentedControl.selectedSegmentIndex=0;//默认选中第1个
        
        //_segmentedControl.selectedSegmentTintColor=[UIColor orangeColor];
        //动态添加item
        [_segmentedControl insertSegmentWithTitle:@"456" atIndex:1 animated:YES];
        //添加事件
        [_segmentedControl addTarget:self action:@selector(doIt:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentedControl;
}
//https://www.cnblogs.com/XYQ-208910/p/4850281.html
#pragma mark 分页控件
-(UIPageControl *)pageControl{
    if (nil==_pageControl) {
        _pageControl= [[UIPageControl alloc] initWithFrame:CGRectMake(170, CGRectGetMaxY(_scrollView.frame)-20, 160, 20)];
        _pageControl.numberOfPages=_images.count;
        _pageControl.currentPage=0;
        _pageControl.pageIndicatorTintColor=[UIColor grayColor];
        _pageControl.backgroundColor=[UIColor greenColor];
        _pageControl.hidesForSinglePage=YES;//只有一页时隐藏
        [_pageControl addTarget:self action:@selector(pageControlClicked:) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
}
/**
 * pageControl点击方法
 * 点结时改变对应的scrollView
 * scrollRectToVisible和setContentOffset的区别？
 * UIPageControl点击小圆点跳转到对应位置? 默认只能一个一个跳
 */
-(void)pageControlClicked:(UIPageControl *)sender{
    NSLog(@"index:%ld",sender.currentPage);
    NSLog(@"index2:%ld",_pageControl.currentPage);
    [_scrollView scrollRectToVisible:CGRectMake(_pageControl.currentPage*self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height) animated:YES];
}
#pragma mark---scrollViewDelegate
//scrollView改变时同时改变pageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat pageWidth=self.scrollView.frame.size.width;
    //根据当前的x坐标和页宽度计算出当前页数
    int page = ceil((scrollView.contentOffset.x-pageWidth/2)/pageWidth);//ceil向上取整
    NSLog(@"page=%i", page);
    [_scrollView scrollRectToVisible:CGRectMake(page*self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height) animated:YES];
    _pageControl.currentPage = page;
}
-(void)doIt:(UISegmentedControl *)sender{
    NSLog(@"index:%ld",sender.selectedSegmentIndex);
}

@end
