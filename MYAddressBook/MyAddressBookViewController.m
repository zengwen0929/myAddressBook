//
//  MyAddressBookViewController.m
//  我的通讯录
//
//  Created by zhiangkeji on 16/5/24.
//  Copyright © 2016年 zengwen. All rights reserved.
//

#import "MyAddressBookViewController.h"
#import "MBProgressHUD+XMG.h"
#import "ContactViewController.h"

@interface MyAddressBookViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;

@property (weak, nonatomic) IBOutlet UISwitch *rmbPwdSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *autoLoginSwitch;
@end

@implementation MyAddressBookViewController


#define XMGUserDefaults [NSUserDefaults standardUserDefaults]

static NSString *accountKey = @"account";
static NSString *pwdKey = @"pwd";
static NSString *rmbKey = @"rmd";
static NSString *loginKey = @"login";

- (IBAction)login:(id)sender{
    
    
    // 提示用户，正在登录ing...
    [MBProgressHUD showMessage:@"正在登录ing..."];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 隐藏蒙版
        [MBProgressHUD hideHUD];
        
        // 验证下账号和密码是否正确
        if ([_accountField.text isEqualToString:@"zhiangkeji"] && [_pwdField.text isEqualToString:@"123"]) { // 输入正确
            
            
            
            // 数据存储
            
            // 账号，密码，记住密码，自动登录
            [XMGUserDefaults setObject:_accountField.text forKey:accountKey];
            [XMGUserDefaults setObject:_pwdField.text forKey:pwdKey];
            [XMGUserDefaults setBool:_rmbPwdSwitch.on forKey:rmbKey];
            [XMGUserDefaults setBool:_autoLoginSwitch.on forKey:loginKey];
    
            // 直接跳转
            // 跳转到联系人界面
            ContactViewController *contactVC = [[ContactViewController alloc] init];
            contactVC.title = [NSString stringWithFormat:@"%@联系人",self.accountField.text];
            [self.navigationController pushViewController:contactVC animated:YES];
            ;
            
        }else{ // 账号或者密码错误
            
            // 提示用户账号或者密码错误
            [MBProgressHUD showError:@"账号或者密码错误"];
            
        }
        
    });
    
    
    
}

// 记住密码开关状态改变的时候调用
- (IBAction)rmbPwdChange:(id)sender {
    // 如果取消记住密码，自动登录也需要取消勾选
    
    if (_rmbPwdSwitch.on == NO) { // 取消记住密码
        // 取消自动登录
        [_autoLoginSwitch setOn:NO animated:YES];
    }
    
    
}

// 自动登录开关状态改变的时候调用
- (IBAction)autoLoginChange:(id)sender {
    
    // 如果勾选了自动登录,记住密码也要勾选
    if (_autoLoginSwitch.on == YES) {
        [_rmbPwdSwitch setOn:YES animated:YES];
        
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"通讯录";
    
    // 读取数据
    NSString *account = [XMGUserDefaults objectForKey:accountKey];
    NSString *pwd = [XMGUserDefaults objectForKey:pwdKey];
    BOOL rmb = [XMGUserDefaults boolForKey:rmbKey];
    BOOL login = [XMGUserDefaults boolForKey:loginKey];
    
    _accountField.text = account;
    
    if (rmb == YES) {
        _pwdField.text = pwd;
    }
    
    _rmbPwdSwitch.on = rmb;
    _autoLoginSwitch.on = login;
    
    // 勾选自动登录
    if (login == YES) {
        
        [self login:nil];
        
    }
    
    
    // 给文本框添加监听器,及时监听文本框内容的改变
    [_accountField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [_pwdField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [self textChange];
    
}

// 任一一个文本框的内容改变都会调用
- (void)textChange
{
    _loginBtn.enabled = _accountField.text.length && _pwdField.text.length;
    NSLog(@"%@--%@",_accountField.text,_pwdField.text);
}

@end
