//
//  ViewController.m
//  uiCollectionView
//
//  Created by wei cui on 2020/1/3.
//  Copyright © 2020 wei cui. All rights reserved.
//

#import "ViewController.h"
#import "ImageCell.h"
@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
/** 最后的x偏移量 */
@property (assign, nonatomic) CGFloat lastOffsetX;
/** 备注 */
@property (weak, nonatomic) UIImageView *guideView;
@property (weak, nonatomic) UIImageView *guideLargetView;
@property (weak, nonatomic) UIImageView *guideSmallView;
@end

@implementation ViewController

static NSString * const ID = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    [self.collectionView registerClass:[ImageCell class] forCellWithReuseIdentifier:ID];
    //基本的流水布局
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    //设置cell的尺寸
    //layout.itemSize=CGSizeMake(180, 180);
    layout.itemSize=CWScreenBounds.size;
    //设置行距
    layout.minimumLineSpacing=0;
    //设置cell之间间距
    layout.minimumInteritemSpacing=0;
    //每组的内间距
    //layout.sectionInset=UIEdgeInsetsMake(0, 10, 0, 10);
    
    //水平滚动
    layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    self.collectionView.collectionViewLayout=layout;
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    
    self.collectionView.bounces=NO;//弹簧效果
    self.collectionView.showsHorizontalScrollIndicator=NO;//水滚动条
    self.collectionView.pagingEnabled=YES;//分页
    
    [self setUpAllChildView];
}
//添加所有子控件
-(void)setUpAllChildView
{
    //guidel 球
    UIImageView *guide=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guide1"]];
    guide.centetX=self.view.centetX;//居中
    _guideView=guide;
    [self.collectionView addSubview:guide];
    //guideLine 蜿蜒起伏的线条
    UIImageView *guideLine=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guideLine"]];
    guideLine.x-=150;
    [self.collectionView addSubview:guideLine];
    //largerText 文字：疯狂竞技长
    UIImageView *largerText=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guideLargeText1"]];
    largerText.centetX=self.view.centetX;//居中
    largerText.centetY=self.view.height*0.7;
    _guideLargetView=largerText;
    [self.collectionView addSubview:largerText];
    //smallText 小字：中奖更容易，活动更丰富
    UIImageView *smallText=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guideSmallText1"]];
    smallText.centetX=self.view.centetX;//居中
    smallText.centetY=self.view.height*0.8;
    _guideSmallView=smallText;
    [self.collectionView addSubview:smallText];
}
//减速完成
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //获取当前x的偏移量
    CGFloat curOffsetX=scrollView.contentOffset.x;
    NSLog(@"%f--%f", curOffsetX, _lastOffsetX);
    //获取差值
    CGFloat delta=curOffsetX-_lastOffsetX;
    //往左边滑动，图片有 从右往左动画
    _guideView.x+=2*delta;
    _guideLargetView.x=2*delta;
    _guideSmallView.x=2*delta;
    //往右边滑动，图片有 从左往右动画
    //_lastOffsetX=curOffsetX;
    [UIView animateWithDuration:0.25 animations:^{
        //往左边滑动，图片有 从右往左动画
        _guideView.x-=delta;
        _guideLargetView.x-=delta;
        _guideSmallView.x-=delta;
    }];
    int page=curOffsetX/self.view.width+1;
    //修改控件内容
    _guideView.image=[UIImage imageNamed:[NSString stringWithFormat:@"guide%d", page]];
    _guideLargetView.image=[UIImage imageNamed:[NSString stringWithFormat:@"guideLargeText%d", page]];
    _guideSmallView.image=[UIImage imageNamed:[NSString stringWithFormat:@"guideSmallText%d", page]];
    NSLog(@"减速完成");
}
//1组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每组4个
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}
//每个cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSLog(@"row:%zd", indexPath.item+1);
    ImageCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.backgroundColor=[UIColor redColor];
    NSString *img=[NSString stringWithFormat:@"guide%ldBackground", indexPath.item+1];
    cell.image=[UIImage imageNamed: img];
    return cell;

}

@end
