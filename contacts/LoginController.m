//
//  LoginController.m
//  contacts
//
//  Created by wei cui on 2019/11/21.
//  Copyright © 2019 wei cui. All rights reserved.
//

#import "LoginController.h"
#import <MBProgressHUD/MBProgressHUD.h>
@interface LoginController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UISwitch *saveSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *autoLoginSwitch;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_usernameField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [_passwordField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    
    _loginBtn.enabled=_usernameField.text.length && _passwordField.text.length;
}
//文本框内容改变时调用
-(void)textChange
{
    _loginBtn.enabled=_usernameField.text.length && _passwordField.text.length;
    NSLog(@"%@, %@", _usernameField.text, _passwordField.text);
}
//开关状态改变时调用
- (IBAction)savePwd:(id)sender {
    if (_saveSwitch.on==NO) {
        //_autoLoginSwitch.on=NO;
        [_autoLoginSwitch setOn:NO animated:YES];
    }
    NSLog(@"save on=%i", _saveSwitch.on);
}
//开关状态改变时调用
- (IBAction)autoLogin:(id)sender {
    if (_autoLoginSwitch.on==YES) {
           //_saveSwitch.on=YES;
        [_saveSwitch setOn:YES animated:YES];
    }
    NSLog(@"autoLogin on=%i", _autoLoginSwitch.on);
}
/**
 登录
 */
- (IBAction)login:(id)sender {
    //模拟网络延迟 3s
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //code..
      });
        if ([self.usernameField.text isEqualToString:@"admin"] && [self.passwordField.text isEqualToString:@"admin"]) {
            //执行完并不会立即跳转，需要先执行来源控制器的-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender方法
            [self performSegueWithIdentifier:@"login2contacts" sender:nil];
        }else{
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"用户名/密码错误";
            hud.backgroundColor = [UIColor grayColor];
            hud.alpha = 0.8;//设置遮罩透明度
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                // Do something...
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
        }
        
  
}
//跳转之前的准备工作
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UITableViewController *vc=segue.destinationViewController;
    vc.title=[NSString stringWithFormat:@"%@联系人列表", _usernameField.text];
    NSLog(@"来源控制器：%@, 目标控制器：%@", segue.sourceViewController, segue.destinationViewController);
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
