//
//  ListController.m
//  contacts
//
//  Created by wei cui on 2019/11/23.
//  Copyright © 2019 wei cui. All rights reserved.
//

#import "ListController.h"
#import "Contacts.h"
#import "AddController.h"
#import "EditController.h"
@interface ListController ()<AddControllerDelegate, EditControllerDelegate>
//要加载的数据
@property (nonatomic, strong) NSMutableArray *data;
@end

@implementation ListController
/* 懒加载  */
 -(NSMutableArray *)data{
    if (_data==nil) {
        _data=[[NSMutableArray alloc] init];
    }
    return _data;
}

-(void)editNotify
{
    NSLog(@"ccc");
    [self.tableView reloadData];
}
//segue无论手动/自动都会调用
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //给add控制器传递 当前控制器（ContactsController）
    AddController *addvc=segue.destinationViewController;
    //addvc.contactVc=self;
    addvc.delegate=self;
}
-(void)addController:(AddController *)addVc didClickAddBtnWithContact:(Contacts *)contacts
{
        NSLog(@"name2=%@,mobile2=%@", contacts.name, contacts.mobile);
        //self.data=data;
        [self.data insertObject:contacts atIndex:0];
        [self.tableView reloadData];
}
- (IBAction)logout:(id)sender {
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"确认注销" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"注销" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        NSLog(@"logout...");
    }]];

    [self presentViewController:alert animated:YES completion:nil];
}
- (IBAction)add:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight=100;
    //数据如果为空，不展示分割线；有数据才展示分割线
    self.tableView.tableFooterView=[[UIView alloc] init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"count:%zd", self.data.count);
    return self.data.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    Contacts *c = self.data[indexPath.row];
    cell.textLabel.text=c.name;
    cell.detailTextLabel.text=c.mobile;
    //cell.imageView.image=[UIImage imageNamed:car.icon];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
//点击某个cell时调用
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"data1:%@", self.data);
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    EditController *editVc=[storyboard instantiateViewControllerWithIdentifier:@"edit"];
    editVc.contact=self.data[indexPath.row];
    editVc.delegate=self;
    editVc.blok=^(){
        NSLog(@"block");
        NSLog(@"data2:%@", self.data);
        [self.tableView reloadData];
    };
    [self.navigationController pushViewController:editVc animated:YES];
    
    Contacts *contacts=self.data[indexPath.row];
    NSLog(@"点击了：%@", contacts.name);
}
/**
 代理方法，侧滑
 */
-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        [self.data removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }else if(editingStyle==UITableViewCellEditingStyleInsert) {
        NSLog(@"add");
    }
    
}
@end
