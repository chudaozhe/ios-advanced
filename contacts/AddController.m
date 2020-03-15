//
//  AddController.m
//  contacts
//
//  Created by wei cui on 2019/11/23.
//  Copyright © 2019 wei cui. All rights reserved.
//

#import "AddController.h"
#import "Contacts.h"

@interface AddController ()
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *mobileField;

@end

@implementation AddController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_nameField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [_mobileField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    
    _addBtn.enabled=_nameField.text.length && _mobileField.text.length;
  
}
/**
 控制器view完全加载完毕时 调用
 */
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.nameField becomeFirstResponder];//光标定位到 nameField
}

//文本框内容改变时调用
-(void)textChange
{
    _addBtn.enabled=_nameField.text.length && _mobileField.text.length;
    NSLog(@"%@, %@", _nameField.text, _mobileField.text);
}

- (IBAction)add:(id)sender {
    NSLog(@"name=%@, mobile=%@", self.nameField.text, self.mobileField.text);
    Contacts *c= [[Contacts alloc] init];
    c.name=self.nameField.text;
    c.mobile=self.mobileField.text;
    NSLog(@"%@", c);
    
    //self.contactVc.contacts=c;//用代理了，就不要这个了
    //通知代理做事情
    if ([_delegate respondsToSelector:@selector(addController: didClickAddBtnWithContact:)]) {
        [_delegate addController:self didClickAddBtnWithContact: c];
    }
    //3回到上一个控制器
    [self.navigationController popViewControllerAnimated:YES];
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
