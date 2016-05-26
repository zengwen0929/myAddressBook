//
//  AddViewController.m
//  MYAddressBook
//
//  Created by zhiangkeji on 16/5/25.
//  Copyright © 2016年 zengwen. All rights reserved.
//

#import "AddViewController.h"
#import "Contact.h"
#import "ContactViewController.h"

@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end

@implementation AddViewController

// 点击添加的时候调用
- (IBAction)add:(id)sender {
    // 0.把文本框的值包装成联系人模型
    Contact *c = [Contact contactWithName:_nameField.text phone:_phoneField.text];


    if (_block) {
        self.block(c);
    }
    // 2.回到联系人控制器
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 给文本框添加监听器,及时监听文本框内容的改变
    [_nameField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [_phoneField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 主动弹出姓名文本框
    [_nameField becomeFirstResponder];
}

// 任一一个文本框的内容改变都会调用
- (void)textChange
{
    _addBtn.enabled = _nameField.text.length && _phoneField.text.length;
    
}

@end
