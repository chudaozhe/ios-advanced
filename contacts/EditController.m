//
//  EditController.m
//  contacts
//
//  Created by wei cui on 2019/11/24.
//  Copyright © 2019 wei cui. All rights reserved.
//

#import "EditController.h"
#import "Contacts.h"
@interface EditController ()
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *mobileField;
@end

@implementation EditController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self 栈顶控制器
    //导航条标题
    self.title=@"编辑按钮";
    //导航条右侧按钮
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(showEdit:)];
    //复值
    self.nameField.text=_contact.name;
    self.mobileField.text=_contact.mobile;
}

-(void)showEdit:(UIBarButtonItem *)item
{
    //1更改标题
    //2弹出电话文本框键盘
    //3显示保存按钮
    NSLog(@"show edit..");
    if ([item.title isEqualToString:@"编辑"]) {
        item.title=@"取消";
        self.nameField.enabled=YES;
        self.mobileField.enabled=YES;
        [self.mobileField becomeFirstResponder];
        _editBtn.hidden=NO;
        
    }else{
        item.title=@"编辑";
        //[self.view endEditing:YES];
        self.nameField.enabled=NO;
        self.mobileField.enabled=NO;
        _editBtn.hidden=YES;
        //还原
        self.nameField.text=_contact.name;
        self.mobileField.text=_contact.mobile;
    }
    
   
}
/**
 控制器view完全加载完毕时 调用
 */
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.nameField becomeFirstResponder];//光标定位到 nameField
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)edit:(id)sender {
    NSLog(@"do edit..");
    _contact.name=self.nameField.text;
    _contact.mobile=self.mobileField.text;
    
    //2代理通知list控制器刷新表格，或block
//    if ([_delegate respondsToSelector:@selector(editNotify)]) {
//        [_delegate editNotify];
//    }
    if (_blok) {
        _blok();
    }
    
    //3回到上一个控制器
    [self.navigationController popViewControllerAnimated:YES];
}

@end
