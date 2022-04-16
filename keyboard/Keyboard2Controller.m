//
//  Keyboard2Controller.m
//  keyboard
//
//  Created by wei cui on 2020/3/23.
//  Copyright © 2020 wei cui. All rights reserved.
//

#import "Keyboard2Controller.h"

@interface Keyboard2Controller ()<UITextFieldDelegate>
/** 备注 */
@property (strong, nonatomic) UITextField *textField1;
@end

@implementation Keyboard2Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.textField1 = [[UITextField alloc] initWithFrame:CGRectMake(10, CWScreenH-80, CWScreenW-20, 40)];
    self.textField1.placeholder = @"请输入邮箱";
    self.textField1.layer.cornerRadius = 5;
    self.textField1.borderStyle = UITextBorderStyleRoundedRect;
    self.textField1.delegate = self;
    [self.view addSubview:self.textField1];
    
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
    [btn setTitle:@"点击" forState:UIControlStateNormal];
    btn.backgroundColor=[UIColor blueColor];
    [btn addTarget:self action:@selector(doIt) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
-(void)doIt{
    CGRect frame = self.view.frame;
    frame.origin.y = -190;
    self.view.frame = frame;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    CGFloat keyboardHeight=216+50;
    CGFloat offset = self.view.frame.size.height - (kNavBarAndStatusBarHeight+textField.frame.origin.y + textField.frame.size.height + keyboardHeight);
    NSLog(@"offset:%f", offset);
    NSLog(@"self.view.frame.size.height:%f", self.view.frame.size.height);
    NSLog(@"textField.frame.origin.y:%f", textField.frame.origin.y);
    NSLog(@"textField.frame.size.height:%f", textField.frame.size.height);
    //是否需要调整textField的y值
    if (offset <= 0){
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = self.view.frame;
            frame.origin.y = offset;
            NSLog(@"调整后的frame.origin.y:%f", frame.origin.y);
            self.view.frame = frame;
        }];
    }
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.1 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0;
        self.view.frame = frame;

    }];
    return YES;
}
#pragma mark - 点击键盘done 隐藏键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_textField1 resignFirstResponder];
    return YES;
}

#pragma mark - 点击空白区域隐藏键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_textField1 resignFirstResponder];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
