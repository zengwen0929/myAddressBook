//
//  MyAddressBookViewController.h
//  我的通讯录
//
//  Created by zhiangkeji on 16/5/24.
//  Copyright © 2016年 zengwen. All rights reserved.
//

#import "ContactViewController.h"
#import "AddViewController.h"
#import "Contact.h"
#import "EditViewController.h"

#define ZWFilePath  [ NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"contacts.data"]
@interface ContactViewController ()<UIActionSheetDelegate>
@property (nonatomic, strong) NSMutableArray *contacts;

@end

@implementation ContactViewController

- (NSMutableArray *)contacts
{
    if (_contacts == nil) {
        
        // 读取数据
        _contacts = [NSKeyedUnarchiver unarchiveObjectWithFile:ZWFilePath];
        
        // 判断下有没有读取数据
        if (_contacts == nil) {
            _contacts = [NSMutableArray array];
        }
        
    }
    return _contacts;
}




// 点击注销的时候调用
-(void)zhuxiao{
    
  //  self.navigationController.navigationItem
    // 弹出actionSheet
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"是否注销?" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"注销" otherButtonTitles:nil, nil];
    
    [sheet showInView:self.view];
    
}
- (void)add{

    AddViewController *addVc = [[AddViewController alloc] init];
    addVc.block = ^(Contact *contact){
    
        [self.contacts addObject:contact];
        
        [self.tableView reloadData];
        // 3.保存联系人,注意：如果归档数组，底层会遍历数组元素一个一个归档
        [NSKeyedArchiver archiveRootObject:self.contacts toFile:ZWFilePath];
    };
    
    
    [self.navigationController pushViewController:addVc animated:YES];
    
}

#pragma mark - UIActionSheetDelegate
// 点击UIActionSheet控件上的按钮调用
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) { // 点击了注销
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIBarButtonItem *btn0 = [[UIBarButtonItem alloc] initWithTitle:@"注销"
                style:UIBarButtonItemStylePlain
               target:self
               action:@selector(zhuxiao)];

    //注册
    UIBarButtonItem *btn1 = [[UIBarButtonItem alloc]                         initWithTitle:@"添加"style:UIBarButtonItemStylePlain
                            target:self
                            action:@selector(add)];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:btn0, btn1, nil];

}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.contacts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 创建标示符
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    // 获取模型
    Contact *c = self.contacts[indexPath.row];
    
    cell.textLabel.text = c.name;
    cell.detailTextLabel.text = c.phone;
    
    
    return cell;
}
#pragma mark - tableView代理方法
// 点击cell的时候调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    // 创建编辑控制器
    EditViewController *editVc = [[EditViewController alloc] init];

    editVc.contact = self.contacts[indexPath.row];
    
    // block：点击编辑的时候调用这个block
    editVc.block = ^(){ // 刷新表格
        [self.tableView reloadData];
        // 3.保存联系人,注意：如果归档数组，底层会遍历数组元素一个一个归档
        [NSKeyedArchiver archiveRootObject:self.contacts toFile:ZWFilePath];
    };
    
    // 跳转到编辑界面
    [self.navigationController pushViewController:editVc animated:YES];
    
}

// 只要实现这个方法，就会有滑动删除功能
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 删除模型
    [self.contacts removeObjectAtIndex:indexPath.row];
    
    // 删除tableViewCell
    
    
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"增加" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        // 点击增加的时候调用
        NSLog(@"增加");
        
    }];
    action.backgroundColor = [UIColor greenColor];
    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        // 点击增加的时候调用
        NSLog(@"删除");
        
    }];
    
    
    return @[action,action1];
}
@end
