//
//  ViewController.m
//  ui-advanced
//
//  Created by wei cui on 2019/11/19.
//  Copyright © 2019 wei cui. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
//要加载的数据
@property (nonatomic, strong) NSMutableArray *data;
@property (weak, nonatomic) IBOutlet UILabel *shuiguo;
@property (weak, nonatomic) IBOutlet UILabel *zhushi;
@property (weak, nonatomic) IBOutlet UILabel *yinliao;
@end

@implementation ViewController
-(NSMutableArray *)data{
    if (_data==nil) {
          NSBundle *bundle=[NSBundle mainBundle];
          NSString *filepath=[bundle pathForResource:@"foods" ofType:@"plist"];
          //NSLog(@"bundle:%@", filepath);
          NSMutableArray *dict=[NSMutableArray arrayWithContentsOfFile:filepath];
        _data=dict;

    }
    return _data;
}
- (IBAction)random:(id)sender {
    for (int i=0; i<3; i++) {
        NSInteger count=[self.data[i] count];
        //不会触发代理的选择方法
        int random=arc4random_uniform((u_int32_t)count);
        [self.pickerView selectRow:random inComponent:i animated:YES];
        //手动触发选中
        [self pickerView:self.pickerView didSelectRow:random inComponent:i];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self random:self];
}

//几列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.data.count;
}

// 每列数据行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSArray *col=self.data[component];
    return col.count;
}
//代理方法
//每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return 120;
}
//每列行高
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}


//每行内容
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    //第component列 row行
    NSArray *col=self.data[component];
    return col[row];
}
//富文本属性
//- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
//
//}
//用view作为每行的内容
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view{
//    UIView *vw=[[UIView alloc] init];
//    vw.backgroundColor=[UIColor redColor];
//    return vw;
//}
//选中的行号，列号
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSArray *col=self.data[component];
    NSLog(@"已选中 %zd 列，%@ 行", component, col[row]);
    if (component==0) self.shuiguo.text=col[row];
    if (component==1) self.zhushi.text=col[row];
    if (component==2) self.yinliao.text=col[row];
}

@end
