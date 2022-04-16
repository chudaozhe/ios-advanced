//
//  KeyboardController.m
//  keyboard
//  参考：https://www.jianshu.com/p/5edc26812129
//  Created by wei cui on 2020/3/22.
//  Copyright © 2020 wei cui. All rights reserved.
//

#import "KeyboardController.h"
#import "OneController.h"
@interface KeyboardController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIView *customInputView;
@property (nonatomic, strong) UIToolbar *customAccessoryView;

@property (nonatomic, strong) UISearchBar *searchBar;
@end

@implementation KeyboardController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(100, 300, 100, 30)];
    btn.backgroundColor=[UIColor blueColor];
    [btn setTitle:@"下一页" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [self createUI];
    //[self createFootView];
}
- (void)createUI{
    [self.view addSubview:self.textField];
//    self.textField.inputView = self.customInputView;//自定义键盘view
    self.textField.inputAccessoryView = self.customAccessoryView;
    
}
- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(50, 180, CWScreenW - 100, 30)];
        _textField.layer.borderWidth = 1.0;
        _textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _textField.layer.cornerRadius = 4.0;
        _textField.placeholder = @"测试";
        _textField.delegate=self;
    }
    return _textField;
}
#pragma mark - 自定义键盘view
- (UIView *)customInputView{
    if (!_customInputView) {
        //1UIView
        _customInputView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CWScreenW, 261)];
        _customInputView.backgroundColor = [UIColor lightGrayColor];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, CWScreenW, 40)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"自定义inputView";
        [_customInputView addSubview:label];
        //2 or UIPickerView
//        _customInputView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, CWScreenW, 300)];
//        _customInputView.backgroundColor = [UIColor redColor];
        
    }
    return _customInputView;
}
#pragma mark - 键盘的辅助视图
- (UIToolbar *)customAccessoryView{
    if (!_customAccessoryView) {
        _customAccessoryView = [[UIToolbar alloc]initWithFrame:(CGRect){0,0,CWScreenW,40}];
        _customAccessoryView.barTintColor = [UIColor orangeColor];
        UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *finish = [[UIBarButtonItem alloc]initWithTitle:@"完成2" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
        [_customAccessoryView setItems:@[space,space,finish]];
    }
    return _customAccessoryView;
}
#pragma mark - 点击键盘done 隐藏键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_textField resignFirstResponder];
    return YES;
}

#pragma mark - 点击空白区域隐藏键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_textField resignFirstResponder];
}
- (void)done{
    [self.textField resignFirstResponder];
}
#pragma mark - 底部评论框
-(void)createFootView{
    UIView *foot=[[UIView alloc] initWithFrame:CGRectMake(0, CWScreenH-80, CWScreenW, 80)];
    foot.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:foot];
    //输入框
    UITextField *textField=[[UITextField alloc] initWithFrame:CGRectMake(20, 10, CWScreenW-80, 40)];
    textField.backgroundColor=[UIColor lightGrayColor];
    UIView *test=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    test.backgroundColor=[UIColor grayColor];
    textField.inputAccessoryView=foot;
    
    [foot addSubview:textField];
    //表情
    UIImageView *phiz=[[UIImageView alloc] initWithFrame:CGRectMake(CWScreenW-46, 16, 30, 30)];
    phiz.image=[UIImage imageNamed:@"jiahao"];
    [foot addSubview:phiz];
}
-(void)jump{
    OneController *vc=[[OneController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
